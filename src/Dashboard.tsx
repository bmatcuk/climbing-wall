import type { FunctionComponent } from "preact"
import {
  useCallback,
  useEffect,
  useReducer,
  useRef,
  useState,
} from "preact/hooks"

import RouteItem from "./RouteItem"
import EditRouteItem from "./EditRouteItem"
import type { User } from "./api/user"
import {
  CompletedRoute,
  NewRoute,
  Room,
  Route,
  Section,
  Setter,
  SubSection,
  getCompletedRoutes,
  getRooms,
  getRoutes,
  getSections,
  getSetters,
  getSubSections,
  markRouteComplete,
  markRouteIncomplete,
  reorderRoutes,
  saveRoute,
} from "./api/routes"
import { mapArray, mapOf, zeroPad } from "./utils"
import { completedRoutesReducer } from "./completed-routes-reducer"

import styles from "./dashboard.module.css"

type Props = {
  jwt: string
  user: User
}

const ROUTE_SORTS = {
  "Left-to-Right": (a: Route, b: Route) => a.sort - b.sort,
  Difficulty: (a: Route, b: Route) => {
    if (a.difficulty === null) {
      if (b.difficulty === null) {
        return a.id - b.id
      }
      return -1
    } else if (b.difficulty === null) {
      return 1
    }

    let sort = a.difficulty - b.difficulty
    if (sort === 0) {
      sort = a.difficulty_mod - b.difficulty_mod
      if (sort === 0) {
        sort = a.id - b.id
      }
    }
    return sort
  },
}

/**
 * Updates the route table with the given updates
 * @param table The table to update
 * @param updates The updated route(s)
 * @returns a new table
 */
function updateRouteTable(
  table: Map<number, Route[]>,
  updates: Route[],
  sortBy: keyof typeof ROUTE_SORTS
): Map<number, Route[]> {
  const newTable = new Map(table)
  const updatedSubSections = new Set<number>()
  updates.forEach((update) => {
    let routes = newTable.get(update.subsection_id)
    if (routes) {
      if (!updatedSubSections.has(update.subsection_id)) {
        routes = [...routes]
        newTable.set(update.subsection_id, routes)
        updatedSubSections.add(update.subsection_id)
      }

      const idx = routes.findIndex((r) => r.id === update.id)
      if (idx === -1) {
        if (update.active) {
          routes.push(update)
        }
      } else if (update.active) {
        routes[idx] = update
      } else {
        routes.splice(idx, 1)
      }
    }
  })
  updatedSubSections.forEach((ssid) => {
    const lst = newTable.get(ssid)
    if (lst) {
      lst.sort(ROUTE_SORTS[sortBy])
    }
  })
  return newTable
}

/**
 * @param routes The route table
 * @param subsection_id The subsection id
 * @returns a new route object
 */
function buildNewRoute(
  routes: Map<number, Route[]>,
  subsection_id: number
): NewRoute {
  const today = new Date()
  const sort =
    (routes.get(subsection_id) || []).reduce((m, r) => Math.max(m, r.sort), 0) +
    1
  return {
    subsection_id,
    difficulty: null,
    difficulty_mod: 0,
    color1: null,
    color2: null,
    symbol: null,
    setter1_id: 7,
    setter2_id: null,
    description: null,
    set_on: `${today.getFullYear()}-${zeroPad(today.getMonth() + 1)}-${zeroPad(
      today.getDate()
    )}`,
    sort,
  }
}

/**
 * @param routes A list of routes
 * @param editing True if editing this subsection
 * @param reorderedIds A list of route ids in the desired order
 * @returns the routes in the specified order
 */
function getOrderedRoutes(
  routes: Route[],
  editing: boolean,
  reorderedIds: number[] | undefined
): Route[] {
  if (editing) {
    if (reorderedIds) {
      const m = new Map<number, Route>()
      routes.forEach((r) => m.set(r.id, r))
      return reorderedIds.map((id) => m.get(id)).filter(Boolean) as Route[]
    }

    const lst = [...routes]
    lst.sort((a, b) => a.sort - b.sort)
    return lst
  }
  return routes
}

/** @returns the default route sort from localStorage */
function getRouteSort(): keyof typeof ROUTE_SORTS {
  const sort = localStorage.getItem("routesort")
  if (sort && sort in ROUTE_SORTS) {
    return sort as keyof typeof ROUTE_SORTS
  }
  return "Left-to-Right"
}

const Dashboard: FunctionComponent<Props> = ({ jwt, user }) => {
  const [sortRoutesBy, setSortRoutesBy] = useState(getRouteSort)
  const [rooms, setRooms] = useState<Room[] | undefined>()
  const [selectedRoomId, setSelectedRoomId] = useState(0)
  const [sections, setSections] = useState<Map<number, Section[]> | undefined>()
  const [subsections, setSubSections] = useState<
    Map<number, SubSection[]> | undefined
  >()
  const [setters, setSetters] = useState<Map<number, Setter> | undefined>()
  const [routes, setRoutes] = useState<Map<number, Route[]> | undefined>()
  const [completedRoutes, dispatchCompletedRoutes] = useReducer(
    completedRoutesReducer,
    new Map<number, CompletedRoute>()
  )
  const [editing, setEditing] = useState<number | undefined>()
  const [reorderedIds, setReorderedIds] = useState<number[] | undefined>()
  const draggingRoute = useRef<Route>()

  const updateRouteSort = useCallback((evt: Event) => {
    const target = evt.target as HTMLSelectElement
    const value = target.value as keyof typeof ROUTE_SORTS
    setSortRoutesBy(value as keyof typeof ROUTE_SORTS)
    localStorage.setItem("routesort", value)

    setRoutes((routes) => {
      if (routes) {
        const newRoutes = new Map() as typeof routes
        for (const [key, lst] of routes) {
          const newLst = [...lst]
          newLst.sort(ROUTE_SORTS[value])
          newRoutes.set(key, newLst)
        }
        return newRoutes
      }
      return routes
    })
  }, [])

  const switchRooms = useCallback((evt: Event) => {
    evt.preventDefault()
    const target = evt.target as HTMLAnchorElement
    const roomId = Number(target.dataset.roomId)
    setSelectedRoomId(roomId)
  }, [])

  const doMarkRouteComplete = useCallback(
    (routeId: number) =>
      markRouteComplete(jwt, user.uid, routeId).then((completedRoute) => {
        dispatchCompletedRoutes({ type: "complete", completedRoute })
      }),
    [jwt, user]
  )

  const doMarkRouteIncomplete = useCallback(
    (routeId: number) =>
      markRouteIncomplete(jwt, user.uid, routeId).then(() => {
        dispatchCompletedRoutes({ type: "incomplete", routeId })
      }),
    [jwt, user]
  )

  const toggleEditing = useCallback((evt: Event) => {
    evt.preventDefault()

    const target = evt.target as HTMLAnchorElement
    const subsectionId = Number(target.dataset.subsectionId)
    setEditing((v) => (v === subsectionId ? undefined : subsectionId))
    setReorderedIds(undefined)
  }, [])

  const doSaveRoute = useCallback(
    (route: NewRoute | Route) =>
      saveRoute(jwt, route).then((savedRoute) => {
        setRoutes((r) => r && updateRouteTable(r, [savedRoute], sortRoutesBy))
      }),
    [jwt, sortRoutesBy]
  )

  const dragStart = useCallback(
    (route: Route, evt: DragEvent) => {
      if (evt.dataTransfer) {
        const { innerText, outerHTML } = evt.target as HTMLLIElement
        evt.dataTransfer.setData("text/plain", innerText)
        evt.dataTransfer.setData("text/html", outerHTML)
        evt.dataTransfer.dropEffect = "move"

        const routeList = [...(routes?.get(route.subsection_id) || [])]
        routeList.sort((a, b) => a.sort - b.sort)
        setReorderedIds(routeList.map((route) => route.id))
        draggingRoute.current = route
      }
    },
    [routes]
  )

  const dragOver = useCallback((route: Route, evt: DragEvent) => {
    evt.preventDefault()
    if (evt.dataTransfer) {
      evt.dataTransfer.dropEffect = "move"

      setReorderedIds((reorderedIds) => {
        if (
          reorderedIds &&
          draggingRoute.current &&
          draggingRoute.current.id !== route.id
        ) {
          const draggingIdx = reorderedIds.indexOf(draggingRoute.current.id)
          const thisIdx = reorderedIds.indexOf(route.id)
          const newReorderedIds = [...reorderedIds]
          newReorderedIds.splice(draggingIdx, 1)
          newReorderedIds.splice(thisIdx, 0, draggingRoute.current.id)
          return newReorderedIds
        }
        return reorderedIds
      })
    }
  }, [])

  const dragEnd = useCallback(
    (evt: DragEvent) => {
      evt.preventDefault()
      if (
        evt.dataTransfer &&
        evt.dataTransfer.dropEffect === "move" &&
        reorderedIds
      ) {
        const idSortMap = reorderedIds.map((id, sort) => ({ id, sort }))
        reorderRoutes(jwt, idSortMap).then((updatedRoutes) => {
          setRoutes(
            (r) => r && updateRouteTable(r, updatedRoutes, sortRoutesBy)
          )
          setReorderedIds(undefined)
        })
      } else {
        setReorderedIds(undefined)
      }
    },
    [reorderedIds, sortRoutesBy]
  )

  useEffect(() => {
    getRooms(jwt).then((rooms) => {
      setRooms(rooms)
      setSelectedRoomId(rooms[0].id)
    })
    getSections(jwt).then((sections) => {
      setSections(mapArray(sections, "room_id", "sort"))
    })
    getSubSections(jwt).then((subsections) => {
      setSubSections(mapArray(subsections, "section_id", "sort"))
    })
    getSetters(jwt).then((setters) => {
      setSetters(mapOf(setters, "id"))
    })
    getRoutes(jwt).then((routes) => {
      setRoutes(mapArray(routes, "subsection_id", ROUTE_SORTS[sortRoutesBy]))
    })
    getCompletedRoutes(jwt).then((completedRoutes) => {
      dispatchCompletedRoutes({ type: "init", completedRoutes })
    })
  }, [jwt])

  if (
    !rooms ||
    !sections ||
    !subsections ||
    !setters ||
    !routes ||
    !completedRoutes
  ) {
    return <h2>Loading...</h2>
  }

  return (
    <section>
      <header>
        <menu class={styles["room-switcher"]}>
          {rooms.map((room) => (
            <li
              key={`room${room.id}`}
              class={room.id === selectedRoomId ? styles.active : undefined}
            >
              <a href="#" data-room-id={room.id} onClick={switchRooms}>
                {room.name}
              </a>
            </li>
          ))}
        </menu>
        <label class={styles["sort-routes-by"]}>
          Sort Routes by:&nbsp;
          <select onChange={updateRouteSort} value={sortRoutesBy}>
            {Object.keys(ROUTE_SORTS).map((s) => (
              <option value={s}>{s}</option>
            ))}
          </select>
        </label>
      </header>
      {(sections.get(selectedRoomId) || []).map((section) => (
        <section key={`section${section.id}`}>
          <header>
            <h2>{section.name}</h2>
          </header>
          {(subsections.get(section.id) || []).map((subsection) => (
            <section key={`subsection${subsection.id}`}>
              {(selectedRoomId === 1 || user.role === "webadmin") && (
                <header>
                  <h3>
                    {subsection.name}
                    {user.role === "webadmin" && (
                      <small>
                        &nbsp;
                        <a
                          href="#"
                          class={`${styles.edit} ${
                            subsection.id === editing ? styles.active : ""
                          }`}
                          onClick={toggleEditing}
                          data-subsection-id={subsection.id}
                        >
                          &#9998;
                        </a>
                      </small>
                    )}
                  </h3>
                </header>
              )}
              <ol>
                {getOrderedRoutes(
                  routes.get(subsection.id) || [],
                  editing === subsection.id,
                  editing === subsection.id ? reorderedIds : undefined
                ).map((route) =>
                  editing === subsection.id ? (
                    <EditRouteItem
                      key={`route${route.id}`}
                      route={route}
                      setters={setters}
                      toprope={selectedRoomId === 2}
                      saveRoute={doSaveRoute}
                      dragStart={dragStart}
                      dragOver={dragOver}
                      drop={dragOver}
                      dragEnd={dragEnd}
                    />
                  ) : (
                    <RouteItem
                      key={`route${route.id}`}
                      route={route}
                      setters={setters}
                      toprope={selectedRoomId === 2}
                      completed={completedRoutes.get(route.id)}
                      markRouteComplete={doMarkRouteComplete}
                      markRouteIncomplete={doMarkRouteIncomplete}
                    />
                  )
                )}
                {editing === subsection.id && (
                  <EditRouteItem
                    route={buildNewRoute(routes, subsection.id)}
                    setters={setters}
                    toprope={selectedRoomId === 2}
                    saveRoute={doSaveRoute}
                    dragStart={dragStart}
                    dragOver={dragOver}
                    drop={dragOver}
                    dragEnd={dragEnd}
                  />
                )}
              </ol>
            </section>
          ))}
        </section>
      ))}
    </section>
  )
}

export default Dashboard

import type { FunctionComponent } from "preact"
import { useCallback, useEffect, useReducer, useState } from "preact/hooks"

import RouteItem from "./RouteItem"
import type { User } from "./api/user"
import {
  Room,
  Section,
  SubSection,
  Setter,
  Route,
  CompletedRoute,
  getRooms,
  getSections,
  getSubSections,
  getSetters,
  getRoutes,
  getCompletedRoutes,
  markRouteComplete,
  markRouteIncomplete,
} from "./api/routes"

import styles from "./dashboard.module.css"

type Props = {
  jwt: string
  user: User
}

/**
 * Essentially does a "group by" and sort on an array.
 * @param ary The array to group and sort
 * @param mapBy The property to group by
 * @param sortBy The property to sort the groups by
 * @returns a map of groups
 */
function mapArray<
  T extends Record<S, number>,
  K extends keyof T,
  S extends { [P in keyof T]: T[P] extends number ? P : never }[keyof T]
>(ary: T[], mapBy: K, sortBy: S): Map<T[K], T[]> {
  const map = new Map<T[K], T[]>()
  ary.forEach((item) => {
    let lst = map.get(item[mapBy])
    if (!lst) {
      lst = []
      map.set(item[mapBy], lst)
    }
    lst.push(item)
  })
  map.forEach((lst) => lst.sort((a, b) => a[sortBy] - b[sortBy]))
  return map
}

/**
 * Given an array, produces a map of an id to those objects
 * @param ary The array
 * @param mapBy The key
 * @returns a map
 */
function mapOf<T, K extends keyof T>(ary: T[], mapBy: K): Map<T[K], T> {
  const map = new Map<T[K], T>()
  ary.forEach((item) => {
    map.set(item[mapBy], item)
  })
  return map
}

type InitializeAction = {
  type: "init"
  completedRoutes: CompletedRoute[]
}

type CompleteAction = {
  type: "complete"
  completedRoute: CompletedRoute
}

type IncompleteAction = {
  type: "incomplete"
  routeId: number
}

type Actions = InitializeAction | CompleteAction | IncompleteAction

function completedRoutesReducer(
  state: Map<number, CompletedRoute>,
  action: Actions
): Map<number, CompletedRoute> {
  switch (action.type) {
    case "init":
      return mapOf(action.completedRoutes, "route_id")

    case "complete": {
      const newState = new Map(state)
      newState.set(action.completedRoute.route_id, action.completedRoute)
      return newState
    }

    case "incomplete": {
      const newState = new Map(state)
      newState.delete(action.routeId)
      return newState
    }
  }
  return state
}

const Dashboard: FunctionComponent<Props> = ({ jwt, user }) => {
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
      setRoutes(mapArray(routes, "subsection_id", "sort"))
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
      </header>
      {(sections.get(selectedRoomId) || []).map((section) => (
        <section key={`section${section.id}`}>
          <header>
            <h2>{section.name}</h2>
          </header>
          {(subsections.get(section.id) || []).map((subsection) => (
            <section key={`subsection${subsection.id}`}>
              {selectedRoomId === 1 && (
                <header>
                  <h3>{subsection.name}</h3>
                </header>
              )}
              <ol>
                {(routes.get(subsection.id) || []).map((route) => (
                  <RouteItem
                    key={`route${route.id}`}
                    route={route}
                    setters={setters}
                    toprope={selectedRoomId === 2}
                    completed={completedRoutes.get(route.id)}
                    markRouteComplete={doMarkRouteComplete}
                    markRouteIncomplete={doMarkRouteIncomplete}
                  />
                ))}
              </ol>
            </section>
          ))}
        </section>
      ))}
    </section>
  )
}

export default Dashboard

import type { FunctionComponent } from "preact"
import { useCallback, useState } from "preact/hooks"

import type { Route, Setter, CompletedRoute } from "./api/routes"
import RouteItemDisplay from "./RouteItemDisplay"

import styles from "./routeitem.module.css"

type Props = {
  route: Route
  setters: Map<number, Setter>
  toprope: boolean
  completed?: CompletedRoute
  markRouteComplete(routeId: number): Promise<void>
  markRouteIncomplete(routeId: number): Promise<void>
}

const RouteItem: FunctionComponent<Props> = ({
  route,
  setters,
  toprope,
  completed,
  markRouteComplete,
  markRouteIncomplete,
}) => {
  const [toggling, setToggling] = useState(false)

  const toggle = useCallback(
    (evt: Event) => {
      const { checked } = evt.target as HTMLInputElement
      const func = checked ? markRouteComplete : markRouteIncomplete
      setToggling(true)
      func(route.id).then(() => setToggling(false))
    },
    [route, markRouteComplete, markRouteIncomplete]
  )

  return (
    <li class={styles["route-item"]}>
      <label>
        <input
          type="checkbox"
          checked={Boolean(completed)}
          onChange={toggle}
          disabled={toggling}
        />
        <RouteItemDisplay route={route} setters={setters} toprope={toprope} />
      </label>
    </li>
  )
}

export default RouteItem

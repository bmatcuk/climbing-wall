import type { FunctionComponent } from "preact"
import { useCallback, useState } from "preact/hooks"

import type { Route, Setter, CompletedRoute } from "./api/routes"

import styles from "./routeitem.module.css"

type Props = {
  route: Route
  setters: Map<number, Setter>
  toprope: boolean
  completed?: CompletedRoute
  markRouteComplete(routeId: number): Promise<void>
  markRouteIncomplete(routeId: number): Promise<void>
}

/**
 * @param route A route
 * @param toprope Difficulties are different in top-rope
 * @returns a string representing the route's difficulty
 */
function difficulty(
  { difficulty, difficulty_mod }: Route,
  toprope: boolean
): string {
  if (toprope) {
    if (difficulty === 1) {
      return "EASY"
    } else if (difficulty === 2) {
      return "MOD"
    } else if (difficulty === 3) {
      return "HARD"
    }
    return "?"
  }
  if (!difficulty) {
    return "V?"
  }

  const mod = difficulty_mod < 0 ? "-" : difficulty_mod > 0 ? "+" : ""
  return `V${difficulty === -1 ? "B" : difficulty}${mod}`
}

const SetterAbbr: FunctionComponent<{ setter: Setter | undefined }> = ({
  setter,
}) => (
  <abbr title={setter ? setter.name : "(?)"}>
    {setter ? setter.abbr : "(?)"}
  </abbr>
)

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
        <strong>{difficulty(route, toprope)}</strong>
        &nbsp;
        {route.description}
        &nbsp;
        {route.setter2_id ? (
          <small>
            <SetterAbbr setter={setters.get(route.setter1_id)} />
            +
            <SetterAbbr setter={setters.get(route.setter2_id)} />
          </small>
        ) : (
          <small>
            <SetterAbbr setter={setters.get(route.setter1_id)} />
          </small>
        )}
      </label>
    </li>
  )
}

export default RouteItem

import type { FunctionComponent } from "preact"

import { Route, NewRoute, Setter, isRouteSaved } from "./api/routes"
import RouteColors from "./RouteColors"
import styles from "./routeitem.module.css"

type Props = {
  route: NewRoute | Route
  setters: Map<number, Setter>
  toprope: boolean
}

/**
 * @param route A route
 * @param toprope Difficulties are different in top-rope
 * @returns a string representing the route's difficulty
 */
export function difficultyToString(
  difficulty: number | null,
  difficultyMod: number,
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
  if (difficulty === null) {
    return "V?"
  }

  const mod = difficultyMod < 0 ? "-" : difficultyMod > 0 ? "+" : ""
  return `V${difficulty === -1 ? "B" : difficulty}${mod}`
}

const SetterAbbr: FunctionComponent<{ setter: Setter | undefined }> = ({
  setter,
}) => (
  <abbr title={setter ? setter.name : "(?)"}>
    {setter ? setter.abbr : "(?)"}
  </abbr>
)

const RouteItemDisplay: FunctionComponent<Props> = ({
  route,
  setters,
  toprope,
}) => {
  const isSaved = isRouteSaved(route)
  return (
    <>
      <span>
        <RouteColors
          color1={route.color1}
          color2={route.color2}
          symbol={route.symbol}
        />
      </span>
      <strong>
        {difficultyToString(route.difficulty, route.difficulty_mod, toprope)}
      </strong>
      <span class={styles.description}>
        {isSaved ? route.description : <em>Add New Route</em>}
      </span>
      {isSaved && (
        <>
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
          {route.set_on && (
            <small>
              {Number(route.set_on.substr(5, 2))}/
              {Number(route.set_on.substr(8, 2))}
            </small>
          )}
        </>
      )}
    </>
  )
}

export default RouteItemDisplay

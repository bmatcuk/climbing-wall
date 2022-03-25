import { mapOf } from "./utils"
import type { CompletedRoute } from "./api/routes"

export type InitializeAction = {
  type: "init"
  completedRoutes: CompletedRoute[]
}

export type CompleteAction = {
  type: "complete"
  completedRoute: CompletedRoute
}

export type IncompleteAction = {
  type: "incomplete"
  routeId: number
}

export type Actions = InitializeAction | CompleteAction | IncompleteAction

/**
 * Reducer for completed routes
 * @param state The current state
 * @param action An action
 * @returns the new state
 */
export function completedRoutesReducer(
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

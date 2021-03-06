export type Room = {
  id: number
  name: string
}

export type Section = {
  id: number
  room_id: number
  name: string
  sort: number
}

export type SubSection = {
  id: number
  section_id: number
  name: string
  sort: number
}

export type Setter = {
  id: number
  abbr: string
  name: string
}

export type Route = {
  id: number
  subsection_id: number
  difficulty: number | null
  difficulty_mod: number
  color1: string | null
  color2: string | null
  symbol: string | null
  setter1_id: number
  setter2_id: number | null
  description: string | null
  active: boolean
  set_on: string | null
  updated_on: string | null
  sort: number
}

export type NewRoute = Omit<Route, "id" | "active" | "updated_on">

export type CompletedRoute = {
  route_id: number
  rating: number
}

export async function getRooms(jwt: string): Promise<Room[]> {
  let response: Response | null = null
  try {
    const url = new URL("rooms", process.env.API_BASE)
    url.searchParams.set("select", "id,name")
    url.searchParams.set("order", "sort")

    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return await response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function getSections(jwt: string): Promise<Section[]> {
  let response: Response | null = null
  try {
    const url = new URL("sections", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return await response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function getSubSections(jwt: string): Promise<SubSection[]> {
  let response: Response | null = null
  try {
    const url = new URL("subsections", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function getSetters(jwt: string): Promise<Setter[]> {
  let response: Response | null = null
  try {
    const url = new URL("setters", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function getRoutes(jwt: string): Promise<Route[]> {
  let response: Response | null = null
  try {
    const url = new URL("routes", process.env.API_BASE)
    url.searchParams.set("active", "is.true")

    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export function isRouteSaved(route: NewRoute | Route): route is Route {
  return "id" in route && typeof route.id === "number"
}

export async function saveRoute(
  jwt: string,
  route: NewRoute | Route
): Promise<Route> {
  const update = isRouteSaved(route)
  let response: Response | null = null
  try {
    const url = new URL("routes", process.env.API_BASE)
    if (update) {
      url.searchParams.set("id", `eq.${route.id}`)
    }

    response = await fetch(url.toString(), {
      method: update ? "PATCH" : "POST",
      body: JSON.stringify(route),
      headers: {
        Accept: "application/vnd.pgrst.object+json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
        Prefer: "return=representation",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function getCompletedRoutes(
  jwt: string
): Promise<CompletedRoute[]> {
  let response: Response | null = null
  try {
    const url = new URL("completed_routes", process.env.API_BASE)
    url.searchParams.set("route.active", "is.true")

    response = await fetch(url.toString(), {
      method: "GET",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function markRouteComplete(
  jwt: string,
  user_id: number,
  route_id: number
): Promise<CompletedRoute> {
  let response: Response | null = null
  try {
    const url = new URL("completed_routes", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "POST",
      body: JSON.stringify({ user_id, route_id }),
      headers: {
        Accept: "application/vnd.pgrst.object+json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
        Prefer: "return=representation",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function markRouteIncomplete(
  jwt: string,
  user_id: number,
  route_id: number
): Promise<void> {
  let response: Response | null = null
  try {
    const url = new URL("completed_routes", process.env.API_BASE)
    url.searchParams.set("user_id", `eq.${user_id}`)
    url.searchParams.set("route_id", `eq.${route_id}`)

    response = await fetch(url.toString(), {
      method: "DELETE",
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (!response.ok) {
    const err = await response.json()
    throw err.message
  }
}

export async function reorderRoutes(
  jwt: string,
  idSortMap: Array<{ id: number; sort: number }>
): Promise<Route[]> {
  let response: Response | null = null
  try {
    const url = new URL("rpc/reorder_routes", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "POST",
      body: JSON.stringify(idSortMap),
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
        Prefer: "params=single-object",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    return response.json()
  } else {
    const err = await response.json()
    throw err.message
  }
}

export async function retireSubSection(
  jwt: string,
  subsectionId: number
): Promise<void> {
  let response: Response | null = null
  try {
    const url = new URL("routes", process.env.API_BASE)
    url.searchParams.set("subsection_id", `eq.${subsectionId}`)
    url.searchParams.set("active", "is.true")

    response = await fetch(url.toString(), {
      method: "PATCH",
      body: JSON.stringify({ active: false }),
      headers: {
        Accept: "application/json",
        Authorization: `Bearer ${jwt}`,
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (!response.ok) {
    const err = await response.json()
    throw err.message
  }
}

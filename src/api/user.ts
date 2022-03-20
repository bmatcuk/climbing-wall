export type User = {
  uid: number
  role: string
  username: string
}

export type TokenAndUser = {
  jwt: string
  user: User
}

/**
 * Create a new user. If successful, automatically logs the user in.
 * @param username The new username
 * @param pass The user's password
 * @param rememberMe True to store credentials
 * @returns User
 */
export async function createUser(
  username: string,
  pass: string,
  rememberMe: boolean
): Promise<TokenAndUser> {
  let response: Response | null = null
  try {
    const url = new URL("/rpc/create_user", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "POST",
      body: JSON.stringify({ username, pass }),
      headers: {
        Accept: "application/vnd.pgrst.object+json",
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    const res = await response.json()
    storeToken(res.token, rememberMe)
    return parseToken(res.token)
  } else {
    if (response.status === 409) {
      throw "User already exist."
    }
    const err = await response.json()
    throw err.message
  }
}

/**
 * Login
 * @param username Username
 * @param pass Password
 * @param rememberMe True to store credentials
 * @returns User
 */
export async function login(
  username: string,
  pass: string,
  rememberMe: boolean
): Promise<TokenAndUser> {
  let response: Response | null = null
  try {
    const url = new URL("/rpc/login", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "POST",
      body: JSON.stringify({ username, pass }),
      headers: {
        Accept: "application/vnd.pgrst.object+json",
        "Content-Type": "application/json",
      },
    })
  } catch (e) {
    throw "Could not connect to API"
  }

  if (response.ok) {
    const res = await response.json()
    storeToken(res.token, rememberMe)
    return parseToken(res.token)
  } else {
    const err = await response.json()
    throw err.message
  }
}

/**
 * Update user's password
 * @param jwt jwt token
 * @param oldpass User's current password
 * @param newpass User's new password
 */
export async function changePassword(
  jwt: string,
  oldpass: string,
  newpass: string
): Promise<void> {
  let response: Response | null = null
  try {
    const url = new URL("/rpc/change_password", process.env.API_BASE)
    response = await fetch(url.toString(), {
      method: "POST",
      body: JSON.stringify({ oldpass, newpass }),
      headers: {
        Accept: "application/vnd.pgrst.object+json",
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

/** @returns the User if logged in already */
export function checkIfLoggedIn(): TokenAndUser | null {
  const jwt = sessionStorage.getItem("t") || localStorage.getItem("t")
  if (jwt) {
    return parseToken(jwt)
  }
  return null
}

/** logs the user out */
export function logout(): void {
  localStorage.removeItem("t")
  sessionStorage.removeItem("t")
}

/**
 * Store the jwt token
 * @param jwt The token
 * @param rememberMe Whether to store long-term or just session
 */
function storeToken(jwt: string, rememberMe: boolean): void {
  logout()
  if (rememberMe) {
    localStorage.setItem("t", jwt)
  } else {
    sessionStorage.setItem("t", jwt)
  }
}

/**
 * Parse user information out of the jwt
 * @param jwt The jwt token
 * @returns the token and User
 */
function parseToken(jwt: string): TokenAndUser {
  const [_, user] = jwt.split(".")
  return { jwt, user: JSON.parse(atob(user)) }
}

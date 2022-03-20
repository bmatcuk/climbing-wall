import type { FunctionComponent } from "preact"
import { useCallback, useEffect, useState } from "preact/hooks"
import { Switch, Route } from "wouter-preact"

import Header from "./Header"
import Login from "./Login"
import Profile from "./Profile"
import Dashboard from "./Dashboard"
import { User, checkIfLoggedIn, logout as logoutUser } from "./api/user"

const App: FunctionComponent = () => {
  const [jwt, setJwt] = useState<string | null>(null)
  const [user, setUser] = useState<User | null>(null)

  const logout = useCallback(() => {
    logoutUser()
    setJwt(null)
    setUser(null)
  }, [])

  useEffect(() => {
    const tokenAndUser = checkIfLoggedIn()
    if (tokenAndUser) {
      setJwt(tokenAndUser.jwt)
      setUser(tokenAndUser.user)
    }
  }, [])

  return (
    <div>
      <Header loggedIn={Boolean(user)} logout={logout} />
      <main>
        {jwt && user ? (
          <Switch>
            <Route path="/">
              <Dashboard jwt={jwt} user={user} />
            </Route>
            <Route path="/profile">
              <Profile jwt={jwt} user={user} />
            </Route>
            <Route>404</Route>
          </Switch>
        ) : (
          <Login setUser={setUser} setJwt={setJwt} />
        )}
      </main>
    </div>
  )
}

export default App

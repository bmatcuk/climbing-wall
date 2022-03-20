import type { FunctionComponent } from "preact"
import { useCallback, useState } from "preact/hooks"

import { User, createUser, login as loginUser } from "./api/user"

type Props = {
  setUser(user: User): void
  setJwt(jwt: string): void
}

const Login: FunctionComponent<Props> = ({ setUser, setJwt }) => {
  const [error, setError] = useState<string | undefined>()
  const [username, setUsername] = useState("")
  const [password, setPassword] = useState("")
  const [confirmPassword, setConfirmPassword] = useState("")
  const [rememberMe, setRememberMe] = useState(true)
  const [signup, setSignup] = useState(false)
  const [submitting, setSubmitting] = useState(false)

  const updateUsername = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLInputElement
    setUsername(value)
    setError(undefined)
  }, [])

  const updatePassword = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLInputElement
    setPassword(value)
    setError(undefined)
  }, [])

  const updateConfirmPassword = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLInputElement
    setConfirmPassword(value)
    setError(undefined)
  }, [])

  const updateRememberMe = useCallback((evt: Event) => {
    const { checked } = evt.target as HTMLInputElement
    setRememberMe(checked)
  }, [])

  const toggleSignup = useCallback((evt: Event) => {
    evt.preventDefault()
    setSignup((v) => !v)
    setError(undefined)
  }, [])

  const login = useCallback(
    async (evt: Event) => {
      evt.preventDefault()
      setError(undefined)
      setSubmitting(true)

      try {
        if (signup) {
          if (password != confirmPassword) {
            throw "Passwords do not match."
          }

          const { user, jwt } = await createUser(username, password, rememberMe)
          setUser(user)
          setJwt(jwt)
        } else {
          const { user, jwt } = await loginUser(username, password, rememberMe)
          setUser(user)
          setJwt(jwt)
        }
      } catch (e) {
        setError(e instanceof Error ? e.message : String(e))
      }

      setSubmitting(false)
    },
    [username, password, confirmPassword, rememberMe, signup, setUser]
  )

  return (
    <section>
      <form onSubmit={login}>
        <fieldset>
          {error && <p class="error">{error}</p>}
          <legend>{signup ? "Signup" : "Login"}</legend>
          <label>
            Username:
            <input
              type="text"
              onInput={updateUsername}
              value={username}
              disabled={submitting}
            />
          </label>
          <label>
            Password:
            <input
              type="password"
              onInput={updatePassword}
              value={password}
              disabled={submitting}
            />
          </label>
          {signup && (
            <label>
              Confirm Password:
              <input
                type="password"
                onInput={updateConfirmPassword}
                value={confirmPassword}
                disabled={submitting}
              />
            </label>
          )}
          <label>
            <input
              type="checkbox"
              onChange={updateRememberMe}
              checked={rememberMe}
              disabled={submitting}
            />{" "}
            Remember Me
          </label>
          <input
            type="submit"
            value={signup ? "Signup" : "Login"}
            disabled={submitting}
          />
          &nbsp; (
          <a href="#" onClick={toggleSignup}>
            {signup ? "login" : "signup"}
          </a>
          )
        </fieldset>
      </form>
    </section>
  )
}

export default Login

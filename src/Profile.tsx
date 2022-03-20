import type { FunctionComponent } from "preact"
import { useCallback, useState } from "preact/hooks"
import { Link } from "wouter-preact"

import { User, changePassword as changeUserPassword } from "./api/user"

type Props = {
  jwt: string
  user: User
}

const Profile: FunctionComponent<Props> = ({ jwt, user }) => {
  const [error, setError] = useState<string | undefined>()
  const [oldPassword, setOldPassword] = useState("")
  const [password, setPassword] = useState("")
  const [confirmPassword, setConfirmPassword] = useState("")
  const [submitting, setSubmitting] = useState(false)

  const updateOldPassword = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLInputElement
    setOldPassword(value)
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

  const changePassword = useCallback(
    async (evt: Event) => {
      evt.preventDefault()
      setError(undefined)
      setSubmitting(true)

      try {
        if (password !== confirmPassword) {
          throw "Passwords do not match."
        }

        await changeUserPassword(jwt, oldPassword, password)
        setOldPassword("")
        setPassword("")
        setConfirmPassword("")
      } catch (e) {
        setError(e instanceof Error ? e.message : String(e))
      }

      setSubmitting(false)
    },
    [user, password, confirmPassword]
  )

  return (
    <section>
      <p>
        <Link href="/">&laquo; Back</Link>
      </p>
      <form onSubmit={changePassword}>
        <fieldset>
          <legend>Change Password</legend>
          {error && <p class="error">{error}</p>}
          <label>
            Current Password:
            <input
              type="password"
              onInput={updateOldPassword}
              value={oldPassword}
              disabled={submitting}
            />
          </label>
          <label>
            New Password:
            <input
              type="password"
              onInput={updatePassword}
              value={password}
              disabled={submitting}
            />
          </label>
          <label>
            Confirm Password:
            <input
              type="password"
              onInput={updateConfirmPassword}
              value={confirmPassword}
              disabled={submitting}
            />
          </label>
          <input type="submit" value="Update Password" disabled={submitting} />
        </fieldset>
      </form>
    </section>
  )
}

export default Profile

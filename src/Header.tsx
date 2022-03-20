import type { FunctionComponent } from "preact"
import { useCallback } from "preact/hooks"
import { Link } from "wouter-preact"

import styles from "./header.module.css"

type Props = {
  loggedIn: boolean
  logout(): void
}

const Header: FunctionComponent<Props> = ({ loggedIn, logout }) => {
  const doLogout = useCallback(
    (evt: Event) => {
      evt.preventDefault()
      logout()
    },
    [logout]
  )

  return (
    <header class={styles.header}>
      <h1 class={styles.desktop}>The Climbing Wall</h1>
      <h1 class={styles.mobile}>TCW</h1>
      {loggedIn && (
        <menu>
          <li>
            <Link href="/profile">Edit Profile</Link>
          </li>
          <li>
            <a href="#" onClick={doLogout}>
              Logout
            </a>
          </li>
        </menu>
      )}
    </header>
  )
}

export default Header

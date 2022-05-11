import type { FunctionComponent } from "preact"

import styles from "./routecolors.module.css"

type Props = {
  color1: string | null
  color2: string | null
  symbol: string | null
}

const Symbol: FunctionComponent<{ symbol: string }> = ({ symbol }) => {
  if (symbol === "8") {
    return (
      <text x="5.5" y="14" textLength="7">
        8
      </text>
    )
  } else if (symbol === "circles") {
    return <circle cx="9" cy="9" r="7" />
  } else if (symbol === "dashes") {
    return <path d="M9,0v3m0,3v3m0,3v3" />
  } else if (symbol === "dots") {
    return <circle cx="9" cy="9" r="7" class={styles.filled} />
  } else if (symbol === "double line") {
    return <path d="M7,0v18m4,0v-18" />
  } else if (symbol === "hearts") {
    return <path d="M9,16L2,5.5A3.5 3.5 90 0 1 9 5.5,3.5 3.5 90 0 1 16 5.5z" />
  } else if (symbol === "horz lines") {
    return <path d="M0,2h18m0,4h-18m0,4h18m0,4h-18m0,4h18" />
  } else if (symbol === "line") {
    return <path d="M9,0v18" />
  } else if (symbol === "sine w/ dots") {
    return (
      <>
        <path d="M0,-4.5c0 3.2778 18 5.7222 18 9,0 3.2778 -18 5.7222 -18 9,0 3.2778 18 5.7222 18 9" />
        <circle cx="4.5" cy="4.5" r="2" class={styles.filled} />
        <circle cx="13.5" cy="13.5" r="2" class={styles.filled} />
      </>
    )
  } else if (symbol === "sine wave") {
    return (
      <path d="M0,-4.5c0 3.2778 18 5.7222 18 9,0 3.2778 -18 5.7222 -18 9,0 3.2778 18 5.7222 18 9" />
    )
  } else if (symbol === "smiley") {
    return (
      <>
        <circle cx="9" cy="9" r="7" />
        <circle cx="6" cy="7" r="1" class={styles.filled} />
        <circle cx="12" cy="7" r="1" class={styles.filled} />
        <path d="M4,11A5 6 90 0 0 14 11" />
      </>
    )
  } else if (symbol === "squares") {
    return <path d="M2,2h14v14h-14z" />
  } else if (symbol === "squiggles") {
    return (
      <path d="M0,-4.5c0 1.0926 18 1.9074 18 3,0 1.0926 -18 1.9074 -18 3,0 1.0926 18 1.9074 18 3,0 1.0926 -18 1.9074 -18 3,0 1.0926 18 1.9074 18 3,0 1.0926 -18 1.9074 -18 3,0 1.0926 18 1.9074 18 3,0 1.0926 -18 1.9074 -18 3" />
    )
  } else if (symbol === "stars") {
    return <path d="M4.5,13.5L9 3,13.5 13.5,4 7.5,14 7.5z" />
  } else if (symbol === "triangle wave") {
    return <path d="M9,0l4.5,4.5 -9,9 4.5,4.5" />
  } else if (symbol === "triangles") {
    return <path d="M9,4.5l7,9h-14z" />
  } else if (symbol === "x's") {
    return <path d="M0,0l18,18m-18,0l18,-18" />
  } else if (symbol === "YP") {
    return (
      <text x="2" y="14" textLength="14">
        YP
      </text>
    )
  }
  return <></>
}

const RouteColors: FunctionComponent<Props> = ({ color1, color2, symbol }) => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 18 18"
      class={styles.routecolor}
    >
      {color1 && (
        <rect class={styles[color1]} x="0" y="0" width="18" height="18" />
      )}
      {color2 && (
        <rect class={styles[color2]} x="6" y="0" width="6" height="18" />
      )}
      {symbol && <Symbol symbol={symbol} />}
    </svg>
  )
}

export default RouteColors

/* eslint-disable @typescript-eslint/no-non-null-assertion */
if (process.env.NODE_ENV === "development") {
  require("preact/debug")
}

import { render } from "preact"
import App from "./App"

const root = document.getElementById("app")
render(<App />, root!)

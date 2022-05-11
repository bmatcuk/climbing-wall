import type { FunctionComponent } from "preact"
import { useCallback, useEffect, useRef, useState } from "preact/hooks"

import { NewRoute, Route, Setter, isRouteSaved } from "./api/routes"
import RouteItemDisplay, { difficultyToString } from "./RouteItemDisplay"
import { zeroPad } from "./utils"

import styles from "./routeitem.module.css"

const RATINGS = [
  "V?",
  "VB-",
  "VB",
  "VB+",
  "V0-",
  "V0",
  "V0+",
  "V1-",
  "V1",
  "V1+",
  "V2-",
  "V2",
  "V2+",
  "V3-",
  "V3",
  "V3+",
  "V4-",
  "V4",
  "V4+",
  "V5-",
  "V5",
  "V5+",
  "V6-",
  "V6",
  "V6+",
  "V7-",
  "V7",
  "V7+",
  "V8-",
  "V8",
  "V8+",
]

const TOPROPE_RATINGS = ["?", "EASY", "MOD", "HARD"]

const COLORS = [
  "",
  "black",
  "blue",
  "green",
  "orange",
  "pink",
  "purple",
  "red",
  "white",
  "yellow",
]

const SYMBOLS = [
  "",
  "8",
  "circles",
  "dashes",
  "dots",
  "double line",
  "hearts",
  "horz lines",
  "line",
  "sine w/ dots",
  "sine wave",
  "smiley",
  "squares",
  "squiggles",
  "stars",
  "triangle wave",
  "triangles",
  "x's",
  "YP",
]

const MONTHS = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec",
]

const DAYS: number[] = []
for (let day = 1; day <= 31; day++) {
  DAYS.push(day)
}

type Props = {
  route: NewRoute | Route
  setters: Map<number, Setter>
  toprope: boolean
  saveRoute(route: NewRoute | Route): Promise<void>
  dragStart(route: Route, evt: DragEvent): void
  dragOver(route: Route, evt: DragEvent): void
  drop(route: Route, evt: DragEvent): void
  dragEnd(evt: DragEvent): void
}

/**
 * Converts a difficulty string (such as V3+) to a difficulty and mod
 * @param s The difficulty string
 * @param toprope Whether or not we're in the top rope section
 * @returns the difficulty and mod
 */
function stringToDifficulty(
  s: string,
  toprope: boolean
): Pick<Route, "difficulty" | "difficulty_mod"> {
  const idx = (toprope ? TOPROPE_RATINGS : RATINGS).indexOf(s)
  if (idx <= 0) {
    return { difficulty: null, difficulty_mod: 0 }
  } else if (toprope) {
    return { difficulty: idx, difficulty_mod: 0 }
  }

  // difficulty will be in the range -1 to 8
  const difficulty = Math.round((idx - 5) / 3)
  return {
    difficulty,
    difficulty_mod: idx - ((difficulty + 1) * 3 + 2),
  }
}

/**
 * @param month A 3-letter month string
 * @param day Day of the month
 * @returns a string representing YYYY-MM-DD. If the month/day are after
 * today's date, then the year will be set to last year.
 */
function monthDayToDate(month: string, day: number): string | null {
  const monthIdx = MONTHS.indexOf(month)
  if (monthIdx < 0 || day === 0) {
    return null
  }

  const today = new Date()
  const year =
    monthIdx > today.getMonth() || day > today.getDate()
      ? today.getFullYear() - 1
      : today.getFullYear()
  return `${year}-${zeroPad(monthIdx + 1)}-${zeroPad(day)}`
}

const EditRouteItem: FunctionComponent<Props> = ({
  route,
  setters,
  toprope,
  saveRoute,
  dragStart,
  dragOver,
  drop,
  dragEnd,
}) => {
  const [editing, setEditing] = useState(false)
  const [difficulty, setDifficulty] = useState("")
  const [description, setDescription] = useState(route.description)
  const [color1, setColor1] = useState(route.color1)
  const [color2, setColor2] = useState(route.color2)
  const [symbol, setSymbol] = useState(route.symbol)
  const [setter1, setSetter1] = useState(route.setter1_id)
  const [setter2, setSetter2] = useState(route.setter2_id)
  const [setMonth, setSetMonth] = useState("")
  const [setDay, setSetDay] = useState(0)
  const [saving, setSaving] = useState(false)
  const retireDialog = useRef<HTMLDialogElement>(null)
  const settersArray = [...setters.values()]
  const savedRoute = isRouteSaved(route)

  useEffect(() => {
    setDifficulty(
      difficultyToString(route.difficulty, route.difficulty_mod, toprope)
    )
    setDescription(route.description)
    setColor1(route.color1)
    setColor2(route.color2)
    setSymbol(route.symbol)
    setSetter1(route.setter1_id)
    setSetter2(route.setter2_id)
    if (route.set_on) {
      const [_y, m, d] = route.set_on.split("-")
      setSetMonth(MONTHS[Number(m) - 1])
      setSetDay(Number(d))
    } else {
      setSetMonth("")
      setSetDay(0)
    }
  }, [route, toprope, editing])

  const toggleEditing = useCallback((evt: Event) => {
    evt.preventDefault()
    setEditing((v) => !v)
  }, [])

  const updateDifficulty = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setDifficulty(value)
  }, [])

  const updateDescription = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLInputElement
    setDescription(value === "" ? null : value)
  }, [])

  const updateColor1 = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setColor1(value === "" ? null : value)
  }, [])

  const updateColor2 = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setColor2(value === "" ? null : value)
  }, [])

  const updateSymbol = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setSymbol(value === "" ? null : value)
  }, [])

  const updateSetter1 = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setSetter1(Number(value))
  }, [])

  const updateSetter2 = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setSetter2(value === "" ? null : Number(value))
  }, [])

  const updateSetMonth = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setSetMonth(value)
  }, [])

  const updateSetDay = useCallback((evt: Event) => {
    const { value } = evt.target as HTMLSelectElement
    setSetDay(Number(value))
  }, [])

  const submit = useCallback(
    (evt: Event) => {
      evt.preventDefault()

      const updatedRoute: NewRoute | Route = {
        ...route,
        ...stringToDifficulty(difficulty, toprope),
        description,
        color1,
        color2,
        symbol,
        setter1_id: setter1,
        setter2_id: setter2,
        set_on: monthDayToDate(setMonth, setDay),
      }
      setSaving(true)
      saveRoute(updatedRoute).then(() => {
        setSaving(false)
        setEditing(false)
      })
    },
    [
      route,
      difficulty,
      description,
      color1,
      color2,
      symbol,
      setter1,
      setter2,
      setMonth,
      setDay,
      saveRoute,
    ]
  )

  const confirmRetire = useCallback(
    (evt: Event) => {
      evt.preventDefault()
      retireDialog.current?.showModal()
    },
    [retireDialog]
  )

  const cancelRetire = useCallback(
    (evt: Event) => {
      evt.preventDefault()
      retireDialog.current?.close()
    },
    [retireDialog]
  )

  const retireRoute = useCallback(
    (evt: Event) => {
      evt.preventDefault()

      const updatedRoute = { ...route, active: false }
      retireDialog.current?.close()
      setSaving(true)
      saveRoute(updatedRoute)
    },
    [route, saveRoute]
  )

  const doDragStart = useCallback(
    (evt: DragEvent) => {
      if (savedRoute) {
        dragStart(route, evt)
      }
    },
    [route, dragStart, savedRoute]
  )

  const doDragOver = useCallback(
    (evt: DragEvent) => {
      if (savedRoute) {
        dragOver(route, evt)
      }
    },
    [route, dragOver, savedRoute]
  )

  const doDrop = useCallback(
    (evt: DragEvent) => {
      if (savedRoute) {
        drop(route, evt)
      }
    },
    [route, drop, savedRoute]
  )

  return (
    <li
      class={`${styles["route-item"]} ${styles.edit}`}
      draggable={savedRoute && !editing}
      onDragStart={doDragStart}
      onDragOver={doDragOver}
      onDrop={doDrop}
      onDragEnd={dragEnd}
    >
      {editing ? (
        <form onSubmit={submit}>
          <select
            value={difficulty}
            onChange={updateDifficulty}
            disabled={saving}
          >
            {(toprope ? TOPROPE_RATINGS : RATINGS).map((v) => (
              <option value={v}>{v}</option>
            ))}
          </select>
          <select
            value={color1 ?? ""}
            onChange={updateColor1}
            disabled={saving}
          >
            {COLORS.map((c) => (
              <option value={c}>{c}</option>
            ))}
          </select>
          <select
            value={color2 ?? ""}
            onChange={updateColor2}
            disabled={saving}
          >
            {COLORS.map((c) => (
              <option value={c}>{c}</option>
            ))}
          </select>
          <select
            value={symbol ?? ""}
            onChange={updateSymbol}
            disabled={saving}
          >
            {SYMBOLS.map((c) => (
              <option value={c}>{c}</option>
            ))}
          </select>
          <input
            type="text"
            placeholder="Special rules, description, etc"
            value={description ?? ""}
            onInput={updateDescription}
            disabled={saving}
          />
          <select value={setter1} onChange={updateSetter1} disabled={saving}>
            {settersArray.map((setter) => (
              <option value={setter.id}>{setter.abbr}</option>
            ))}
          </select>
          <select
            value={setter2 ?? ""}
            onChange={updateSetter2}
            disabled={saving}
          >
            <option value=""></option>
            {settersArray.map((setter) => (
              <option value={setter.id}>{setter.abbr}</option>
            ))}
          </select>
          <select value={setMonth} onChange={updateSetMonth} disabled={saving}>
            <option value=""></option>
            {MONTHS.map((m) => (
              <option value={m}>{m}</option>
            ))}
          </select>
          <select value={setDay} onChange={updateSetDay} disabled={saving}>
            <option value={0}></option>
            {DAYS.map((d) => (
              <option value={d}>{d}</option>
            ))}
          </select>
          <input type="submit" value="Save" disabled={saving} />
          {saving ? (
            <>
              <span>Cancel</span>
              {savedRoute && <span>Retire</span>}
            </>
          ) : (
            <>
              <a href="#" onClick={toggleEditing}>
                Cancel
              </a>
              {savedRoute && (
                <a href="#" onClick={confirmRetire}>
                  Retire
                </a>
              )}
            </>
          )}
          {savedRoute && (
            <dialog ref={retireDialog}>
              <p>
                Are you sure you want to retire this route? It cannot be undone.
              </p>
              <menu>
                <a href="#" onClick={retireRoute}>
                  YES, RETIRE
                </a>
                <a href="#" onClick={cancelRetire}>
                  Cancel
                </a>
              </menu>
            </dialog>
          )}
        </form>
      ) : (
        <label onClick={toggleEditing}>
          <span class={styles.pencil}>&#9998;</span>
          <RouteItemDisplay route={route} setters={setters} toprope={toprope} />
        </label>
      )}
    </li>
  )
}

export default EditRouteItem

/**
 * @param n A number
 * @returns the number padded with a 0 if <10
 */
export function zeroPad(n: number): string {
  return n < 10 ? `0${n}` : String(n)
}

/**
 * Essentially does a "group by" and sort on an array.
 * @param ary The array to group and sort
 * @param mapBy The property to group by
 * @param sortBy The property to sort the groups by, or a function to sort by
 * @returns a map of groups
 */
export function mapArray<
  T extends Record<S, number>,
  K extends keyof T,
  S extends { [P in keyof T]: T[P] extends number ? P : never }[keyof T],
  F extends NonNullable<Parameters<Array<T>["sort"]>[0]>
>(ary: T[], mapBy: K, sortBy: S | F): Map<T[K], T[]> {
  const map = new Map<T[K], T[]>()
  ary.forEach((item) => {
    let lst = map.get(item[mapBy])
    if (!lst) {
      lst = []
      map.set(item[mapBy], lst)
    }
    lst.push(item)
  })
  if (typeof sortBy === "function") {
    map.forEach((lst) => lst.sort(sortBy))
  } else {
    map.forEach((lst) => lst.sort((a, b) => a[sortBy] - b[sortBy]))
  }
  return map
}

/**
 * Given an array, produces a map of an id to those objects
 * @param ary The array
 * @param mapBy The key
 * @returns a map
 */
export function mapOf<T, K extends keyof T>(ary: T[], mapBy: K): Map<T[K], T> {
  const map = new Map<T[K], T>()
  ary.forEach((item) => {
    map.set(item[mapBy], item)
  })
  return map
}

import type { FunctionComponent } from "preact"

import styles from "./checkbox.module.css"

type Props = {
  checked: boolean
  class?: string
  disabled: boolean
  loading?: boolean
  onChange(evt: Event): void
}

const Checkbox: FunctionComponent<Props> = ({
  checked,
  class: className,
  disabled,
  loading,
  onChange,
}) => (
  <>
    <input
      class={`${styles.checkbox} ${loading ? styles.loading : ""} ${
        className ? className : ""
      }`}
      type="checkbox"
      checked={checked}
      disabled={disabled}
      onChange={onChange}
    />
    <span></span>
  </>
)

export default Checkbox

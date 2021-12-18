open Zora
open ZoraJsdom
open RescriptHooksTestingLibrary.Testing

type counterType = (int, (int => int) => unit)

let useCounter = initial => {
  React.useState(() => initial)
}

zoraWithDOMBlock("Reset document between tests", t => {
  let {result} = renderHook(() => useCounter(0), ())
  let (value, setValue) = result.current
  t->equal(value, 0, "counter is 0")
  act(() => setValue(prev => prev + 1))
  let (value, setValue) = result.current
  t->equal(value, 1, "counter is 1")
  act(() => setValue(prev => prev + 1))
  let (value, _) = result.current
  t->equal(value, 2, "counter is 2")
})

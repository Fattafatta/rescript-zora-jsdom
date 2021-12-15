@module("./withDOM")
external withDOM: 't => 't = "withDOM"

@ocaml.doc("Wrapper around Zora.zora that provides a DOM context.

Example:
```
ZoraJsdom.zoraWithDOM(\"Zora with jsdom\", t => {
  t->ok(document, \"should have a document\")
  done()
})
```
")
let zoraWithDOM = (text, test) => {
  Zora.zora(text, test->withDOM)
}

@ocaml.doc("Wrapper around Zora.zoraBlock that provides a DOM context.

Example:
```
ZoraJsdom.zoraWithDOMBlock(\"Zora with jsdom\", t => {
  t->ok(document, \"should have a document\")
  done()
})
```
")
let zoraWithDOMBlock = (text, test) => {
  Zora.zoraBlock(text, test->withDOM)
}

@ocaml.doc("Wrapper around Zora.test that provides a DOM context.

Example:
```
Zora.zora(\"Zora\", t => {
  t->ZoraJsdom.testWithDOM(\"Test with jsdom\", t => {
    t->ok(document, \"should have a document\")
    done()
  })
})
```
")
let testWithDOM = (t, text, test) => {
  t->Zora.test(text, test->withDOM)
}

@ocaml.doc("Wrapper around Zora.block that provides a DOM context.

Example:
```
Zora.zoraBlock(\"Zora\", t => {
  t->ZoraJsdom.blockWithDOM(\"Test with jsdom\", t => {
    t->ok(document, \"should have a document\")
    done()
  })
})
```
")
let blockWithDOM = (t, text, test) => {
  t->Zora.block(text, test->withDOM)
}

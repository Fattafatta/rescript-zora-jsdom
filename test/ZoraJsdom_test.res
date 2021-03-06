open Zora

@val external document: 'd = "document"
@val external window: 'w = "window"

ZoraJsdom.zoraWithDOM("DOM presence in parallel tests", t => {
  // ok works here because type of window is generic
  t->ok(window, "should have a window")
  t->ok(document, "should have a document")
  done()
})

ZoraJsdom.zoraWithDOMBlock("DOM presence in sequential tests", t => {
  t->ok(window, "should have a window")
  t->ok(document, "should have a document")
})

Zora.zora("DOM presence in parallel subtests", t => {
  t->ZoraJsdom.testWithDOM("run subtest", t => {
    t->ok(window, "should have a window")
    t->ok(document, "should have a document")
    done()
  })
  done()
})

Zora.zora("DOM presence in sequential subtests", t => {
  t->ZoraJsdom.blockWithDOM("run subtest", t => {
    t->ok(window, "should have a window")
    t->ok(document, "should have a document")
  })
  done()
})

Zora.zoraBlock("Reset document between tests", t => {
  let docRef = ref(document)
  t->ZoraJsdom.testWithDOM("set 'myprop' on document", t => {
    document["myprop"] = "value"
    docRef := document
    t->equal(document["myprop"], "value", "'myprop' should be set")
    t->equal(docRef.contents["myprop"], "value", "reference should contain 'value'")
    done()
  })
  t->ZoraJsdom.testWithDOM("new document without 'myprop'", t => {
    t->equal(document["myprop"], Js.undefined, "'myprop' should be undefined")
    t->notEqual(docRef.contents, document, "documents should be different")
    done()
  })
})

type localStorageType = {
  getItem: 'a. string => 'a,
  setItem: 'a. (string, 'a) => unit,
  removeItem: string => unit,
  clear: unit => unit,
}

type rType = {a: string}

ZoraJsdom.zoraWithDOM("localStorage works", t => {
  let ls: localStorageType = window["localStorage"]
  // ok works here because type of window is generic
  ls.setItem("mykey1", "myvalue")
  t->equal(ls.getItem("mykey1"), "myvalue", "should have item with value 'mykey'")
  ls.setItem("mykey2", 1)
  t->equal(ls.getItem("mykey2"), 1, "should have item with value 1")
  ls.setItem("mykey3", {a: "val"})
  t->equal(ls.getItem("mykey3"), {a: "val"}, "should have item with value {a: 'val'}")
  ls.removeItem("mykey1")
  t->equal(ls.getItem("mykey1"), Js.null, "item should be deleted")
  ls.clear()
  t->equal(ls.getItem("mykey1"), Js.null, "item should be deleted")
  t->equal(ls.getItem("mykey2"), Js.null, "item should be deleted")
  t->equal(ls.getItem("mykey3"), Js.null, "item should be deleted")
  done()
})

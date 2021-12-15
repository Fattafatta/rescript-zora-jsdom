# rescript-zora-jsdom: A jsdom wrapper for zora tests

This package provides a simple [ReScript](https://rescript-lang.org/) binding for the [jsdom](https://github.com/jsdom/jsdom) module to use with [zora](https://github.com/lorenzofox3/zora) tests. It works as extension to [rescript-zora](https://github.com/dusty-phillips/rescript-zora) and provides a (minimal) DOM environment (e.g. a `document` and a `window` object) for all wrapped tests.

It was specifically designed to test react hooks with [rescript-hooks-testing-library](https://github.com/glebskr/rescript-hooks-testing-library) and zora.

## Disclaimer

I'm very new to ReScript (and functional programming in general). So there is probably a lot of room for improvements in this package. Any tips or suggestions are very welcome.

## Installation

Install with `npm`:

```bash
npm install --save-dev @fattafatta/rescript-zora-jsdom
```

Or install with `yarn`:

```bash
yarn add --dev @fattafatta/rescript-zora-jsdom
```

Add `@fattafatta/rescript-zora-jsdom` as a (dev-)dependency to your `bsconfig.json`:

```json
"bs-dev-dependencies": ["@dusty-phillips/rescript-zora", "@fattafatta/rescript-zora-jsdom"]
```

### Note

This package requires `@dusty-phillips/rescript-zora` as a peer dependency.

## Usage

### Run blocking tests

Simply use `zoraWithDOMBlock` instead of `zoraBlock`. All tests will use the same DOM environment.

```rescript
ZoraJsdom.zoraWithDOMBlock("run tests sequentially", t => {
  open Zora
  t->block("test 1", t => {
    t->ok(document, "should have a document")
  })
  t->block("test 2", t => {
    t->ok(document, "should have a document too")
  })
})
```

### Run parallel tests

Use `zoraWithDOM` instead of `zora` to run tests in parallel. All tests will share the same DOM environment.

```rescript
ZoraJsdom.zoraWithDOM("run tests in parallel", t => {
  open Zora
  t->test("test 1", t => {
    t->ok(document, "should have a document")
    done()
  })
  t->test("test 2", t => {
    t->ok(document, "should have a document too")
    done()
  })
  done()
})
```

### Run tests in seperate DOM environments

You can use `testWithDOM` or `blockWithDOM` to run multiple tests in different DOM environments.

```rescript
// Run tests in parallel
open Zora
zora("run tests in parallel", t => {
  t->ZoraJsdom.testWithDOM("test 1", t => {
    t->ok(document, "should have a document")
    done()
  })
  t->ZoraJsdom.testWithDOM("test 2", t => {
    t->ok(document, "should have a document too")
    done()
  })
  done()
})

// Run tests sequentially
open Zora
zoraBlock("run tests sequentially", t => {
  t->ZoraJsdom.blockWithDOM("test 1", t => {
    t->ok(document, "should have a document")
  })
  t->ZoraJsdom.blockWithDOM("test 2", t => {
    t->ok(document, "should have a document too")
  })
})
```

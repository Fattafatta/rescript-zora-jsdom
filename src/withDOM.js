// eslint-disable-next-line @typescript-eslint/no-var-requires
const { JSDOM } = require('jsdom');

// based on recommendation for enzyme with jsdom
// https://github.com/enzymejs/enzyme/blob/master/docs/guides/jsdom.md

function copyProps(src, target) {
  Object.defineProperties(target, {
    ...Object.getOwnPropertyDescriptors(src),
    ...Object.getOwnPropertyDescriptors(target),
  });
}

exports.withDOM = function (test) {
  return async (...args) => {
    const dom = new JSDOM('<!doctype html><html><body></body></html>');

    const { window } = dom;

    global.window = window;
    global.document = window.document;
    global.navigator = {
      userAgent: 'node.js zora jsdom',
    };

    global.requestAnimationFrame = function (callback) {
      return setTimeout(callback, 0);
    };
    global.cancelAnimationFrame = function (id) {
      clearTimeout(id);
    };

    copyProps(window, global);

    const result = test(...args);

    // TODO clean up globals??

    return result;
  };
};

require 'coffee-cache'
{jsdom} = require 'jsdom'
browser = jsdom()
global.window = browser.parentWindow
global.document = window.document

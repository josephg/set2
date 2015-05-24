# Mocha tests
assert = require 'assert'

Set2 = require './set2'

describe 'set2', ->
  it 'can store data', ->
    m = new Set2
    assert.equal m, m.add 1, 2
    assert m.has 1, 2


# Mocha tests
assert = require 'assert'

Set2 = require './set2'

describe 'set2', ->
  it 'can store data', ->
    m = new Set2
    assert.equal m, m.add 1, 2
    assert m.has 1, 2

  it 'updates size', ->
    m = new Set2
    assert.strictEqual m.size, 0
    m.add 1, 2
    assert.strictEqual m.size, 1
    m.add 1, 2
    assert.strictEqual m.size, 1
    m.add 1, 3
    assert.strictEqual m.size, 2
    m.add 2, 0
    assert.strictEqual m.size, 3
    m.add 2, 1
    assert.strictEqual m.size, 4
    m.delete 2, 1
    assert.strictEqual m.size, 3
    m.delete 2, 0
    assert.strictEqual m.size, 2

  it 'deletes data', ->
    m = new Set2
    assert.strictEqual false, m.delete 0, 0
    m.add 1, 2
    assert.strictEqual true, m.delete 1, 2
    assert.strictEqual false, m.delete 1, 2
    m.add 1, 2
    m.add 1, 3
    assert.strictEqual true, m.delete 1, 2
    assert.strictEqual false, m.delete 1, 2
    assert.strictEqual true, m.delete 1, 3
    assert.strictEqual false, m.delete 1, 3
    
  describe 'iteration', ->
    it 'iterates through all items in forEach', ->
      objs = [[1,2], [3,4], [3,5], [1,3]]
      m = new Set2
      m.add(o[0], o[1]) for o in objs

      num = 0
      m.forEach (a, b) ->
        found = no
        for o,i in objs when o and o[0] is a and o[1] is b
          found = yes
          objs[i] = null
        assert found
        num++
      assert.equal num, objs.length

    it 'iterates through all items with .values()', ->
      objs = [[1,2], [3,4], [3,5], [1,3]]
      m = new Set2 objs
      assert.equal m.size, objs.length

      iter = m[Symbol.iterator]()
      assert.equal iter[Symbol.iterator](), iter
      num = 0
      while !(vs = iter.next()).done
        found = no
        [a, b] = vs.value
        for o,i in objs when o and o[0] is a and o[1] is b
          found = yes
          objs[i] = null
        assert found
        num++
      assert.equal num, objs.length




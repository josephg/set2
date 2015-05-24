# Set2

This is a tiny library which exposes a javascript Set2 class. ES6 Sets only
contain one element. If you try to put an array of to elements `[a,b]` into a
set, you won't be able to set for membership because each time you use the
literal list constructor, you make a new element! (Sets use reference
equality, not deep equality).

So this is an itty bitty class which fixes that problem, exposing a Set-like
API for tuples of elements (a,b).

The API is heavily based on the API for [ES6
Sets](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Set).
Use `set2.add(a, b)` to add an entry to a set, `set2.has(a, b)` to test for
containment and `set2.delete(a, b)` to remove the entry again.

The Set2 API supports both `set2.forEach` and the new `for (var e of set) { ...
}` syntax to iterate over sets. (e is an array of `[a, b]`).

This library depends on the javascript `Map` and `Set` class, so its avaliable
in NodeJS 0.12, IoJS and any [modern
browser](https://kangax.github.io/compat-table/es6/#Map). Any polyfill that
adds Map and Set to the global object should work fine too.

I made Set2 alongside [Map2](http://github.com/josephg/map2). You might find
that class useful too.

Install it with:

```
% npm install set2
```


## A quick tour:

```javascript
var Set2 = require('set2');

var s = new Set2;
m.add(1, 2).add(3, 4); // Chainable!

m.has(1, 2); // true

var obj1 = {x:5};
var obj2 = ['an','array'];
m.add(obj1, obj2);

m.has(obj1, obj2); // true

m.size; // 2

// To delete things, you can either delete items individually:
m.delete(1, 2); // returns true if something was deleted.

// Or delete everything all at once:
m.clear();

// To iterate, either use .forEach():
m.forEach(function(a, b) {
  console.log(a, b); // Prints 1,2 and {x:5},['an','array'] 
});

// Or use the new es6 iterators.
for (var entry of m) {
  console.log(entry); // An array of [a, b]
}
```


# API

#### Constructor

The Set2 constructor makes a new Set2 and optionally initializes it with data.

```javascript
var Set2 = require('set2');
var set = new Set2;
```

Or with data:

```javascript
var Set2 = require('set2');

// Equalivant of calling set.add(1,2); set.add(3,4);
var set = new Set2([[1,2], [3,4]]);
```


#### set.add(a, b)

Add the tuple (a, b) to the set. Add returns the set itself, so you can chain it.

```javascript
set.add(1, 2).add(3, 4);

set.has(1, 2); // true
```


#### set.has(a, b)

Checks to see if the set contains (a, b). Note that sets use reference
equality, so object literals with the same value aren't considered to be the
same object.

```javascript
set.add(1, 2);
set.has(1, 2); // true

var o1 = {}, o2 = {};
set.add(o1, o2);
set.has(o1, o2); // true

// But:
set.add({}, []);
set.has({}, []); // false because {} and [] make new objects.
```


#### set.delete(a, b)

Deletes the set entry (a, b). Returns true if an item was removed from
the set, false otherwise.

#### set.deleteAll(a)

Delete all entries which are (a, anything).


#### set.clear()

Remove all objects from the set. After clear() is called, the object will have a size of 0.


#### set.size

The number of entries in the set.

```javascript
set.size; // 0
set.add(1, 2); // 1
set.add(1, 2); // still 1
set.delete(1, 2); // 0
```


#### set.subset(a)

This is a convenience method for getting another set which contains all the
`b`'s for a given `a` value. The returned set is still used by Set2, so be careful editing the returned set or keeping a long lived reference.


## Iterating

There are two ways to iterate through all the items in a Set2:

- Use set.forEach
- Use ES6 Iterators

I haven't done extensive performance testing, but until javascript iterators
are better optimized, forEach is probably going to be faster. (Using a closure
allocates a function, but using an iterator allocates an object for each
iteration of the loop).

Its currently undefined what happens if you add new items to a set while
iterating through it. (You may or may not see the new object). That said,
removing the item you're currently iterating through is ok.

The order of iteration is not guaranteed. Do not depend on it in any way. (If
you care about the order of your items, consider using an array instead).


#### set.forEach(function(a, b) {...})

Call set.forEach to iterate through the set with a custom iterator function.

```javascript
set.add(1, 2, 3).add(3, 4);

set.forEach(function(value, key1, key2) {
  // Prints 1, 2, 3 and 4, 5, 6.
  console.log(key1, key2, value);
});
```


#### set.values()

Get an iterator for the entries in the set. Each entry in the result is an
array of [key1, key2, value]. Map.entries is also exposed via
`set[Symbol.iterator]` for usage in for..of loops.

```javascript
set.add(1, 2);
set.add(3, 4);

for (var entry of set) {
  // Prints 1, 2 and 3, 4
  console.log(entry[0], entry[1]);
}
```

Or awkwardly from Coffeescript:

```coffeescript
set.add 1, 2
set.add 3, 4

iter = set.entries()
while !(v = iter.next()).done
  [a, b] = v.value
  console.log a, b
```

From Coffeescript I recommend just sticking with `set.forEach (a, b) -> ...`
until better syntax lands in coffeescript.

Set.values is also aliased as Set.entries and Set[Symbol.iterator] for
convenience and API coherence.


---

## License

```
Copyright (c) 2015, Joseph Gentle <me@josephg.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
```

declare class Set2<V1, V2> implements Iterable<[V1, V2]> {
  constructor(items?: [V1, V2][])
  subset(v1: V1): Set<V2>
  has(v1: V1, v2: V2): boolean
  add(v1: V1, v2: V2): void
  delete(v1: V1, v2: V2): void
  deleteAll(v1: V1): void
  clear(): void
  forEach(fn: (v1: V1, v2: V2) => void): void
  values(): Iterator<[V1, V2]>
  entries(): Iterator<[V1, V2]>
  [Symbol.iterator](): Iterator<[V1, V2]>
}
declare module 'set2' {
    export = Set2
}

# Heap

[![Build Status](https://drone.harton.dev/api/badges/james/heap/status.svg?ref=refs/heads/main)](https://drone.harton.dev/james/heap)
[![Hex.pm](https://img.shields.io/hexpm/v/heap.svg)](https://hex.pm/packages/heap)
[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/full.html)

A Heap is a very useful data structure, because it sorts, quickly, at insert time.

See also: https://en.wikipedia.org/wiki/Heap_(data_structure)

You can use it for things like:

- Help with scientific computing
- Quickly sorting
- Priority queues

## Installation

Heap is [available in Hex](https://hex.pm/packages/heap), the package can be
installed by adding `heap` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:heap, "~> 3.0.0"}
  ]
end
```

Documentation for the latest release can be found on
[HexDocs](https://hexdocs.pm/heap) and for the `main` branch on
[docs.harton.nz](https://docs.harton.nz/james/heap).

## Deprecation warning

If you're upgrading from `heap` < 2.0 be aware that the direction of the `:<`
and `:>` atoms passed into `Heap.new/1` has changed to make more sense.

## Examples

Create a min heap and use it to find the smallest element in a collection:

```elixir
1..500 |> Enum.shuffle |> Enum.into(Heap.min) |> Heap.root
# => 1
```

Likewise, for max heaps:

```elixir
1..500 |> Enum.shuffle |> Enum.into(Heap.max) |> Heap.root
# => 500
```

A priority queue:

Tuples are compared by their elements in order, so you can push tuples
of `{priority, term}` into a Heap for sorting by priority:

```elixir
Heap.new
|> Heap.push({4, :jam})
|> Heap.push({1, :milk})
|> Heap.push({2, :eggs})
|> Heap.push({1, :bread})
|> Heap.push({3, :butter})
|> Heap.push({2, :coffee})
|> Enum.map(fn {_, what} -> what end)
# => [:bread, :milk, :coffee, :eggs, :butter, :jam]
```

The heap can also be constructed with a custom comparator:

```elixir
Heap.new(&(Date.compare(elem(&1, 0), elem(&2, 0)) == :gt))
|> Heap.push({~D[2017-11-20], :jam})
|> Heap.push({~D[2017-11-21], :milk})
|> Heap.push({~D[2017-10-21], :bread})
|> Heap.push({~D[2017-10-20], :eggs})
|> Enum.map(fn {_, what} -> what end)
# => [:milk, :jam, :bread, :eggs]
```

To access the root and the rest of the heap in one line use `Heap.split/1`:

```elixir
{root, rest} = Heap.split(heap)
{root, rest} == {Heap.root(heap), Heap.pop(heap)}
# => true
```

## License

This software is licensed under the terms of the
[HL3-FULL](https://firstdonoharm.dev), see the `LICENSE.md` file included with
this package for the terms.

This license actively proscribes this software being used by and for some
industries, countries and activities. If your usage of this software doesn't
comply with the terms of this license, then [contact me](mailto:james@harton.nz)
with the details of your use-case to organise the purchase of a license - the
cost of which may include a donation to a suitable charity or NGO.

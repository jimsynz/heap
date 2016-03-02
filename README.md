# Heap

A Heap is a very useful data structure, because it sorts, quickly, at insert time.

See also: https://en.wikipedia.org/wiki/Heap_(data_structure)

You can use it for things like:

  - Help with scientific computing
  - Quickly sorting
  - Priority queues

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add heap to your list of dependencies in `mix.exs`:

        def deps do
          [{:heap, "~> 0.0.1"}]
        end

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

### Documentation

Full API documentation is available on (hexdocs.pm)[https://hexdocs.pm/heap]

## Contributing

1. Fork it ( https://github.com/Huia/Huia/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
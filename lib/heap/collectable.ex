defimpl Collectable, for: Heap do

  @doc """
  Collect an enumerable into a heap.

  ## Examples

      iex> 1..500
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.root
      1
  """
  @spec into(Heap.t) :: {list, function}
  def into(heap) do
    {heap, fn
      (h, {:cont, v}) -> Heap.push(h, v)
      (h, :done)      -> h
      (_, :halt)      -> :ok
    end}
  end

end

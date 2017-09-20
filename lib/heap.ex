defmodule Heap do
  defstruct data: nil, size: 0, comparator: nil
  @moduledoc """
  A heap is a special tree data structure. Good for sorting and other magic.

  See also: [Heap (data structure) on Wikipedia](https://en.wikipedia.org/wiki/Heap_(data_structure)).
  """

  @type t :: %Heap{}

  @doc """
  Create an empty min heap.

  A min heap is a heap tree which always has the smallest value at the root.

  ## Examples

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.min())
      ...>   |> Heap.root()
      1
  """
  @spec min() :: t
  def min, do: Heap.new(:>)

  @doc """
  Create an empty max heap.

  A max heap is a heap tree which always has the largest value at the root.

  ## Examples

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.max())
      ...>   |> Heap.root()
      10
  """
  @spec max() :: t
  def max, do: Heap.new(:<)

  @doc """
  Create an empty heap.

  ## Examples

    Create an empty heap with the default direction.

      iex> Heap.new()
      ...>   |> Heap.comparator()
      :>

    Create an empty heap with a specific direction.

      iex> Heap.new(:<)
      ...>   |> Heap.comparator()
      :<
  """
  @spec new() :: t
  @spec new(:> | :<) :: t
  def new(direction \\ :>), do: %Heap{comparator: direction}

  @doc """
  Test if the heap is empty.

  ## Examples

      iex> Heap.new()
      ...>   |> Heap.empty?()
      true

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.empty?()
      false
  """
  @spec empty?(t) :: boolean()
  def empty?(%Heap{data: nil, size: 0}), do: true
  def empty?(%Heap{}), do: false

  @doc """
  Test if the heap contains the element <elem>

  ## Examples

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.member?(11)
      false

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.member?(7)
      true
  """
  @spec member?(t, any()) :: boolean()
  def member?(%Heap{} = heap, value) do
    root = Heap.root heap
    heap = Heap.pop heap
    has_member? heap, root, value
  end

  @doc """
  Push a new element into the heap.

  ## Examples

      iex> Heap.new()
      ...>   |> Heap.push(13)
      ...>   |> Heap.root()
      13
  """
  @spec push(t, any()) :: t
  def push(%Heap{data: h, size: n, comparator: d}, v), do: %Heap{data: meld(h, {v, []}, d), size: n + 1, comparator: d}

  @doc """
  Pop the root element off the heap and discard it.

  ## Examples

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.pop()
      ...>   |> Heap.root()
      2
  """
  @spec pop(t) :: t
  def pop(%Heap{data: nil, size: 0}), do: nil
  def pop(%Heap{data: {_, q}, size: n, comparator: d}), do: %Heap{data: pair(q, d), size: n - 1, comparator: d}

  @doc """
  Return the element at the root of the heap.

  ## Examples

      iex> Heap.new()
      ...>   |> Heap.root()
      nil

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.root()
      1
  """
  @spec root(t) :: any()
  def root(%Heap{data: {v, _}}), do: v
  def root(%Heap{data: nil, size: 0}), do: nil

  @doc """
  Return the number of elements in the heap.

  ## Examples

      iex> 1..10
      ...>   |> Enum.shuffle()
      ...>   |> Enum.into(Heap.new())
      ...>   |> Heap.size()
      10
  """
  @spec size(t) :: non_neg_integer()
  def size(%Heap{size: n}), do: n

  @doc """
  Return the comparator of the heap.

  ## Examples

      iex> Heap.new(:<)
      ...>   |> Heap.comparator()
      :<
  """
  @spec comparator(t) :: :< | :>
  def comparator(%Heap{comparator: d}), do: d

  defp meld(nil, queue, _), do: queue
  defp meld(queue, nil, _), do: queue

  defp meld({k0, l0}, {k1, _} = r, :>) when k0 < k1, do: {k0, [r | l0]}
  defp meld({_, _} = l, {k1, r0}, :>), do: {k1, [l | r0]}

  defp meld({k0, l0}, {k1, _} = r, :<) when k0 > k1, do: {k0, [r | l0]}
  defp meld({_, _} = l, {k1, r0}, :<), do: {k1, [l | r0]}

  defp pair([], _), do: nil
  defp pair([q], _), do: q
  defp pair([q0, q1 | q], d) do
    q2 = meld(q0, q1, d)
    meld(q2, pair(q, d), d)
  end

  defp has_member?(_, previous, compare) when previous == compare, do: true
  defp has_member?(nil, _, _), do: false
  defp has_member?(heap, _, compare) do
    previous = Heap.root heap
    heap     = Heap.pop heap
    has_member? heap, previous, compare
  end
end

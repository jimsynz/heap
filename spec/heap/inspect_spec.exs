defmodule HeapInspectSpec do
  use ESpec

  describe "inspect" do
    let :heap, do: Enum.into(1..5, Heap.new)
    subject do: inspect heap

    it do: is_expected |> to(eq "#Heap<[1, 2, 3, 4, 5]>")
  end
end
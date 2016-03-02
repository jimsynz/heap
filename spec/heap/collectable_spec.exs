defmodule HeapCollectableSpec do
  use ESpec

  describe "into" do
    let :source, do: 1..500
    subject do: source |> Enum.into(Heap.new)

    it "inserts into the heap" do
      expect(Heap.size subject) |> to(eq 500)
    end
  end
end
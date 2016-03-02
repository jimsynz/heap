defmodule HeapEnumerableSpec do
  use ESpec

  describe "count" do
    let :heap, do: Enum.into(1..500, Heap.new)
    subject do: Enum.count heap

    it do: is_expected |> to(eq 500)
  end

  describe "member?" do
    let :heap, do: Heap.new
    subject do: Enum.member? heap, 13

    context "When the value is in the heap" do
      let :heap, do: Heap.new |> Heap.push(13)

      it do: is_expected |> to(be_true)
    end

    context "When the value is not in the heap" do
      it do: is_expected |> to(be_false)
    end
  end

  describe "reduce" do
    let :heap, do: Enum.into(1..500, Heap.new)
    subject do: Enum.filter heap, fn(i) -> rem(i, 2) == 0 end

    it do: is_expected |> to(have_min 2)
    it do: is_expected |> to(have_max 500)
    it do: is_expected |> to(have_count 250)
  end
end
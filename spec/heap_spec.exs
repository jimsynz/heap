defmodule HeapSpec do
  use ESpec

  describe "new" do
    subject do: Heap.new

    it do: is_expected |> to(be_struct Heap)

    it "is empty" do
      expect(Heap.empty? subject) |> to(be_true)
    end
  end

  describe "min" do
    subject do: Heap.min

    it do: is_expected |> to(be_struct Heap)

    it "is empty" do
      expect(Heap.empty? subject) |> to(be_true)
    end

    it "has the correct sort direction" do
      expect(subject.d) |> to(eq :>)
    end
  end

  describe "max" do
    subject do: Heap.max

    it do: is_expected |> to(be_struct Heap)

    it "is empty" do
      expect(Heap.empty? subject) |> to(be_true)
    end

    it "has the correct sort direction" do
      expect(subject.d) |> to(eq :<)
    end
  end

  describe "empty?" do
    subject do: Heap.empty? heap

    context "When the heap is empty" do
      let :heap, do: Heap.new

      it do: is_expected |> to(be_true)
    end

    context "When the heap contains elements" do
      let :heap, do: Heap.new |> Heap.push(13)

      it do: is_expected |> to(be_false)
    end
  end

  describe "member?" do
    subject do: heap |> Heap.member?(13)

    context "When the heap contains the element" do
      let :heap, do: Heap.new |> Heap.push(13)

      it do: is_expected |> to(be_true)
    end

    context "When the heap does not contain the element" do
      let :heap, do: Heap.new

      it do: is_expected |> to(be_false)
    end
  end

  describe "push" do
    let :heap, do: Heap.new
    subject do: heap |> Heap.push(13)

    it "adds the element to the heap" do
      expect(subject |> Heap.member?(13)) |> to(be_true)
    end
  end

  describe "pop" do
    let :heap, do: Heap.new |> Heap.push(13) |> Heap.push(14)
    subject do: Heap.pop heap

    it "pops the root element off the heap" do
      expect(Heap.root heap)    |> to(eq 13)
      expect(Heap.root subject) |> to(eq 14)
    end
  end

  describe "root" do
    let :heap, do: Heap.new |> Heap.push(13)
    subject do: Heap.root heap

    it do: is_expected |> to(eq 13)
  end

  describe "size" do
    let :heap, do: Heap.new |> Heap.push(13) |> Heap.push(14)
    subject do: Heap.size heap

    it do: is_expected |> to(eq 2)
  end

  describe "sort" do
    let :source, do: Enum.shuffle(1..500)
    subject do: Heap.sort source, direction

    context "When the direction is `:>`" do
      let :direction, do: :>

      it do: is_expected |> to(eq Enum.to_list(1..500))
    end

    context "When the direction is `:<`" do
      let :direction, do: :<

      it do: is_expected |> to(eq Enum.to_list(1..500) |> Enum.reverse)
    end
  end
end
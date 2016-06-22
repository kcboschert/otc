defmodule OTC.CounterTest do
  use ExSpec

  describe "find" do
    it "has valid character names as counters for each hero" do
      heroes = OTC.NameUtil.heroes

      heroes
      |> Dict.values
      |> Enum.flat_map(fn(%{"hard" => hard_counters, "soft" => soft_counters}) ->
        (hard_counters || []) ++ (soft_counters || [])
      end)
      |> Enum.uniq
      |> Enum.all?(fn(counter) ->
        assert Dict.has_key?(heroes, counter), "Counter '#{counter}' not found as key in heroes.yml."
      end)
    end
  end

  describe "find_all" do
    it "returns all heroes, sorted by score" do
      result = OTC.Counter.find_all(["widowmaker", "hanzo", "reaper", "d_va", "junkrat"])

      assert result["winston"]["counters_hard"] == ["widowmaker", "hanzo"]
      assert result["winston"]["counters_soft"] == []
      assert result["winston"]["countered_hard"] == ["reaper"]
      assert result["winston"]["countered_soft"] == ["d_va"]
      assert result["winston"]["score"] == 0.17
    end
  end
end

defmodule OTC.NameUtilTest do
  use ExSpec

  describe "closest" do
    it "returns the hero name that most closely matches the provided name" do
      assert OTC.NameUtil.closest("wdw") == "widowmaker"
      assert OTC.NameUtil.closest("mee") == "mccree"
      assert OTC.NameUtil.closest("rer") == "reaper"
      assert OTC.NameUtil.closest("wdw") == "widowmaker"
    end

    it "converts punctuation to underscores" do
      assert OTC.NameUtil.closest("D.Va") == "d_va"
    end
  end
end

defmodule OTC.Counter do
  def find_all(enemies) do
    Enum.reduce(Dict.keys(OTC.NameUtil.heroes), %{}, fn(hero, acc) ->
      counters_hard = counters(hero, enemies, "hard")
      counters_soft = counters(hero, enemies, "soft")

      countered_hard = countered_by(hero, enemies, "hard")
      countered_soft = countered_by(hero, enemies, "soft")

      score = score_from_counters(counters_hard, counters_soft, countered_hard, countered_soft)

      Map.put(acc, hero, %{
        "counters_hard" => counters_hard,
        "counters_soft" => counters_soft,
        "countered_hard" => countered_hard,
        "countered_soft" => countered_soft,
        "score" => score,
      })
    end)
  end

  defp countered_by(character, enemies, counter_type) do
    counter(character, counter_type)
    |> MapSet.new
    |> MapSet.intersection(MapSet.new(enemies))
    |> MapSet.to_list
  end

  defp counters(character, enemies, counter_type) do
    result = Enum.filter(enemies, fn(enemy) ->
      Enum.member?(counter(enemy, counter_type), character)
    end)
  end

  defp score_from_counters(counters_hard, counters_soft, countered_hard, countered_soft) do
    (Enum.count(counters_hard) / 3) + (Enum.count(counters_soft) / 6) - (Enum.count(countered_hard) / 3) - (Enum.count(countered_soft) / 6)
    |> Float.round(2)
  end

  defp counter(character_name, counter_type) do
    result = OTC.NameUtil.heroes
    |> Dict.get(character_name)
    |> Dict.get(counter_type)

    result || []
  end
end

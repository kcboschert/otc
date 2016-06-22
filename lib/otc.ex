defmodule OTC do
  def main(args) do
    {flags, enemies, _} = OptionParser.parse(args, strict: [verbose: :boolean], aliases: [v: :verbose])

    enemy_names = Enum.map(enemies, &OTC.NameUtil.closest/1)

    best_heroes = counter_heroes(enemy_names)

    if flags[:verbose] do
      display_long(best_heroes)
    else
      display_short(best_heroes)
    end

    IO.puts "Enemies: #{Enum.join(enemy_names, ", ")}"
  end

  defp display_short(best_heroes) do
    Enum.reduce(best_heroes, [], fn({hero, values}, acc) ->
      acc ++ ["#{values["score"]} #{hero}"]
    end)
    |> Enum.each(&IO.puts/1)

    IO.puts ""
  end

  defp display_long(best_heroes) do
    Enum.each(best_heroes, fn(hero) ->
      display_hero(hero)
    end)
  end

  defp counter_heroes(heroes) do
    heroes
    |> OTC.Counter.find_all
    |> Enum.sort(fn({_k1, v1}, {_k2, v2} ) ->
      v2["score"] > v1["score"]
    end)
  end

  defp display_hero({hero, %{"countered_hard" => countered_hard, "countered_soft" => countered_soft, "counters_hard" => counters_hard, "counters_soft" => counters_soft, "score" => score}}) do
    IO.puts "**********************************************************"
    IO.puts "#{hero}, Score: #{score}"
    IO.puts "Counters (hard): #{Enum.join(counters_hard,", ")}"
    IO.puts "Counters (soft): #{Enum.join(counters_soft,", ")}"
    IO.puts "Countered By (hard): #{Enum.join(countered_hard,", ")}"
    IO.puts "Countered By (soft): #{Enum.join(countered_soft,", ")}"
    IO.puts ""
  end
end

defmodule OTC.NameUtil do
  def closest(provided_name) do
    weights = %{delete: 10, insert: 0.1, replace: 1}

    sanitized_name = provided_name
    |> String.replace(".","_")
    |> String.downcase

    heroes
    |> Dict.keys
    |> Enum.min_by(fn(name) ->
      TheFuzz.Similarity.WeightedLevenshtein.compare(sanitized_name, name, weights)
    end)
  end

  def heroes do
    File.cwd!
    |> Path.join("config/heroes.yml")
    |> YamlElixir.read_from_file(atoms: true)
  end
end

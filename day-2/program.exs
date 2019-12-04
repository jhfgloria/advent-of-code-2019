defmodule DayTwo do
  def intcode(list, position) do
    case Enum.at(list, position) do
      nil -> Enum.at(list, 0)
      99 -> Enum.at(list, 0)
      1 -> intcode(list |> List.update_at(Enum.at(list, position + 3), &(&1 - &1 + Enum.at(list, Enum.at(list, position + 1)) + Enum.at(list, Enum.at(list, position + 2)))), position + 4)
      2 -> intcode(list |> List.update_at(Enum.at(list, position + 3), &(&1 - &1 + Enum.at(list, Enum.at(list, position + 1)) * Enum.at(list, Enum.at(list, position + 2)))), position + 4)
      _ -> intcode(list, position + 4)
    end
  end
end
{:ok, body} = File.read("input.txt")

codes =
  body
  |> String.split(",", trim: true)
  |> Enum.map(fn x -> String.to_integer(x) end)
  # |> List.update_at(1, &(&1 - &1 + 12))
  # |> List.update_at(2, &(&1 - &1 + 2))

# IO.puts(DayTwo.intcode(codes, 0))

complex = fn({n, v}, e) ->
  codes
  |> List.update_at(1, fn _ -> n end)
  |> List.update_at(2, fn _ -> v end)
  |> DayTwo.intcode(0)
  |> (fn x -> if x == e do {n,v} else nil end end).()
end

 0..99
 |> Enum.flat_map(fn x -> Enum.zip(0..99, Enum.map(0..99 , fn _ -> x end)) end)
 |> Enum.map(&(complex.(&1, 19690720)))
 |> Enum.filter(&(!is_nil(&1)))
 |> IO.inspect



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
  |> List.update_at(1, &(&1 - &1 + 12))
  |> List.update_at(2, &(&1 - &1 + 2))

IO.puts(DayTwo.intcode(codes, 0))

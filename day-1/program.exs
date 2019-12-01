defmodule DayOne do
  def sum_fuel(masses) do
    masses
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> x / 3 end)
    |> Enum.map(fn x -> floor(x) end)
    |> Enum.map(fn x -> x - 2 end)
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  def alt_sum_fuel(masses) do
    masses
    |> Enum.map(fn x -> String.to_integer(x) end)
    |> Enum.map(fn x -> iterative_mass(x, 0) end)
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  defp iterative_mass(mass, sum) do
    calc_mass = floor(mass / 3) - 2

    case calc_mass do
      x when x > 0 -> iterative_mass(calc_mass, sum + calc_mass)
      _ -> sum
    end
  end
end

{:ok, body} = File.read("input.txt")
masses = body |> String.split("\n", trim: true)

IO.puts(DayOne.sum_fuel(masses))
IO.puts(DayOne.alt_sum_fuel(masses))

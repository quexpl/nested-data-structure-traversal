sections = [
  %{
    "title" => "Getting started",
    "reset_lesson_position" => false,
    "lessons" => [
      %{"name" => "Welcome"},
      %{"name" => "Installation"}
    ]
  },
  %{
    "title" => "Basic operator",
    "reset_lesson_position" => false,
    "lessons" => [
      %{"name" => "Addition / Subtraction"},
      %{"name" => "Multiplication / Division"}
    ]
  },
  %{
    "title" => "Advanced topics",
    "reset_lesson_position" => true,
    "lessons" => [
      %{"name" => "Mutability"},
      %{"name" => "Immutability"}
    ]
  }
]

lesson_counter = fn index, sections ->
  cond do
    index > 1 ->
      (Enum.take(sections, index - 1)
       |> Enum.map(fn x -> Enum.count(x["lessons"]) end)
       |> Enum.sum()) + 1

    true ->
      1
  end
end

for {section, index} <- Enum.with_index(sections, 1) do
  lesson_index =
    case section["reset_lesson_position"] do
      true -> 1
      false -> lesson_counter.(index, sections)
    end

  lessons =
    for {lessons, index} <- Enum.with_index(section["lessons"], lesson_index),
        do: Map.put(lessons, "position", index)

  section
  |> Map.put("position", index)
  |> Map.replace("lessons", lessons)
end
|> IO.inspect()

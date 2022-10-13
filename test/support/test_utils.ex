defmodule Noeticards.TestUtils do
  import Noeticards.Factory

  def insert_this_many(how_many, thing_to_insert, params \\ %{})
      when how_many >= 1 and thing_to_insert in [:card, :deck] do
    for _count <- 1..how_many do
      insert(thing_to_insert, params)
    end
  end
end

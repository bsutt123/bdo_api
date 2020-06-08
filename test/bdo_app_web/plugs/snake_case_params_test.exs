defmodule BdoAppWeb.Plugs.SnakeCaseParamsTest do
  use BdoAppWeb.ConnCase

  test "empty params are not transformed", %{conn: conn} do
    assert conn |> assign_params(%{}) |> call_plug |> assert_params(%{})
  end

  test "snake case params are maintained", %{conn: conn} do
    assert conn
           |> assign_params(%{"snake_case" => "snake"})
           |> call_plug
           |> assert_params(%{"snake_case" => "snake"})
  end

  test "params transformed to snake case when starting camel case", %{conn: conn} do
    assert conn
           |> assign_params(%{"camelCase" => "camel"})
           |> call_plug
           |> assert_params(%{"camel_case" => "camel"})
  end

  test " params nested inside maps are transformed", %{conn: conn} do
    assert conn
           |> assign_params(%{"camelCase" => "camel", "outerCamel" => %{"innerCamel" => "inner"}})
           |> call_plug
           |> assert_params(%{
             "camel_case" => "camel",
             "outer_camel" => %{"inner_camel" => "inner"}
           })
  end

  test "params nested in a list are all transformed", %{conn: conn} do
    assert conn
           |> assign_params(%{"camelCase" => [%{"innerCamelList" => 1}, %{"innerCamelList" => 2}]})
           |> call_plug
           |> assert_params(%{
             "camel_case" => [
               %{
                 "inner_camel_list" => 1
               },
               %{
                 "inner_camel_list" => 2
               }
             ]
           })
  end

  def call_plug(conn), do: conn |> BdoAppWeb.Plugs.SnakeCaseParams.call(%{})

  def assign_params(conn, params) do
    %{conn | params: params}
  end

  def assert_params(conn, params) do
    conn.params == params
  end
end

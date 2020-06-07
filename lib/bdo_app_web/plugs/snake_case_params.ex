defmodule BdoAppWeb.Plugs.SnakeCaseParams do
  def init(opts), do: opts

  def call(%{params: params} = conn, _default) do
    %{conn | params: snake_case_params(params)}
  end

  def call(conn, _default), do: conn

  def snake_case_params(%{} = params) do
    params
    |> Enum.map(&snake_case_object/1)
    |> Enum.into(%{})
  end

  def snake_case_params(params) when is_list(params) do
    params
    |> Enum.map(&snake_case_params/1)
  end

  def snake_case_object({key, %{} = value}) do
    {snake_case_key(key), snake_case_params(value)}
  end

  def snake_case_object({key, value}) when is_list(value) do
    {snake_case_key(key), snake_case_params(value)}
  end

  def snake_case_object({key, value}) do
    {snake_case_key(key), value}
  end

  def snake_case_key(key) when is_atom(key) do
    key |> Atom.to_string() |> Recase.to_snake()
  end

  def snake_case_key(key) when is_binary(key) do
    key |> Recase.to_snake()
  end
end

defmodule BdoAppWeb.Plugs.SnakeCaseParams do
  use BdoAppWeb.Services.ParamsTransformer, transformer: fn x -> Recase.to_snake(x) end

  def init(opts), do: opts

  def call(%{params: params} = conn, _default) do
    %{conn | params: transform_params(params)}
  end

  def call(conn, _default), do: conn
end

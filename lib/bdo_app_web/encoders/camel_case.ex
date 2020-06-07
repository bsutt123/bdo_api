defmodule BdoAppWeb.Encoders.CamelCase do
  def encode_to_iodata!(data) do
    IO.inspect(data)

    cameled = camel_case_params(data)

    IO.inspect(cameled)

    Jason.encode_to_iodata!(cameled)
  end

  def inspect(data) do
    IO.inspect(data)

    data
  end

  def camel_case_params(%{} = params) do
    params
    |> Enum.map(&camel_case_object/1)
    |> Enum.into(%{})
  end

  def camel_case_object({key, %{} = value}) do
    {camel_case_key(key), camel_case_params(value)}
  end

  def camel_case_object({key, value}) do
    {camel_case_key(key), value}
  end

  def camel_case_key(key) when is_atom(key) do
    key |> Atom.to_string() |> Recase.to_camel()
  end

  def camel_case_key(key) when is_binary(key) do
    key |> Recase.to_camel()
  end
end

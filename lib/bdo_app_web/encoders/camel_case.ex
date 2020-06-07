defmodule BdoAppWeb.Encoders.CamelCase do
  use BdoAppWeb.Services.ParamsTransformer, transformer: fn x -> Recase.to_camel(x) end

  def encode_to_iodata!(data) do
    data
    |> transform_params
    |> Jason.encode_to_iodata!()
  end
end

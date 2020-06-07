defmodule BdoAppWeb.Services.ParamsTransformer do
  defmacro __using__(options) do
    quote do
      def transform_params(%{} = params) do
        params
        |> Enum.map(&transform_object/1)
        |> Enum.into(%{})
      end

      def transform_params(params) when is_list(params) do
        params
        |> Enum.map(&transform_params/1)
      end

      def transform_object({key, %{} = value}) do
        {transform_key(key), transform_params(value)}
      end

      def transform_object({key, value}) when is_list(value) do
        {transform_key(key), transform_params(value)}
      end

      def transform_object({key, value}) do
        {transform_key(key), value}
      end

      def transform_key(key) when is_binary(key) do
        key |> unquote(options[:transformer]).()
      end

      def transform_key(key) when is_atom(key) do
        key |> Atom.to_string() |> unquote(options[:transformer]).()
      end
    end
  end
end

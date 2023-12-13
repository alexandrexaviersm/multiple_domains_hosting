defmodule Store.BeaconDataSource do
  @behaviour Beacon.DataSource.Behaviour

  def live_data(:books, ["home"], _params) do
    %{vals: ["first", "second", "third"]}
  end

  def live_data(:books, ["blog", blog_slug], _params) do
    %{blog_slug_uppercase: String.upcase(blog_slug)}
  end

  def live_data(_, _, _), do: %{}
end

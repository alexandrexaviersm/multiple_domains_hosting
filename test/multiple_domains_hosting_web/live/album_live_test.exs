defmodule StoreWeb.AlbumLiveTest do
  use StoreWeb.ConnCase

  import Phoenix.LiveViewTest
  import Store.AlbumsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_album(_) do
    album = album_fixture()
    %{album: album}
  end

  describe "Index" do
    setup [:create_album]

    test "lists all albums", %{conn: conn, album: album} do
      {:ok, _index_live, html} = live(conn, ~p"/albums")

      assert html =~ "Listing Albums"
      assert html =~ album.name
    end

    test "saves new album", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/albums")

      assert index_live |> element("a", "New Album") |> render_click() =~
               "New Album"

      assert_patch(index_live, ~p"/albums/new")

      assert index_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#album-form", album: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/albums")

      html = render(index_live)
      assert html =~ "Album created successfully"
      assert html =~ "some name"
    end

    test "updates album in listing", %{conn: conn, album: album} do
      {:ok, index_live, _html} = live(conn, ~p"/albums")

      assert index_live |> element("#albums-#{album.id} a", "Edit") |> render_click() =~
               "Edit Album"

      assert_patch(index_live, ~p"/albums/#{album}/edit")

      assert index_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#album-form", album: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/albums")

      html = render(index_live)
      assert html =~ "Album updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes album in listing", %{conn: conn, album: album} do
      {:ok, index_live, _html} = live(conn, ~p"/albums")

      assert index_live |> element("#albums-#{album.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#albums-#{album.id}")
    end
  end

  describe "Show" do
    setup [:create_album]

    test "displays album", %{conn: conn, album: album} do
      {:ok, _show_live, html} = live(conn, ~p"/albums/#{album}")

      assert html =~ "Show Album"
      assert html =~ album.name
    end

    test "updates album within modal", %{conn: conn, album: album} do
      {:ok, show_live, _html} = live(conn, ~p"/albums/#{album}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Album"

      assert_patch(show_live, ~p"/albums/#{album}/show/edit")

      assert show_live
             |> form("#album-form", album: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#album-form", album: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/albums/#{album}")

      html = render(show_live)
      assert html =~ "Album updated successfully"
      assert html =~ "some updated name"
    end
  end
end

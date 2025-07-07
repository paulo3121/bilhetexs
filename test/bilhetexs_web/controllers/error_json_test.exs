defmodule BilhetexsWeb.ErrorJSONTest do
  use BilhetexsWeb.ConnCase, async: true

  test "renders 404" do
    assert BilhetexsWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert BilhetexsWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end

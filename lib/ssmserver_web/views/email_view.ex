defmodule SsmserverWeb.EmailView do
  use SsmserverWeb, :view
  def safe_render(template, assigns \\ %{})

  def safe_render(template, assigns) when not is_map(assigns) do
    safe_render(template, Enum.into(assigns, %{}))
  end

  def safe_render(template, assigns) do
    case render(template, assigns) do
      {:safe, rendered_html} ->
        rendered_html

      _ ->
        ""
    end
  end
end

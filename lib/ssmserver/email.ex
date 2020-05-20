defmodule Ssmserver.Email do
  import Bamboo.Email
  use Bamboo.Phoenix, view: SsmserverWeb.EmailView
  def alert_email(to, product_name) do
    new_email()
      |> to(to)
      |> from("hassanzaher11@gmail.com")
      |> subject("Low Stock In your Inventory!")
      |> put_html_layout({SsmserverWeb.EmailView, "email.html"})
      |> render(:email,
      title: "Low stock of product : #{product_name}",
      p1:
      SsmserverWeb.EmailView.safe_render("alert.html",
          product_name: product_name
        )
    )
  end

  def rep_email(to, product_name, new_quantity) do
    new_email()
    |> to(to)
    |> from("hassanzaher11@gmail.com")
    |> subject("New order of #{product_name} is needed!")
    |> put_html_layout({SsmserverWeb.EmailView, "email.html"})
    |> render(:email,
    title: "Low stock of product : #{product_name}",
    p1:
    SsmserverWeb.EmailView.safe_render("replenishment.html",
        product_name: product_name,
        new_quantity: new_quantity
      )
    )
  end

    # or pipe using Bamboo.Email functions
    # new_email
    # |> to("foo@example.com")
    # |> from("me@example.com")
    # |> subject("Welcome!!!")
    # |> html_body("<strong>Welcome</strong>")
    # |> text_body("welcome")

end

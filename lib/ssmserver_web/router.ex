defmodule SsmserverWeb.Router do
  use SsmserverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", SsmserverWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api" do
    # pipeline through which the request have to be routed
    pipe_through(:api)

    forward "/graphiql",
            Absinthe.Plug.GraphiQL,
            schema: SsmserverWeb.Schema,
            interface: :simple

    forward("/", Absinthe.Plug, schema: SsmserverWeb.Schema)
  end

  # Other scopes may use custom stacks.
  # scope "/api", SsmserverWeb do
  #   pipe_through :api
  # end
end

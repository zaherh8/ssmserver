defmodule SsmserverWeb.Router do
  use SsmserverWeb, :router
  alias SsmserverWeb.FileController
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

  scope "/"  do
    pipe_through :browser

    get "/", FileController, :index
  end


  scope "/api" do
    # pipeline through which the request have to be routed
    pipe_through(:api)
    resources("/log_file", FileController)
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

defmodule BlogWeb.Router do
  use BlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug(KoobaServer.Guardian.AuthPipeline)
    plug BlogWeb.Plugs.AuthContext
  end

  scope "/", BlogWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through :api
    forward "/graphql", Absinthe.Plug.GraphiQL, schema: BlogWeb.Absinthe.Schema
  end
end

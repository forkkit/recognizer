defmodule RecognizerWeb.Router do
  use RecognizerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug RecognizerWeb.Plugs.VerifyAudience
  end

  pipeline :auth do
    plug RecognizerWeb.Plugs.AuthenticationPipeline
  end

  scope "/", RecognizerWeb do
    pipe_through [:api, :auth]

    get "/me", UsersController, :me
  end

  scope "/auth", RecognizerWeb do
    pipe_through :api

    post "/login", AuthController, :login
    post "/exchange", AuthController, :exchange
  end
end

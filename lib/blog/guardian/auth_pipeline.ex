defmodule KoobaServer.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :blog,
    module: Blog.Guardian

  # I have turned off error so, no need for this
  # error_handler: Blog.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  # plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, allow_blank: true)
end

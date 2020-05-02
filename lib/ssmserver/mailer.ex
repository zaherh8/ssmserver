defmodule Ssmserver.Mailer do
  use Bamboo.Mailer, otp_app: :ssmserver
  # use Mailgun.Client,
  #   domain: Application.get_env(:ssmserver, :mailgun_domain),
  #   key: Application.get_env(:ssmserver, :mailgun_key)
    # mode: :test, # Alternatively use Mix.env while in the test environment.
    # test_file_path: "C://Users//User//Desktop//ssmserver//lib//ssmserver//mailgun.json"
    # def my_first_email() do
    #   send_email to: "hassanzaher11@gmail.com",
    #   from: "hassanzaher11@gmail.com",
    #   subject: "My first email",
    #   text: "This is an email send with Phoenix and Mailgun"

    # end
end

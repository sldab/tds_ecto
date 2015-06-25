defmodule TDS.Ecto.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tds_ecto,
      version: "0.2.5",
      elixir: "~> 1.0",
      deps: deps,
      description: description,
      package: package
   ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:tds, :ecto]]
  end

  defp deps do
    [
      {:ecto, "~> 0.12.1"},
      {:tds, "~> 0.2"},
      {:poison, only: :test}
    ]
  end

  defp description do
    """
    MSSQL / TDS Adapter for Ecto.
    """
  end

  defp package do
    [contributors: ["Justin Schneck"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/livehelpnow/tds_ecto"}]
  end
end

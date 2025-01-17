defmodule EtsGive do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(EtsGive.Server, []),
      worker(EtsGive.Manager, [])
    ]

    opts = [strategy: :one_for_one, name: EtsGive.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

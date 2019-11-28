defmodule EtsGiveTest do
  use ExUnit.Case
  doctest EtsGive

  test "incrementing ets survives termination" do
    Process.flag(:trap_exit, true)
    Application.ensure_all_started(:etsgive)
    Process.monitor(EtsGive.Server)

    EtsGive.Server.inc()
    EtsGive.Server.die()

    receive do
      {:DOWN, _, :process, {EtsGive.Server, _}, :killed} ->
        EtsGive.Manager.wait_for_server()
        # Give it a second for the ETS table gift to complete
        Process.sleep(1000)
    end

    assert EtsGive.Server.count() == 1
  end
end

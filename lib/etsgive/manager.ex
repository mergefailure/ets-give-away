defmodule EtsGive.Manager do
  use GenServer
  @name __MODULE__

  require Logger

  defmodule State do
    defstruct table_id: nil
  end

  ### =========================
  ### API
  ### =========================

  def gift() do
    GenServer.cast(@name, {:gift, {:count, 0}})
  end

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    gift()
    {:ok, %State{}}
  end

  def handle_call(_msg, _from, state) do
    {:reply, :ok, state}
  end

  def handle_cast({:gift, data}, state) do
    server = Process.whereis(EtsGive.Server)
    Process.link(server)
    table_id = :ets.new(@name, [:protected, :named_table])
    :ets.insert(table_id, data)
    :ets.setopts(table_id, {:heir, self(), data})
    :ets.give_away(table_id, server, data)
    {:noreply, struct(state, table_id: table_id)}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def handle_info({:EXIT, _from, :killed}, state) do
    table_id = state.table_id
    IO.puts("Server !! is now dead, farewell table id #{inspect(table_id)}")
    {:noreply, state}
  end

  def handle_info({:"ETS-TRANSFER", table_id, from, data}, state) do
    server = wait_for_server()

    IO.puts(
      "Warning table id: #{inspect(table_id)}, Owner Pid: #{inspect(from)}, server (#{
        inspect(from)
      }) => manager(#{inspect(self())}) handing table id #{inspect(table_id)}"
    )

    Process.link(server)
    :ets.give_away(table_id, server, data)
    {:noreply, struct(state, table_id: table_id)}
  end

  def wait_for_server() do
    case Process.whereis(EtsGive.Server) do
      nil ->
        :timer.sleep(1)
        wait_for_server()

      pid ->
        pid
    end
  end

  def terminate(_reason, _state) do
    :ok
  end
end

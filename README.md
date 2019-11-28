# EtsGive

Inspiration 

`https://github.com/DeadZen/etsgive` 


```
$ iex -S mix 
iex(2)> EtsGive.Server.check
:ok
iex(3)> table id: EtsGive.Manager, data: [count: 0]
:ok
iex(8)> EtsGive.Server.inc
Counter: 1
:ok
iex(9)> EtsGive.Server.inc
:ok
Counter: 2
iex(10)> EtsGive.Server.inc
Counter: 3
:ok
```
Kill the server

```
iex(11)> EtsGive.Server.die 
11:25:57.367 [error] GenServer EtsGive.Server terminating
** (stop) killed
    (etsgive) lib/etsgive/server.ex:43: EtsGive.Server.handle_cast/2
    (stdlib) gen_server.erl:637: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:711: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", :die}
State: %EtsGive.Server.State{table_id: EtsGive.Manager}
Warning table id: EtsGive.Manager, Owner Pid: #PID<0.176.0>, server (#PID<0.176.0>) => manager(#PID<0.177.0>) handing table id EtsGive.Manager
Server !! is now dead, farewell table id EtsGive.Manager
manager(#PID<0.177.0>) -> server(#PID<0.186.0>), getting table id EtsGive.Manager
nil
```

Wait a second for transfer to complete, then fetch the count

```
iex(13)> EtsGive.Server.count() 
:3
```



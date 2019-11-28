# EtsGive

Inspiration 

`https://github.com/DeadZen/etsgive` 


```
$ iex -S mix 
iex(2)> EtsGive.Server.check
:ok
iex(3)> table id: 245784, data: [count: 0]

nil
iex(8)> EtsGive.Server.inc
Counter: 1
:ok
iex(9)> EtsGive.Server.inc
:ok
Counter: 2
iex(10)> EtsGive.Server.inc
Counter: 3
:ok
iex(11)> EtsGive.Server.die # Serverが死ぬ
:ok
iex(13)> EtsGive.Server.inc
Counter: 4
:ok
```



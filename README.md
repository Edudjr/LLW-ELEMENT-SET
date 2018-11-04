# LLW-ELEMENT-SET


This is an implementation for a Last-Writer-Wins Conflict-free Replicated Datatype:
https://github.com/pfrazee/crdt_notes#last-writer-wins-register-lww-register

You can have many "replicas" for the ElementSet, and modify then by adding or removing Integer elements.
Whenever needed, you can merge the replicas using `ElementSet.merged()` and get the current elements by calling `converged()`

![gif](https://i.postimg.cc/BnVm2WRw/llw2.gif)


Inspired by this page:
https://edvorg.github.io/lww-element-set/resources/public/index.html

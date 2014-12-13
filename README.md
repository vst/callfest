# callfest: An R Package for calling functions over a combination of arguments

`callfest` is a simple wrapper over your functions which consumes a
set of arguments, computes all combinations of these arguments and
invokes your function on each of the combinations.

It allows parallel invocations and computes the total elapsed time,
too.

Simply:

    callfest(list, a=1:2, b=3:4)

will give you the list of all combinations:

    [[1]]
    [[1]]$a
    [1] 1

    [[1]]$b
    [1] 3


    [[2]]
    [[2]]$a
    [1] 2

    [[2]]$b
    [1] 3


    [[3]]
    [[3]]$a
    [1] 1

    [[3]]$b
    [1] 4


    [[4]]
    [[4]]$a
    [1] 2

    [[4]]$b
    [1] 4

You can see the elapsed time:

    R> res <- callfest(list, a=1:2, b=3:4)
    R> attr(res, "time")
       user  system elapsed
          0       0       0

You can call the function more than once:

    R> control <- callfestControl(list, N=2)
    R> res <- callfest(control, a=1:2, b="a")
    [[1]]
    [[1]][[1]]
    [[1]][[1]]$a
    [1] 1

    [[1]][[1]]$b
    [1] a
    Levels: a


    [[1]][[2]]
    [[1]][[2]]$a
    [1] 1

    [[1]][[2]]$b
    [1] a
    Levels: a



    [[2]]
    [[2]][[1]]
    [[2]][[1]]$a
    [1] 2

    [[2]][[1]]$b
    [1] a
    Levels: a


    [[2]][[2]]
    [[2]][[2]]$a
    [1] 2

    [[2]][[2]]$b
    [1] a
    Levels: a



    Elapsed 0.000000 seconds

Parallel computing is possible by passing `parallel=TRUE` to the
control object.
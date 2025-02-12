# Benchmarks for the Gröbner walk

This folder contains benechmarks and results for the implementation of the Gröbner walk.

For reproducability, this folder includes a `Project.toml` and `Manifest.toml`.
Before running the benchmarks, the environment needs to be instantiated in by executing 
the following inside a `julia` session
```julia
(@v1.10) pkg> activate .
(benchmark) pkg> resolve
```
The `Pkg` REPL mode may be accessed by pressing `]` on an empty line.

The benchmark suite may be run using 
```sh
./run_benchmarks.sh
```

The script assumes `timeout` from GNU coreutils 8.32. On macOS for example, one needs to 
install GNU coreutils first. In that case, `timeout` might be available as `gtimeout`.
Either define an alias before executing `run_benchmarks.sh` or edit the script.

## Explanations for `results.csv`
The benchmarks were run on two machines, identified by their hostname. In both cases we used Julia 1.10.7 and `OSCAR` 1.2.2.
For our runs of the benchmarks, we restricted the computations to `1/2 * MAX_RAM`.
- `amenominakanushi` refers to a MacBook Pro with a 2,4 GHz Apple M2 Max, 32 GB of memory running macOS 15.2.
- `schildow` refers to a Linux machine with a 3.30GHz Intel(R) Core(TM) i5-4590, 16 GB of memory running openSUSE Leap 15.6.

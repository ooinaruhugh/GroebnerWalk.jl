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



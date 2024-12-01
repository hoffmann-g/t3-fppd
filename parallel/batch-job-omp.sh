#!/bin/bash
#SBATCH --job-name=omp_test_cases                   # Job name
#SBATCH --nodes=1                                   # Ensure all tasks are on one node
#SBATCH --ntasks=1                                  # Only one process (OpenMP uses threads, not tasks)
#SBATCH --cpus-per-task=16                          # Max CPUs available for testing
#SBATCH --time=03:00:00                             # Max total job runtime
#SBATCH --output=omp_test_cases_output_%j.log       # Log file (one for the whole job, %j is the job ID)
#SBATCH --error=omp_test_cases_error_%j.log         # Error log file
#SBATCH --exclusive                                 # Allocate the node exclusively (comment out for shared access)
#SBATCH --mail-type=ALL                             # Send email for all job events (start, end, fail)
#SBATCH --mail-user=santos.guilherme05@edu.pucrs.br # Email address for notifications

# The Atlantica cluster has 16 nodes (machines), each machine has 2 cpus 8 cores each, so 16 cores per machine and 32 threads per machine
# totalizing 512 threads in the whole cluster

# This version uses 1 node with only one task (since OpenMP uses threads, not tasks)
# The 'cpus-per-task' define all the cores of the cpu available for the task:
# in this case, since it's defined to 16, all the cores of both processors will be used by the task running the OpenMP code

# The 'THREADS' environment variable is used to define the number of threads that will read and be used by the OpenMP code
# This should be at max 16 (cores by node), except when working with -:
# In this case, when using -, the number of threads can be at max 32 (2 threads * 16 cpu cores from the node)

# In the project description:
# "Para a versão em OpenMP, variar o número de threads de 2 em 2, até ocupar todos os núcleos do computador (considerar também Hyper-Threading)."

# So, the test cases cosists in increasing the number of tasks by 2 until all the cores of the cpu are used:
# without -:
#   2 threads  - 1 of 16 cores
#   ...
#   16 threads - 16 of 16 cores
# with -:
#   18 threads - 16 of 16 cores
#   ...
#   32 threads - 16 of 16 cores

# Compile code
gcc mandelbrot_openmp.c -o mandelbrot_omp -fopenmp -lm

# Run test cases
echo "Starting tests with OpenMP without hyper-threading:"

THREADS=2
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=4
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=6
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=8
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=10
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=12
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=14
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=16
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

echo "Starting tests with OpenMP with hyper-threading:"

THREADS=18
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=20
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=22
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=24
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=26
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=28
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=30
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

THREADS=32
echo "Running with $THREADS threads..."
export OMP_NUM_THREADS=$THREADS
./mandelbrot_omp

echo "Tests finished!"
echo "Log saved in $WORKDIR/omp_test_cases_output_%j.log"
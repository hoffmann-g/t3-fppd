#!/bin/bash
#SBATCH --job-name=mpi_test_cases                   # Job name
#SBATCH --nodes=2                                   # Specify the number of nodes
#SBATCH --ntasks=32                                 # Max number of tasks (use mpirun --oversubscribe for more)
#SBATCH --cpus-per-task=1                           # Number of CPU per tasks
#SBATCH --time=03:00:00                             # Max total job runtime
#SBATCH --output=mpi_test_cases_output_%j.log       # Log file (one for the whole job, %j is the job ID)
#SBATCH --error=mpi_test_cases_error_%j.log         # Error log file
#SBATCH --exclusive                                 # Allocate the node exclusively (comment out for shared access)
#SBATCH --mail-type=ALL                             # Send email for all job events (start, end, fail)
#SBATCH --mail-user=santos.guilherme05@edu.pucrs.br # Email address for notifications

# The Atlantica cluster has 16 nodes (machines), each machine has 2 cpus 8 cores each, so 16 cores per machine and 32 threads per machine
# totalizing 512 threads in the whole cluster

# This version uses 2 nodes (machines of cluster) with 32 tasks (processes) running the MPI code
# The 'cpus-per-task' define all the cores of the cpu available for the task:
# in this case, since it's set 1, only one core of the cpu will be used by the task running the MPI code

# The 'processes' variable is used to define the number of tasks that will be used by the MPI code,
# This should be at max 16 by node, since this should use only 1 core by task and there are 16 cores per node
# when working with hyper-threading, the number of tasks can be increased to 32 (2 tasks per core = 2 threads)

# In the project description:
# "Para a versão MPI, variar o número de processos de 2 em 2. Utilizar um segundo nó do cluster quando a quantidade de processos ultrapassar os núcleos
# disponíveis em um único nó (testar com e sem Hyper-Threading)."

# So, the test cases cosists in increasing the number of tasks by 2 until all the cores of the cpu are used:
# single node:
#   2 threads  - 1 of 16 cores
#   ...
#   16 threads - 16 of 16 cores
#   with hyperthreading:
#       18 threads - 16 of 16 cores
#       ...
#       32 threads - 16 of 16 cores
# two nodes:
#   18 threads - 16 of 32 cores
#   ...
#   32 threads - 16 of 32 cores
#   with hyperthreading:
#       34 threads - 16 of 32 cores
#       ...
#       64 threads - 16 of 32 cores

# Dynamically set working directory
WORKDIR="/home/$USER/parallel-mandelbrot"

# Compile code
mpicc parallel/mandelbrot_mpi.c -o mandelbrot_mpi -lm

# Run test cases
echo "Starting tests in MPI with single node and without hyperthreading:"

processes=2
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=4
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=6
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=8
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=10
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=12
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=14
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=16
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

echo "Starting tests in MPI with double node and without hyperthreading:"

processes=18
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=20
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=22
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=24
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=26
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=28
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=30
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

processes=32
echo "Running with -np $processes"
mpirun -np $processes mandelbrot_mpi

echo "Starting tests in MPI with double node and with hyperthreading:"

processes=34
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=36
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=38
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=40
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=42
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=44
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=46
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=48
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=50
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=52
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=54
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=56
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=58
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi\

processes=60
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=62
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

processes=64
echo "Running with -np $processes"
mpirun --oversubscribe -np $processes mandelbrot_mpi

echo "Tests finished!"
echo "Log saved in $WORKDIR/mpi_test_cases_output_%j.log"

# FedPylot by Cyprien Quéméneur, GPL-3.0 license

import argparse
import os
import shutil
import tarfile
from mpi4py import MPI


def copy_and_extract(dataset: str, local_storage: str, file: str) -> None:
    """Copy and extract the local dataset."""
    destination_directory = f'{local_storage}/fedpylot/datasets/{dataset}/'
    shutil.copy(f'datasets/{dataset}/{file}', destination_directory)
    tar_file_path = f'{local_storage}/fedpylot/datasets/{dataset}/{file}'
    with tarfile.open(tar_file_path, 'r') as tar:
        tar.extractall(path=destination_directory)


def transfer_local_dataset(cPATH:str,dataset: str, node_rank: int) -> None:
    """Copy the local dataset from the network storage to the compute node local storage (meant for temporary files).""" # new update is to distribute DS over clients
    CURRENT_DIR = cPATH #os.environ.get('CURRENT_DIR')  # path to the compute node local storage
    print(f'Node of rank {node_rank}. WORKING_DIR is {CURRENT_DIR}')
    if node_rank == 0:
        CURRENT_DIR = f'{CURRENT_DIR}/datasets/{dataset}/server'
        #copy_and_extract(dataset, slurm_tmpdir, 'server.tar')
    else:
        CURRENT_DIR = f'{CURRENT_DIR}/datasets/{dataset}/client{node_rank}'
        #copy_and_extract(dataset, slurm_tmpdir, f'client{node_rank}.tar')
    print(f"\nNode of rank {node_rank}."
          f" \nDataset directory: {CURRENT_DIR}"
          f" \nLocal dataset files: {os.listdir(f'{CURRENT_DIR}/')}")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="MPI program for scatter data")
    parser.add_argument('--cPATH', type=str, help='current path')
    parser.add_argument('--dataset', type=str, help='name of the dataset')
    args = parser.parse_args()
    comm = MPI.COMM_WORLD
    rank = comm.Get_rank()
    transfer_local_dataset(args.cPATH,args.dataset, rank)
    print('\n returned from transfer dataset function')

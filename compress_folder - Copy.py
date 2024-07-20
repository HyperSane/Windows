import tarfile
import os
import sys
import logging

def create_tar_gz(directory, output_filename, compresslevel=9):
    logging.info(f"Starting compression of {directory} into {output_filename}")
    with tarfile.open(output_filename, "w:gz", compresslevel=compresslevel) as tar:
        for root, dirs, files in os.walk(directory):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, start=directory)
                tar.add(file_path, arcname=arcname)
    logging.info(f"Completed compression of {directory} into {output_filename}")

def main():
    logging.basicConfig(filename='compression.log', level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
    if len(sys.argv) != 2:
        print("Usage: compress_folder.py <folder_to_compress>")
        sys.exit(1)

    folder_to_compress = sys.argv[1]
    if not os.path.isdir(folder_to_compress):
        print(f"Error: {folder_to_compress} is not a directory or does not exist.")
        sys.exit(1)

    output_filename = os.path.join(os.path.dirname(folder_to_compress.rstrip(os.sep)), os.path.basename(folder_to_compress.rstrip(os.sep)) + ".tar.gz")

    try:
        create_tar_gz(folder_to_compress, output_filename)
        print(f"Compressed {folder_to_compress} to {output_filename}")
    except Exception as e:
        logging.error(f"Error during compression: {e}")
        print(f"Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()

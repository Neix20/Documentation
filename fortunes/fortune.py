import os
import json
import random
from glob import glob


#region File IO
def read_json(file_path):
    try:
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)
        file.close()

        print(f"Successfully read Data from {file_path}!")

        return data
    except Exception as ex:
        print(f"Error! Unable to read Data from {file_path}! Exception: {ex}")

def write_json(data, file_path):
    try:
        with open(file_path, "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4)
        file.close()

        print(f"Successfully write Data to {file_path}!")
    except Exception as ex:
        print(f"Error! Unable to write Data to {file_path}! Exception: {ex}")
#endregion


def main():

    # Declare File Path
    fp = os.path.join("fortune-py", "data", "*.json")

    data = []

    for t_fp in glob(fp):
        t_data = read_json(t_fp)
        data.extend(t_data)

    random.shuffle(data)

    o_fp = os.path.join("fortune-py", "data", "fortune.json")
    write_json(data, o_fp)

if __name__ == "__main__":
    main()

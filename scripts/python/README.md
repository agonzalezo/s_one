# s_one Devops Skills
Basic projects focused on devops skills.

This python script make some request to the NASA API to obtain Astronomy pictures then format they and convert into html file.
To see full NASA API documentation refer to [NASA](https://api.nasa.gov/#browseAPI)

**Note: If you want to call this API more than 30 times per hour you have to create an API KEY.**

## Pre-Requisites
- Python => 3.10
- Python Venv Module, you can install it using `sudo apt install python3.12-venv -y`
- API NASA API KEY is easy to get one just need your email. [Generate API KEY](https://api.nasa.gov/#signUp)
   - Using **EXPORT** or **SET** define the the variable ***API_KEY*** as environment variable with the API-KEY value or create **.env** file and put the variable on it. 

## Installation
1. Clone this repository (or just [download it](https://github.com/agonzalezo/s_one/archive/refs/heads/main.zip)):
   ```bash
   git clone https://github.com/agonzalezo/s_one.git
   cd s_one/scripts/python
   ```
1. Create a virtual environment.  
   ```bash
    python3 -m venv venv
   ```
1. Activate the virtual environment.  
   ```bash
    ## On windows.
    .\venv\Scripts\Activate.ps1

    ## On Linux
    source ./venv/bin/activate
    ```
1. Install dependences
    ```bash
    pip3 install -r requirements.txt
    ```
## Usage
- To generate the **.html** file
    ```bash
    ## Basically execute api_nasa.py
    python4 api_nasa.py
    ```


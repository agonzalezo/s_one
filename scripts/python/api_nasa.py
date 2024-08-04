import os
import requests
from dotenv import load_dotenv
import html_writer

## Load environment variables
load_dotenv()
API_KEY= os.getenv('API_KEY', 'DEMO_KEY')

url = f"https://api.nasa.gov/planetary/apod"

if __name__ == "__main__":
    print("######### Fetching data from: Nasa APOD API #########")
    try: 
        payload = {'api_key': API_KEY, 'count': 5}
        headers = {}
        response = requests.request("GET", url, headers=headers, params=payload)
        print(response)
        html_writer.write_html(response.json())

    except requests.exceptions.HTTPError as http_error: 
        print("######### Error doing API REQUEST, HTTP Error #########")
        print(http_error)
        print(response.text)
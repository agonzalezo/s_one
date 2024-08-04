import pathlib

## Define html html_template and name.
_file_name=f"{pathlib.Path(__file__).parent.resolve()}/result.html"

## Function to convert JSON data in a html format.
def write_html(json_data):
    html_template = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NASA APOD API</title>
    <style>
        table {{
            width: 100%;
            border-collapse: collapse;
        }}
        th, td {{
            border: 1px solid #ddd;
            padding: 8px;
        }}
        th {{
            background-color: #f2f2f2;
        }}
        tr:hover {{
            background-color: #f5f5f5;
        }}
    </style>
</head>
<body>
    <h1 style="text-align: center;">NASA Astronomy Picture of the Day</h1>
    <table>
        <thead>
            <tr>
                <th>Image</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
"""

    for picture in json_data:
        if picture.get("media_type") == 'image':
            html_template += f"""
                <tr>
                    <td><img src="{picture.get('url', '#')}" alt="NASA APOD IMAGE" width="600" height="300"></td>
                    <td>{picture.get('explanation', 'No Explanation')}</td>
                </tr>
            """

    html_template += """
        </tbody>
    </table>
</body>
</html>
    """

    with open(_file_name, 'w', encoding= 'utf-8') as file:
        file.write(html_template)

    print(f"######### Html file generated on: {_file_name} #########")
    exit(0)
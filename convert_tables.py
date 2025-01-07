import os
import re

def html_table_to_markdown(html_table):
    # Matches HTML table rows and cells
    rows = re.findall(r"<tr>(.*?)</tr>", html_table, re.DOTALL)
    markdown_table = []

    for i, row in enumerate(rows):
        # Match table cells (th or td)
        cells = re.findall(r"<t[hd]>(.*?)</t[hd]>", row, re.DOTALL)
        # Clean and strip HTML tags
        clean_cells = [re.sub(r"<.*?>", "", cell).strip() for cell in cells]

        # Create the header separator for the first row
        if i == 0:
            markdown_table.append("| " + " | ".join(clean_cells) + " |")
            markdown_table.append("| " + " | ".join(["---"] * len(clean_cells)) + " |")
        else:
            markdown_table.append("| " + " | ".join(clean_cells) + " |")

    return "\n".join(markdown_table)

def process_markdown_file(file_path):
    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()

    # Find all HTML tables
    html_tables = re.findall(r"<table>.*?</table>", content, re.DOTALL)

    for html_table in html_tables:
        # Convert each HTML table to Markdown
        markdown_table = html_table_to_markdown(html_table)
        # Replace the HTML table with the Markdown table in the content
        content = content.replace(html_table, markdown_table)

    # Write the updated content back to the file
    with open(file_path, "w", encoding="utf-8") as file:
        file.write(content)

def convert_html_tables_in_directory(directory):
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                print(f"Processing file: {file_path}")
                process_markdown_file(file_path)

# Specify the directory containing Markdown files
directory_path = "./docs/en"  # Update with your directory path
convert_html_tables_in_directory(directory_path)

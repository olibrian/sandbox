import os
import re
import shutil

def html_table_to_markdown(html_table):
    """
    Convert an HTML table (including tags with attributes like class) to a Markdown table.
    """
    print(f"Processing HTML table:\n{html_table}\n")  # Debugging: Anzeigen der gefundenen Tabelle

    # Remove <thead>, <tbody>, and their closing tags
    html_table = re.sub(r"</?(thead|tbody).*?>", "", html_table, flags=re.DOTALL)

    # Match rows in the table
    rows = re.findall(r"<tr.*?>(.*?)</tr>", html_table, re.DOTALL)
    if not rows:
        print("No valid rows found in the table.")  # Debugging: Fehlermeldung bei leerer Tabelle
        return ""  # No valid rows found, return an empty string

    markdown_table = []

    for i, row in enumerate(rows):
        # Match table cells (th or td) and remove their attributes
        cells = re.findall(r"<t[hd](?:.*?)>(.*?)</t[hd]>", row, re.DOTALL)
        if not cells:
            print(f"Skipping empty or invalid row: {row}")  # Debugging: Überspringen von leeren Zeilen
            continue

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
    """
    Process a single Markdown file, converting HTML tables to Markdown tables.
    """
    # Backup the original file
    backup_path = file_path + ".backup"
    shutil.copy(file_path, backup_path)
    print(f"Backup created: {backup_path}")

    with open(file_path, "r", encoding="utf-8") as file:
        content = file.read()

    # Find all HTML tables
    html_tables = re.findall(r"<table.*?>.*?</table>", content, re.DOTALL)

    if not html_tables:
        print(f"No tables found in {file_path}.")
        return

    for html_table in html_tables:
        # Convert each HTML table to Markdown
        markdown_table = html_table_to_markdown(html_table)
        if markdown_table:
            # Replace the HTML table with the Markdown table in the content
            content = content.replace(html_table, markdown_table)
        else:
            print(f"Table could not be converted: {html_table}")

    # Write the updated content back to the file
    with open(file_path, "w", encoding="utf-8") as file:
        file.write(content)
    print(f"Updated file saved: {file_path}")

def convert_html_tables_in_directory(directory):
    """
    Convert all HTML tables in Markdown files within a directory to Markdown tables.
    """
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith(".md"):
                file_path = os.path.join(root, file)
                print(f"Processing file: {file_path}")
                process_markdown_file(file_path)

# Specify the directory containing Markdown files
directory_path = "./docs/en"  # Update with your directory path
convert_html_tables_in_directory(directory_path)

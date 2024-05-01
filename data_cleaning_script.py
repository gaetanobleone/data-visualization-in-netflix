import csv

# the file in question
old_file = r"C:\Users\gaeta\Desktop\sql_project\dirty_netflix_titles.csv"

# the new file.
new_file = r"C:\Users\gaeta\Desktop\sql_project\cleaned_netflix_titles.csv"

# this opens up "old file" reads each row up until row 12, and then skips to the next line, copying all the data to the "new file"
with open(old_file, newline='', encoding='latin-1') as f:
    reader = csv.reader(f, delimiter=',', skipinitialspace = True)
    with open(new_file, 'w', newline='', encoding='utf-8') as i:
        writer = csv.writer(i)
        for row in reader:    
            writer.writerow(row[:12])
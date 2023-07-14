from PIL import Image
import pytesseract
import re
import os
pattern = r'[^A-Za-z\s,.]|\n'
image_folder = r"C:\Users\prith\OneDrive\Desktop\Maven-SQL"
images = os.listdir(image_folder)
image_paths =[os.path.join(image_folder,image) for image in images]
l=[]
for image in image_paths:

    i = Image.open(image)
    text = pytesseract.image_to_string(i)
    lines = text.split(".\n")
    for line in range(len(lines)):
        lines[line] = re.sub(pattern, ' ', lines[line]).strip()
    l.extend(lines)

lines_without_space = [line for line in l if (len(line)!= 0)]
print(len(lines_without_space))
with open(image_folder+'/questions.txt', 'w') as f:
    for line in lines_without_space:
        f.write(line+"\n")
        f.write("\n")



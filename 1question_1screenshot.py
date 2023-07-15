from PIL import Image
import pytesseract
import re
import os
images_folder = r'C:\Users\prith\OneDrive\Desktop\Maven-SQL\generate_questions\1'
images_names = os.listdir(images_folder)
images_paths = [os.path.join(images_folder, image_name) for image_name in images_names]
l= []
for i in images_paths:
    image= Image.open(i)
    text = pytesseract.image_to_string(image)
    line = re.sub(r'\n', ' ', text)
    l.append(line)

with open(images_folder+"/join_questions_intro.txt", "w") as f:
    for line in l:
        f.write(line)
        f.write("\n"*2)

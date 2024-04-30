from PIL import Image
import os
from transformers import AutoModelForImageClassification, ViTImageProcessor
import torch
from transformers import pipeline

folder = "C:/Users/Tilak/Desktop/New folder/pdf read/testpdf_2"

model = AutoModelForImageClassification.from_pretrained("Falconsai/nsfw_image_detection")
processor = ViTImageProcessor.from_pretrained('Falconsai/nsfw_image_detection')

nsfw_found = False 

for root, dirs, files in os.walk(folder):
    for file_name in files:
        file_path = os.path.join(root, file_name)

        img = Image.open(file_path)
        low_res_img = img.convert(mode='RGB')
     #   low_res_img = img.resize((224,224))
        classifier = pipeline("image-classification", model="Falconsai/nsfw_image_detection")
        classifier(low_res_img)
        

        img = Image.open(file_path)
        low_res_img = img.convert(mode='RGB')
     #   low_res_img = img.resize((224,224))
        with torch.no_grad():
            inputs = processor(images=low_res_img, return_tensors="pt")
            outputs = model(**inputs)
            logits = outputs.logits

        predicted_label = logits.argmax(-1).item()
        label = model.config.id2label[predicted_label]
     
        if label == 'nsfw':
            nsfw_found = True
            
            break
if(nsfw_found):
  print(1)  
else:
  print(0)
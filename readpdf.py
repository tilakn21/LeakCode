import os
import fitz  

pdf_path = r"C:\Users\Tilak\Desktop\New folder\pdf read\testpdf_4.pdf"
def extract_images_from_pdf(pdf_path):
    pdf_filename = os.path.splitext(os.path.basename(pdf_path))[0]
    output_folder = f"{pdf_filename}"
    os.makedirs(output_folder, exist_ok=True)
    pdf_document = fitz.open(pdf_path)

    for page_number in range(len(pdf_document)):
        page = pdf_document.load_page(page_number)
        image_list = page.get_images(full=True)

        for image_index, image in enumerate(image_list):
            xref = image[0]
            base_image = pdf_document.extract_image(xref)
            image_bytes = base_image["image"]
            image_path = f"{output_folder}/page{page_number + 1}_image{image_index + 1}.png"
            
            with open(image_path, "wb") as image_file:
                image_file.write(image_bytes)

    pdf_document.close()


pdf_path = r"C:\Users\Tilak\Desktop\New folder\pdf read\testpdf_4.pdf"
extract_images_from_pdf(pdf_path)

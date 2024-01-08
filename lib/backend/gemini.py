import google.generativeai as genai

model = genai.GenerativeModel(model_name="gemini-pro-vision") 

response = model.generate_content("Flutter kullanarak galeriden seçilen bir fotoğraf ile QR Kod Scan edilmesini sağlayan uygulamayı nasıl kodlarım?") 


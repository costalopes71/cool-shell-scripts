import sys
import face_recognition

if len(sys.argv) != 3:
    sys.exit(1)

image_to_check = face_recognition.load_image_file(sys.argv[1])
reference_image = face_recognition.load_image_file(sys.argv[2])

try:
    ref_encoding = face_recognition.face_encodings(reference_image)[0]
    chk_encoding = face_recognition.face_encodings(image_to_check)[0]
except IndexError:
    print("Nenhum rosto encontrado em uma das imagens")
    sys.exit(1)

match = face_recognition.compare_faces([ref_encoding], chk_encoding, tolerance=0.7)[0]
distance = face_recognition.face_distance([ref_encoding], chk_encoding)[0]
print(f"Distancia entre rostos: {distance}")

if match:
    print("✅ Rosto reconhecido!")
    sys.exit(0)  # É você
else:
    print("❌ Rosto não reconhecido.")
    sys.exit(2)  # Não é você

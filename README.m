 from flask import Flask, request, jsonify
import qrcode

app = Flask(__name__)

@app.route('/generate_qr_code', methods=['POST'])
def generate_qr_code():
    data = request.json.get('data')  # Get the data from the request payload
    if not data:
        return jsonify({'error': 'No data provided'})

    qr = qrcode.QRCode(version=1, error_correction=qrcode.constants.ERROR_CORRECT_H, box_size=10, border=4)
    qr.add_data(data)
    qr.make(fit=True)

    # Create an image from the QR code
    image = qr.make_image(fill_color="black", back_color="white")

    # Save the image to a file (optional)
    filename = 'qr_code.png'
    image.save(filename)

    return jsonify({'filename': filename})

if __name__ == '__main__':
    app.run()


# from flask import Flask, jsonify, request
# import json

# app = Flask(__name__)

# # Load products from a JSON file with utf-8 encoding
# with open('products.json', 'r', encoding='utf-8') as f:
#     products = json.load(f)

# # Fetch all products
# @app.route('/products', methods=['GET'])
# def get_products():
#     return jsonify(products)

# # Add or update a product
# @app.route('/add-product', methods=['POST'])
# def add_product():
#     new_product = request.json
#     products.append(new_product)
#     with open('products.json', 'w', encoding='utf-8') as f:
#         json.dump(products, f, ensure_ascii=False, indent=4)
#     return jsonify({'message': 'Product added successfully'}), 201

# if __name__ == '__main__':
#     app.run(debug=True)
from flask import Flask, jsonify, request
import json

app = Flask(__name__)

# Load products from a JSON file with utf-8 encoding
with open('products.json', 'r', encoding='utf-8') as f:
    products = json.load(f)

# Fetch all products
@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products)

# Add or update a product
@app.route('/add-product', methods=['POST'])
def add_product():
    new_product = request.json
    
    # Validation: Ensure the product contains required fields
    required_fields = ['title', 'final_price', 'image_url', 'url', 'discount']
    if not all(field in new_product for field in required_fields):
        return jsonify({'error': 'Missing required product fields'}), 400

    products.append(new_product)

    # Save updated products list back to the JSON file
    with open('products.json', 'w', encoding='utf-8') as f:
        json.dump(products, f, ensure_ascii=False, indent=4)

    return jsonify({'message': 'Product added successfully'}), 201

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')

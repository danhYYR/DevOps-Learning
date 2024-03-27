from cryptography.fernet import Fernet
key = Fernet.generate_key()
print(" \n # Encrypt key for database")
print(f"ENCRYPT_KEY=#{key}")
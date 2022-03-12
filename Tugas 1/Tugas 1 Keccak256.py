from base64 import encode
import sha3
from eth_hash.backends import pycryptodome
from eth_hash.auto import keccak

noKtp = input('nama : ')
encoded = noKtp.encode()
s = sha3.keccak_256(encoded)

#print('Nama :',s.hexdigest())



print(f'encryp : {s.hexdigest()}')
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionDecryption {
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));
  static encryptedAES(msg) {
    final encrypted = encrypter.encrypt(msg, iv: iv);
    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted.base64;
  }

  static decryptedAES(msg) {
    return encrypter.decrypt64(msg, iv: iv);
  }
}

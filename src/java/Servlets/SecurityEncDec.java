package Servlets;

import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;
import javax.xml.bind.DatatypeConverter;

public class SecurityEncDec {

    private static final String FORMAT = "ISO-8859-1";
    public static final String DESEDE_ENCRYPTION_SCHEME = "DESede";

    private KeySpec ks;
    private SecretKeyFactory skf;
    private Cipher cipher;
    SecretKey key;

    public SecurityEncDec() throws Exception {

        String myEncryptionKey = "4A144BEBF7E5E7B7DCF26491AE79C54C768C514CF1547D23";

        ks = new DESedeKeySpec(myEncryptionKey.getBytes(FORMAT));
        skf = SecretKeyFactory.getInstance(DESEDE_ENCRYPTION_SCHEME);
        cipher = Cipher.getInstance(DESEDE_ENCRYPTION_SCHEME);
        key = skf.generateSecret(ks);
    }

    public String encrypt(String unencryptedString) throws Exception {

        String encryptedString = null;
        cipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] plainText = unencryptedString.getBytes(FORMAT);
        byte[] encryptedText = cipher.doFinal(plainText);
        encryptedString = DatatypeConverter.printBase64Binary(encryptedText);

        return encryptedString;
    }

    public String decrypt(String encryptedString)  throws Exception {

        String decryptedText = null;
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] encryptedText = DatatypeConverter.parseBase64Binary(encryptedString);
        byte[] plainText = cipher.doFinal(encryptedText);
        decryptedText = new String(plainText);

        return decryptedText;
    }


}
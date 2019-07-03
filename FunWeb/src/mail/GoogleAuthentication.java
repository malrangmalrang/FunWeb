package mail;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator {
	PasswordAuthentication passAuth;
	
	public GoogleAuthentication() {
		passAuth = new PasswordAuthentication("comori4", "bigclbuxiotymgug");
	}
	
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}

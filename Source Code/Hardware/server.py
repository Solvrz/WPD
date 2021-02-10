import firebase_admin
from firebase_admin import credentials, firestore

CREDS = {
  "type": "service_account",
  "project_id": "fluttertest-1f46e",
  "private_key_id": "9e6f9d10f71348daf6a93fcade2b81dbb2cf927e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC7KoHRIQzDHPPA\nrA2UyarS9XQttHzhAmkwF0ixVqzMfRN0Xk7iSE35Mo6CjytHU80dW0r3L4w4fJHv\nVfVrVefcHEOKhCQa1W8lV9f18/li+boqgdATc7HzLH8ajFY4Nx0SnTVdlD0KTY9M\n6rkVfxBJ4s65MrtEYr61dyVEyFtQdKnzaPWdoaypcIcheByOqyFX/glTrTxZvbQ0\n18RXlLZ4Izl4aN/mBCB2zeqWj2cKBkfDImiKbmX+GK6vIfjeo8hayiSrDalLpglp\nZ/KtK0dyEbk+tx0hx3wRQPNih+9vzOVz8xAmBN682RoQMq8rc0BisixOIZmXA0Us\nPg0GvZLhAgMBAAECggEAChcevDS2bexpKGQo2p0hWacu9hSAE6y1brN1UU41bv7N\nO4hRY2SiLi2aE5LUB/qOGSeQppEzKOEaXayk2FO0y3U19PPucwiPqek5n4JhhFhR\n6jRpEIC7wWWO4qevMZpTCxZbnVRpErL0vKD+N8OhEAKrbL497KVlglNOjeM+p7B9\nZzIJkhe+IbrT5xJgL3g5ZjAB8Rtm2WcefcY6fjy0xP5DnonKOoB0R+9XwWVCpZMN\n1K+ln/pjw8fR0uU6F3G3825Yq7772mfFkeAg3PJD8lBJXFBE4swW5sBnJGoEX326\nx98YshO/mTuymyJnVaEuRls3exf/LuBa3zFJpI1LswKBgQDwEjy36+BhWufcXzbK\nnN/t7t7UkC0BzbB8dvVM/qr+n5xvGjc0c2jDsCXlwe2C4klHwtB9rTBbUZ+Pc4x4\nxFX/fRXbwli/vRKtz6grdjC3IKVxeNNEu+PrwUTkF3ZRPfatVrpZYeH0zhuURgCY\nXTrpLeFX0Qap5Gg2QMwkM0KIGwKBgQDHlaQ4qUqL19dkqifF0DFTSSOkBiXXux1A\nFPkjQJPPB4k+8LHvJiPl1cQ9JecrHStVZc8Dx7WvguzpXr7o+5u09DFDspIXBOlp\n2gopUKrSQnS4kWwb5fUF+xeWtxPUyjRw4FS5uWq6t3Jik4Codt964FH+vpIw+lWp\n1v0ZCH+4swKBgC9NWJtgpZBpKgA43oHjkRe/ljZJxiRx09FiWwj1sNmEt30IrFHw\nX3cXURBJOrQsRAYYs53frwR/O7I3MTlmbg9uJQ1s6LG23mRS4y7VFdovW4nVJcOI\nRetg5GMQ4GY3kFAtI4CTEcN7jOGVPW7IB+CEAr+b1vVIpOPztoV3eCd7AoGAfD+F\nR5zkgqBxQALJ1dThECdFH9SP9HhRIlasLq0CF21qnJs9OlM1H9zvWN3ixq1XD8fc\nk07dpZDNKg9IrEQO0B0BGlLtrZTqNnJ9xvCoF1M11Lz7X3bODdYd/j6lAuCKuwZ8\n2E48ylZvyDxpaPbv80/4260J16HQeHYVhGMNGA8CgYEAmWuA0HNm5z33QwdFfIu4\n/3B9IUZ17LZ3UlTwE/RO/Y9CMg2btxvwQXLVIUMHUx0NFyKbTBGJejoRmyQ7ag3a\nLN6Q3N1r2VWJQjbgl3jfMrVKeLI2dOvx9r0M+OXCMvo3xa2LdJM3hQOBM11JK5yG\ngluOcDuYhkiVBd2b+ph5UqY=\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-yyzey@fluttertest-1f46e.iam.gserviceaccount.com",
  "client_id": "108130528737902032616",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-yyzey%40fluttertest-1f46e.iam.gserviceaccount.com"
}

cred = credentials.Certificate(CREDS)
app = firebase_admin.initialize_app(cred)

db = firestore.client()

def upload(data, collection):
    print(data)
    print(db.collection(collection).add(data))

def delete(conds={}, collection="", id=None):
	if id:
		db.collection(collection).document(id).delete()

	else:	
		for doc in db.collection(collection).list_documents():
			if doc.get(conds).to_dict() == conds:
				doc.delete()
import firebase_admin
from firebase_admin import credentials, firestore

with open("firebase.json") as f:
    cred = credentials.Certificate(f.read())
    firebase_admin.initialize_app(cred)


db = firestore.client()


def upload(data, collection):
    print(db.collection(collection).add(data))


def delete(conds={}, collection="", id=None):
    if id:
        db.collection(collection).document(id).delete()

    else:
        for doc in db.collection(collection).list_documents():
            if doc.get(conds).to_dict() == conds:
                doc.delete()

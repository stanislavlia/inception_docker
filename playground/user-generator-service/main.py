from fastapi import FastAPI
from faker import Faker
import time

# Initialize FastAPI app and Faker instance
app = FastAPI()
fake = Faker()

@app.get("/user")
async def generate_random_user():
    """
    Generate a random user and return as JSON
    """
    time.sleep(0.5)
    user = {
        "name": fake.name(),
        "address": fake.address(),
        "email": fake.email(),
        "username": fake.user_name(),
        "job": fake.job(),
        "birthdate": fake.date_of_birth().isoformat()
    }
    return user

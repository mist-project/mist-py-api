from django.core.management.base import BaseCommand
from user_auth.models import User
from django.contrib.auth.hashers import make_password

class Command(BaseCommand):
    help = 'Creates a user with the given email and password'

    def add_arguments(self, parser):
        # Define the arguments for email and password
        parser.add_argument('email', type=str, help='Email address of the new user')
        parser.add_argument('password', type=str, help='Password for the new user')

    def handle(self, *args, **kwargs):
        # Extract email and password from the arguments
        email = kwargs['email']
        password = kwargs['password']

        # Check if the email already exists in the User model
        if User.objects.filter(email=email).exists():
            self.stdout.write(self.style.ERROR(f'A user with the email {email} already exists.'))
        else:
            # Hash the password before saving it
            user = User.objects.create(
                email=email,
                password=make_password(password),  # Make sure to hash the password
            )
            self.stdout.write(self.style.SUCCESS(f'User {email} created successfully!'))

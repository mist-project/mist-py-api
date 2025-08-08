import grpc

from django.db import transaction
from django.conf import settings
from rest_framework import generics, status
from rest_framework.response import Response

from api.protos.v1.appuser import appuser_pb2, appuser_pb2_grpc

from .models import User
from .serializers import UserSerializer


class RegisterView(generics.CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def create(self, request, *args, **kwargs):
        with transaction.atomic():
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            self.perform_create(serializer)

            user = User.objects.get(pk=serializer.data["id"])

            # # TODO replace localhost:4000 with an env variable
            with grpc.insecure_channel(settings.MIST_BACKEND_APP_URL) as channel:
                stub = appuser_pb2_grpc.AppuserServiceStub(channel)
                metadata = [("authorization", f"Bearer {str(user.get_jwt_access_token())}")]
                stub.Create(appuser_pb2.CreateRequest(username=user.email, id=str(user.pk)), metadata=metadata)

            headers = self.get_success_headers(serializer.data)

            return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)

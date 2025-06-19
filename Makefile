SRC_PROTOS=src/api/protos/v1
PROTO_FILE=$(SRC_PROTOS)/appuser/appuser.proto

run:
	uv run python src/manage.py runserver 4001

compile-protos:
	@uv run python -m grpc_tools.protoc -I src \
		--python_out=src \
		--pyi_out=src \
		--grpc_python_out=src \
		$(PROTO_FILE)
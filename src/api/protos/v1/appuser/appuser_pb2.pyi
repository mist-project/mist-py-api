from google.protobuf import timestamp_pb2 as _timestamp_pb2
from google.protobuf.internal import enum_type_wrapper as _enum_type_wrapper
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from typing import ClassVar as _ClassVar, Mapping as _Mapping, Optional as _Optional, Union as _Union

DESCRIPTOR: _descriptor.FileDescriptor

class AppUserStatus(int, metaclass=_enum_type_wrapper.EnumTypeWrapper):
    __slots__ = ()
    APP_USER_STATUS_UNSPECIFIED: _ClassVar[AppUserStatus]
    APP_USER_STATUS_INACTIVE: _ClassVar[AppUserStatus]
    APP_USER_STATUS_ONLINE: _ClassVar[AppUserStatus]
    APP_USER_STATUS_OFFLINE: _ClassVar[AppUserStatus]
    APP_USER_STATUS_AWAY: _ClassVar[AppUserStatus]
APP_USER_STATUS_UNSPECIFIED: AppUserStatus
APP_USER_STATUS_INACTIVE: AppUserStatus
APP_USER_STATUS_ONLINE: AppUserStatus
APP_USER_STATUS_OFFLINE: AppUserStatus
APP_USER_STATUS_AWAY: AppUserStatus

class Appuser(_message.Message):
    __slots__ = ("id", "username", "online_status", "created_at", "updated_at")
    ID_FIELD_NUMBER: _ClassVar[int]
    USERNAME_FIELD_NUMBER: _ClassVar[int]
    ONLINE_STATUS_FIELD_NUMBER: _ClassVar[int]
    CREATED_AT_FIELD_NUMBER: _ClassVar[int]
    UPDATED_AT_FIELD_NUMBER: _ClassVar[int]
    id: str
    username: str
    online_status: AppUserStatus
    created_at: _timestamp_pb2.Timestamp
    updated_at: _timestamp_pb2.Timestamp
    def __init__(self, id: _Optional[str] = ..., username: _Optional[str] = ..., online_status: _Optional[_Union[AppUserStatus, str]] = ..., created_at: _Optional[_Union[_timestamp_pb2.Timestamp, _Mapping]] = ..., updated_at: _Optional[_Union[_timestamp_pb2.Timestamp, _Mapping]] = ...) -> None: ...

class CreateRequest(_message.Message):
    __slots__ = ("id", "username")
    ID_FIELD_NUMBER: _ClassVar[int]
    USERNAME_FIELD_NUMBER: _ClassVar[int]
    id: str
    username: str
    def __init__(self, id: _Optional[str] = ..., username: _Optional[str] = ...) -> None: ...

class CreateResponse(_message.Message):
    __slots__ = ()
    def __init__(self) -> None: ...

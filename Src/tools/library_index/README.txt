This library_indexer tool index ecf files from folders
and provides queries
such as find the libraries providing a specific class

Example:

> library_indexer -v -r --update $ISE_LIBRARY

this will create a "library.db" in current working directory

then you can query 

> library_indexer --search STRING_TABLE
Libraries containing {STRING_TABLE} ->
  base @ C:\_dev\trunk\Src\library\base\base-safe.ecf

> library_indexer --search ZMQ*
Libraries containing {ZMQ*} ->
  zmq @ C:\_dev\trunk\Src\library\zeromq\zmq.ecf
    - ZMQ
    - ZMQ_CONSTANTS
    - ZMQ_BROKER
    - ZMQ_CONTEXT
    - ZMQ_ERROR_CODES
    - ZMQ_MESSAGE
    - ZMQ_POLLER
    - ZMQ_SOCKET

> library_indexer -h
for help

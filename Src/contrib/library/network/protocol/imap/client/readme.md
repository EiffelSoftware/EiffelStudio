# IMAP client library

## Introduction
This repository contains an open source Eiffel library to connect to a server with the Internet Message Access Protocol.

This library provides an easy access to almost all the commands of IMAP4rev1 and the server responses and allows to send custom commands.

## Contents
* `src` : Contains the library classes
* `examples` : Contains examples of how to use the library

## Getting started

To use the Eiffel IMAP client library, add it to your project and instantiate an object of type `IMAP_CLIENT_LIB`

### Simple example
Here is a simple example to connect to a server, login, open the mailbox "INBOX" and logout :
```
	an_example
		local
			imap: IMAP_CLIENT_LIB
		do
			create imap.make_ssl_with_address ("your_server.com")
			imap.connect

			if imap.is_connected then
				imap.login ("username", "password")
				imap.select ("INBOX")
				print (imap.current_mailbox.name) -- INBOX
				imap.logout
			end
		end
```

You should look in the `examples` folder for more complex examples.

### Main functionality

##### Create and connect

The IMAP_CLIENT_LIB has 6 constructors, 3 for normal connection and 3 for SSL encrypted connection.
* `make` will create the imap library with the default address and port
* `make_with_address` will create the imap library with a connection to the given address
* `make_with_address_and_port` will create the imap library with a connection to the given address and a custom port

Each constructor also has its ssl version :
* `make_ssl`
* `make_ssl_with_address`
* `make_ssl_with_address_and_port`

To connect the library to the socket, you should call `{IMAP_CLIENT_LIB}.connect`
You can check if the library is connected with `{IMAP_CLIENT_LIB}.is_connected`

##### States

[The IMAP states](https://tools.ietf.org/html/rfc3501#section-3) are represented in `IL_NETWORK_STATE` with the extra state `not_connected_state`.
The state change automatically when you successfully call a function that changes the state.
You can get the current state with `{IMAP_CLIENT_LIB}.get_current_state`.

##### Commands and tags

Most of the IMAP commands have helper functions to send them and get the data back.
You can however send custom commands with `{IMAP_CLIENT_LIB}.send_command`.
It is also possible to send them as action (See `IL_IMAP_ACTION`) with `{IMAP_CLIENT_LIB}.send_action`. In this case a contract checks that the action is supported in the current state.

The command tags are automatically managed but you can access the tag of the last command with `{IMAP_CLIENT_LIB}.get_last_tag`.

##### Commands continuation

You can check if the server made a [command continuation request](https://tools.ietf.org/html/rfc3501#section-7.5) with `{IMAP_CLIENT_LIB}.needs_continuation`. If it does need one, you must send the continuation with `{IMAP_CLIENT_LIB}.send_command_continuation`.

##### Server responses

All the server responses are parsed and saved as a `IL_SERVER_RESPONSE`. You can access the response of the last command sent with `{IMAP_CLIENT_LIB}.get_last_response` or the response for a particular tag with `{IMAP_CLIENT_LIB}.get_response`.

You can also instruct the response manager to read the socket and parse the responses without getting data back with `{IMAP_CLIENT_LIB}.receive`

##### Errors and status

They should be checked on the `IL_SERVER_RESPONSE`.
Some usefull features for errors and status are :
* `{IL_SERVER_RESPONSE}.is_ok`
* `{IL_SERVER_RESPONSE}.is_error`
* `{IL_SERVER_RESPONSE}.status`

### [Main commands](https://tools.ietf.org/html/rfc3501#section-6)

##### Capability

You can get at any time when connected the result of a CAPABILITY command parsed in a list with `{IMAP_CLIENT_LIB}.get_capability`

##### Login / Logout

The logout can be done at any time with `{IMAP_CLIENT_LIB}.logout`
Login can be done in the not authenticated state with `{IMAP_CLIENT_LIB}.login`. This will send a plain text LOGIN command.

There is currently no available helper for AUTHENTICATE commands but these can be send with `{IMAP_CLIENT_LIB}.send_command` and `{IMAP_CLIENT_LIB}.send_continuation`.

##### Authenticated commands

The most usefull commands here are :
* `{IMAP_CLIENT_LIB}.get_list` to get a list of the mailboxes. It will return a data structure with the name, the path, the hierarchy delimiter and the attributes for each mailbox
* `{IMAP_CLIENT_LIB}.subscribe` to subscribe to a mailbox.
* `{IMAP_CLIENT_LIB}.create_mailbox`, `{IMAP_CLIENT_LIB}.delete_mailbox` and `{IMAP_CLIENT_LIB}.rename_mailbox` for the edition of mailboxes.
* `{IMAP_CLIENT_LIB}.get_status` let you get the status of a mailbox.

You can select or examine a mailbox with `{IMAP_CLIENT_LIB}.select_mailbox` or `{IMAP_CLIENT_LIB}.examine_mailbox`. If these commands are successful, you will then be in the selected state.

##### Selected commands

In this state, `current_mailbox` contains the information about the selected mailbox.

We have some helpers for IMAP commands like :
* `{IMAP_CLIENT_LIB}.expunge` or `{IMAP_CLIENT_LIB}.get_expunge`
* `{IMAP_CLIENT_LIB}.search` to search messages in the mailbox
* `{IMAP_CLIENT_LIB}.check_command`
* `{IMAP_CLIENT_LIB}.copy_messages`

`{IMAP_CLIENT_LIB}.check_for_changes` allows to send a NOOP and tell if the server has sent back any change. If it is the case you can then get the changes from `current_mailbox`.

You can fetch data from messages with the fetch family of features. See next section for more details.

`{IMAP_CLIENT_LIB}.close` will close the mailbox and go back to the authenticated state if it is successful.

##### Fetch messages

(Selected state only)

The easiest way to fetch messages is with `{IMAP_CLIENT_LIB}.fetch_messages`.
It will return a hash table mapping the sequence number of the message to an `IL_MESSAGE` object representing the message.
The class `IL_MESSAGE` has many attributes that allow easy access to message information like :
* `from_address` : The address (and name) of the sender
* `to_address` : The addresses of the recipient
* `subject` : The subject of the message
* `body_text` : The text of the body
* `date` : The date of the message
* `flags` : The flags of the message

and many more.

There is a version which fetches the messages from a set of uids instead of a set of sequence numbers : `{IMAP_CLIENT_LIB}.fetch_messages_uid`.

It is also possible to manually fetch particular [data items](https://tools.ietf.org/html/rfc3501#page-55) with `{IMAP_CLIENT_LIB}.fetch` or to use the fetch macros with `fetch_all`, `fetch_fast` and `fetch_full`.

## Dependencies
The current implementation depends on Eiffel NetSSL, so you will need to have
the static libraries under your path.

Check the Eiffel NetSSL documentation to learn more.



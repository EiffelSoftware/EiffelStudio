note
	description: "Example of uses for the Eiffel IMAP client library"
	author: "Basile Maret"

class
	APPLICATION

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			list_mailbox_example

			get_mailboxes_info_example

			get_last_message_info

			check_messages_example
		end

feature -- Basic operation

	list_mailbox_example
			-- Connect to a server, do a login and list the mailboxes with their paths
		do
			create {LIST_MAILBOX_EXAMPLE}example.make
			example.run_example
		end

	get_mailboxes_info_example
			-- Connect to a server, do a login, get the mailbox names and check for their number of message and unseen message
		do
			create {MAILBOXES_INFO_EXAMPLE}example.make
			example.run_example
		end

	get_last_message_info
			-- Connect to a server, do a login, select INBOX and print info from the last message
		do
			create {LAST_MESSAGE_INFO_EXAMPLE}example.make
			example.run_example
		end

	check_messages_example
			-- Connect to a server, do a login, select INBOX and wait for a change
		do
			create {CHECK_MESSAGES_EXAMPLE}example.make
			example.run_example
		end

feature -- Access

	example: EXAMPLE
end

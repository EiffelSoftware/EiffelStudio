indexing
	description: "Mailer object used to send or retrieve emails"
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	MAILER

create
	make, make_with_email

feature -- Initialization

	make (a_protocol: EMAIL_PROTOCOL) is
			-- create the mailer with 'a_protocol'
		require
			not_void: a_protocol /= Void
		do
			protocol:= a_protocol
				-- Should determine if the protocol is uni or bi-directionnal
				-- Should we test here ?
			is_sender:= True
		end

	make_with_email (a_protocol: EMAIL_PROTOCOL; an_email: EMAIL) is
			-- create the mailer with 'an_email' and its 'a_protocol'
		require
			not_void: a_protocol /= Void and then an_email /= Void
		do
			make (a_protocol)
			protocol.set_email (an_email)
		end

feature -- Actions

	initiate is
		do
			protocol.initiate
		end

	transfer is
			-- transfer data .. bi-directionnal 
			-- I still don't understand why can't we do 2 distincts features to send or
			-- retrieve emails in this class
		require
			email_must_exists: (is_sender and protocol.email /= Void) or (is_receiver)
		do
			protocol.transfer
			set_transfer_error (protocol.transfer_error)
		end

	quit is
		do
			protocol.quit
		end

feature -- Settings

	set_email (an_email: EMAIL) is
		do
--			email:= an_email
			protocol.set_email (an_email)
		end

	set_protocol (a_protocol: EMAIL_PROTOCOL) is
		do
			protocol:= a_protocol
		end

feature {NONE} -- Settings

	set_transfer_error (b: BOOLEAN) is
		do
			transfer_error:= b
		end

	set_is_sender (b: BOOLEAN) is
		do
			is_sender:= b
		end

	set_is_receiver (b: BOOLEAN) is
		do
			is_receiver:= b
		end

feature -- Access

	is_sender: BOOLEAN
		-- Is the mailer in sending mode

	is_receiver: BOOLEAN
		-- Is the mailer in receiving mode

--	email: EMAIL
--		-- Email message

	protocol: EMAIL_PROTOCOL
		-- Protocol used to handle email

	transfer_error: BOOLEAN
		-- Has the transfer failed ?

end -- class MAILER

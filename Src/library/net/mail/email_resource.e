indexing
	description: "All resources"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_RESOURCE

inherit
	EMAIL_CONSTANTS

feature -- Access

	header (h: STRING): HEADER is
			-- Retrieve the content of the header 'h'
		do
			Result:= headers.item (h)
		end

	headers: HASH_TABLE [HEADER, STRING]
		-- All information concerning each headers


feature -- Status report

	can_receive: BOOLEAN is
			-- Can resource receive?
		deferred
		end

	can_send: BOOLEAN is
			-- Can resource send?
		deferred
		end

	can_be_received: BOOLEAN is
			-- Can resource be received?
		deferred
		end

	can_be_sent: BOOLEAN is
			-- Can resource be sent?
		deferred
		end

	transfer_error: BOOLEAN
			-- Error during the transfer?

	transfer_error_message: STRING
			-- Error message.

	is_header_valid: BOOLEAN is
		-- Is the email resource's header valid?
		do
		end

feature -- Status setting

	enable_transfer_error is
			-- Enable transfer error.
		do
			transfer_error:= True
		end

feature -- Basic operations

	transfer (resource: EMAIL_RESOURCE) is
			-- Transfer the Current email resource to 'resource'.
		require
			resource_exists: resource /= Void
			valid_transfer: (can_be_sent and then resource.can_send) or
							(can_receive and then resource.can_be_received)
		deferred
		end

end -- class EMAIL_RESOURCE

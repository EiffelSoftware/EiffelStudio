note
	description: "All resources"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_RESOURCE

inherit
	EMAIL_CONSTANTS

feature -- Access

	header (h: STRING): detachable HEADER
			-- Retrieve the content of the header 'h'
		do
			Result := headers.item (h)
		end

	headers: HASH_TABLE [HEADER, STRING]
		-- All information concerning each headers

feature -- Basic operations

	transfer (resource: EMAIL_RESOURCE)
			-- Transfer the Current email resource to 'resource'.
		require
			resource_exists: resource /= Void
			is_valid_transfer: (resource.can_be_sent and can_send) or
							(resource.can_receive and can_be_received)
			connection_is_initiated: (can_be_sent and resource.is_initiated) or
										(is_initiated and resource.can_be_received)
		deferred
		end

feature -- Status report

	can_receive: BOOLEAN
			-- Can resource receive?
		deferred
		end

	can_send: BOOLEAN
			-- Can resource send?
		deferred
		end

	can_be_received: BOOLEAN
			-- Can resource be received?
		deferred
		end

	can_be_sent: BOOLEAN
			-- Can resource be sent?
		deferred
		end

	transfer_error: TRANSFER_ERROR
			-- Transfer error handling
		once
			create Result
		end

	error: BOOLEAN
			-- Is there an error?
		do
			Result:= transfer_error.transfer_error
		end

			-- Error during the transfer?

--	transfer_error_message: STRING
			-- Error message.

	is_header_valid: BOOLEAN
		-- Is the email resource's header valid?
		do
		end

	is_initiated: BOOLEAN
		-- Has the connection has been initiated?

feature -- Status setting

	enable_transfer_error
			-- Enable transfer error.
		do
			transfer_error.enable_transfer_error
		end

	disable_transfer_error
			-- Disable transfer error.	
		do
			transfer_error.disable_transfer_error
		end

	set_transfer_error_message (s: STRING)
			-- Set transfer error message to 's'.
		do
			transfer_error.set_transfer_error_message (s)
		end

	enable_initiated
			-- Set is_initiated.
		do
			is_initiated:= True
		end

	disable_initiated
			-- Unset is_initiated.
		do
			is_initiated:= False
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EMAIL_RESOURCE


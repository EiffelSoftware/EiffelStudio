note
	description: "Mailer object used to send or retrieve resources"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	MAILER

--inherit
--	TRANSFER_ERROR

create
	default_create

feature -- Access

	from_resource: EMAIL_RESOURCE
		-- Resource that will be sent.

	to_resource: EMAIL_RESOURCE
		-- Resource that will receive.

feature -- Status report

	transfer_error: TRANSFER_ERROR
		-- Has the transfer failed?

	error: BOOLEAN
		do
			Result:= transfer_error.transfer_error
		end

--	transfer_error_message: STRING
		-- Error message.

feature -- Settings

	set_from_resource (resource: EMAIL_RESOURCE)
			-- Set 'resource' to from_resource.
		require
			resource_exists: resource /= Void
			valid_from_resource: resource.can_be_sent or resource.can_receive
		do
			disable_transfer_error
			from_resource:= resource
			set_transfer_error
		end

	set_to_resource (resource: EMAIL_RESOURCE)
			-- Set 'resource' to to_resource.
		require
			resource_exists: resource /= Void
			valid_to_resource: resource.can_send or resource.can_be_received
		do
			disable_transfer_error
			to_resource:= resource
			set_Transfer_error
		end

feature -- Basic operations

	transfer
			-- transfer data and check for errors.
		require
			resources_exists: from_resource /= Void and then to_resource /= Void
			valid_transfer: (from_resource.can_be_sent and then to_resource.can_send) or
							(from_resource.can_receive and then to_resource.can_be_received)
		do
			to_resource.transfer (from_resource)
--			check_errors
		end

feature {NONE} -- Implementation

--	set_transfer_error is
--			-- Set error.
--		do
--			transfer_error:= True
--		end

	set_transfer_error
		do
			if from_resource = Void then
				transfer_error:= to_resource.transfer_error
			else
				transfer_error:= from_resource.transfer_error
			end
		end

	disable_transfer_error
			-- Unset error.
		do
			if 	transfer_error /= Void then
				transfer_error.disable_transfer_error
			end
		end

--	set_transfer_error_message (message: STRING) is
--			-- Set transfer_error_message with 'message'.
--		do
--			transfer_error_message:= message
--		end

--	check_errors is
--			-- Check for errors.
--		do
--			if from_resource.transfer_error then
--				set_transfer_error
--				set_transfer_error_message (from_resource.transfer_error_message)
--			end
--			if to_resource.transfer_error then
--				set_transfer_error
--				set_transfer_error_message (to_resource.transfer_error_message)
--			end	
--		end

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




end -- class MAILER


indexing
	description: "Mailer object used to send or retrieve resources"
	author: "david s"
	date: "$Date$"
	revision: "$Revision$"

class
	MAILER

create
	default_create

feature -- Access

	from_resource: EMAIL_RESOURCE
		-- Resource that will be sent.

	to_resource: EMAIL_RESOURCE
		-- Resource that will receive.

feature -- Error handling.

	transfer_error: BOOLEAN
		-- Has the transfer failed?

	transfer_error_message: STRING
		-- Error message.

feature -- Settings

	set_from_resource (resource: EMAIL_RESOURCE) is
		require
			resource_exists: resource /= Void
			valid_from_resource: resource.can_be_sent
		do
			from_resource:= resource
		end

	set_to_resource (resource: EMAIL_RESOURCE) is
		require
			resource_exists: resource /= Void
			valid_to_resource: resource.can_receive
		do
			to_resource:= resource
		end

feature -- Basic operations

	transfer is
			-- transfer data and check for errors.
		require
			resources_exists: from_resource /= Void and then to_resource /= Void
			valid_transfer: (from_resource.can_be_sent and then to_resource.can_send) or
							(from_resource.can_receive and then to_resource.can_be_received)
		do
			to_resource.transfer (from_resource)
			check_errors
		end

feature {NONE} -- Implementation

	set_transfer_error is
			-- Set error.
		do
			transfer_error:= True
		end

	unset_transfer_error is
			-- Unset error.
		do
			transfer_error:= False
		end

	set_transfer_error_message (message: STRING) is
			-- Set transfer_error_message with 'message'.
		do
			transfer_error_message:= message
		end

	check_errors is
			-- Check for errors.
		do
			if from_resource.transfer_error then
				set_transfer_error
				set_transfer_error_message (from_resource.transfer_error_message)
			end
			if to_resource.transfer_error then
				set_transfer_error
				set_transfer_error_message (to_resource.transfer_error_message)
			end	
		end

end -- class MAILER

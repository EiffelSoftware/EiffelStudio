indexing
	description: "All resources"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EMAIL_RESOURCE

inherit
	EMAIL_CONSTANTS

feature -- Status report.

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

feature -- Basic operations

	transfer (resource: EMAIL_RESOURCE) is
			-- Transfer the Current email resource to 'resource'
		require
			resource_exists: resource /= Void
			valid_transfer: (can_be_sent and then resource.can_send) or
							(can_receive and then resource.can_be_received)
		deferred
		end

	resource_to_transfer: EMAIL_RESOURCE
			-- Ressource to be transferred.

feature -- Setting

	enable_transfer_error is
		do
			transfer_error:= True
		end

end -- class EMAIL_RESOURCE

indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROTOCOL_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Basic operations

	initiate_protocol is
			-- initiate the protocol with the server.
		deferred
		ensure
			protocol_initiated: is_initiated
		end

	close_protocol is
			-- Close the protocol.
		deferred
		ensure
			protocol_not_initiated: not is_initiated
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_sent: BOOLEAN is False
		-- Can a protocol resource be send?

	can_be_received: BOOLEAN is False
		-- Can a protocol be received?

end -- class PROTOCOL_RESOURCE

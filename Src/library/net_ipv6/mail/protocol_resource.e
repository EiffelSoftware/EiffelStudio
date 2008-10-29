indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		require
			is_initiated: is_initiated
		deferred
		ensure
			protocol_not_initiated: not is_initiated
		end

feature -- Implementation (EMAIL_RESOURCE)

	can_be_sent: BOOLEAN is False
		-- Can a protocol resource be send?

	can_be_received: BOOLEAN is False;
		-- Can a protocol be received?

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class PROTOCOL_RESOURCE


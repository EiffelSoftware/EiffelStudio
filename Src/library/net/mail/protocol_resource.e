indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROTOCOL_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Implementation (EMAIL_RESOURCE)

	can_be_sent: BOOLEAN is False

	can_be_received: BOOLEAN is False

end -- class PROTOCOL_RESOURCE

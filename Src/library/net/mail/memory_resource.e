indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMORY_RESOURCE

inherit
	EMAIL_RESOURCE

feature -- Implementation (EMAIL_RESOURCE)

	can_send: BOOLEAN is False
		-- Memory resource can not send.

	can_receive: BOOLEAN is False
		-- Memory resource can not receive.

end -- class MEMORY_RESOURCE

indexing
	description: "Objects that handle the sending of data"
	author: "david"
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	SENDING_PROTOCOL

inherit
	EMAIL_PROTOCOL

feature -- Implemantation (EMAIL_RESOURCE)

	can_send: BOOLEAN is True
		-- A sending protocol can send.


end -- class SENDING_PROTOCOL

note
	description: "Summary description for {SERVLET_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SERVLET_ELEMENT

feature -- Access

	serialize (stream: INDENDATION_STREAM)
			-- Serializes the element to a part of a servlet class
			-- `stream': Writes on this stream
		require
			stream_is_open_write: stream.is_open_write
		deferred
		end

end

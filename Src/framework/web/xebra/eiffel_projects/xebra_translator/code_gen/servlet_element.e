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
		deferred
		end

end

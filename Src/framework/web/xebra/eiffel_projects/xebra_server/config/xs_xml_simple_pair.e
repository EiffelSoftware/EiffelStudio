note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_XML_SIMPLE_PAIR



feature -- Access

	tag: detachable STRING
	value: detachable STRING


	set_tag (a_tag: STRING)
			-- setter
		do
			tag := a_tag
		end

	set_value (a_value: STRING)
			-- setter
		do
			value := a_value
		end


end


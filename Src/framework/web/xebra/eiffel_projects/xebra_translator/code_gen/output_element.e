note
	description: "Summary description for {OUTPUT_ELEMENT}."
	author: "sandro"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OUTPUT_ELEMENT

inherit
	SERVLET_ELEMENT

feature -- Access

	controller_var: STRING
	buffer_var: STRING

	set_controller_var (a_name: STRING)
		do
			controller_var := a_name
		end

	set_buffer_var (a_name: STRING)
		do
			buffer_var := a_name
		end

end

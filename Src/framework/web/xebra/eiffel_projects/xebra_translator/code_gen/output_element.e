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
			-- Variable name of the controller

	response_var: STRING
			-- Variable name of the response

	set_controller_var (a_name: STRING)
			-- Sets the name of the controller variable
		do
			controller_var := a_name
		end

	set_response_var (a_name: STRING)
			-- Sets the name of the response variable
		do
			response_var := a_name
		end


	response_name: STRING
			-- The response variable name

	set_response_name(a_name: STRING)
			-- Sets the response variable name.
		require
			name_is_valid: not a_name.is_empty
		do
			response_name := a_name
		end

end

indexing

	description: 
		"Error in C++ extension specification for an external feature."
	date: "$Date$"
	revision: "$Revision $"

class EXT_STRUCT 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	code: STRING is "EXT_STRUCT"
			-- Error code

	error_message: STRING
			-- Error message

	set_error_message (msg: STRING) is
        do
            error_message := msg
        end
 
    build_explain (st: STRUCTURED_TEXT) is
        do
            st.add_string ("Error message: ")
            st.add_string (error_message)
            st.add_new_line
        end

end -- class EXT_STRUCT


indexing
	description: "Error in C++ extension specification for an external feature."
	date: "$Date$"
	revision: "$Revision$"

class EXT_CPP 

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	code: STRING is "EXT_CPP"
			-- Error code

	error_message: STRING
			-- Error message

feature -- Settings

	set_error_message (msg: STRING) is
			-- Set `error_message' with `msg'.
		require
			msg_not_void: msg /= Void
		do
			error_message := msg
		end

feature -- Error display

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Error message: ")
			st.add_string (error_message)
			st.add_new_line
		end

end -- class EXT_CPP

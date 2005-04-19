indexing
	description: "Error for not supported construction."
	date: "$Date$"
	revision: "$Revision$"

class NOT_SUPPORTED

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end

feature

	message: STRING;

	set_message (i: STRING) is
		do
			message := i
		end

	code: STRING is "NOT_SUPPORTED"
			-- Error code

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Error message: ")
			st.add_string (message)
			st.add_new_line
		end

end

indexing
	description: "Error for undeclared identifier."
	date: "$Date$"
	revision: "$Revision$"

class VEEN 

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Access

	identifier: STRING
			-- Undeclared identifier

	parameter_count: INTEGER
			-- Number of expected arguments.

	code: STRING is "VEEN"
			-- Error code

feature -- Settings

	set_identifier (s: STRING) is
			-- Assign `s' to `identifier'.
		require
			s_not_void: s /= Void
		do
			identifier := s
		ensure
			identifier_set: identifier = s
		end

	set_parameter_count (i: INTEGER) is
			-- Assign `i to `parameter_count'.
		require
			i_positive: i >= 0
		do
			parameter_count := i
			is_parameter_count_set := True
		ensure
			parameter_countt_set: parameter_count = i
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Identifier: ")
			st.add_string (identifier)
			st.add_new_line
			if is_parameter_count_set then
				st.add_string ("Taking ")
				if parameter_count = 0 then
					st.add_string ("no argument")
				else
					if parameter_count = 1 then
						st.add_string ("1 argument")
					else
						st.add_int (parameter_count)
						st.add_string (" arguments")
					end
				end
				st.add_new_line
			end
		end

feature {NONE} -- Implementation

	is_parameter_count_set: BOOLEAN
			-- Did we call `set_parameter_count'?

end -- class VEEN

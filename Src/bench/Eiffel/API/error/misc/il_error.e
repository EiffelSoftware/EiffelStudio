indexing
	description	: "IL Generation error, occurs at degree 1 or 2 during IL generation."
	date: "$Date$";
	revision: "$Revision$"

class
	IL_ERROR

inherit
	ERROR
		redefine
			Error_string,
			print_error_message
		end

create
	make,
	make_com_error,
	make_output_in_use

feature {NONE} -- Initialization

	make (description: like error_string) is
			-- Set `Error_string' with `description'.
		require
			non_void_description: description /= Void
		do
			internal_error_string := description
		ensure
			Error_string_set: Error_string = description
		end

	make_com_error is
			-- Error when .NET COM component is not properly installed.
		do
			internal_error_string := "%
				%Unable to load .NET components. Make sure .NET and Eiffel for .NET%N%
				%are properly installed%N%N%
				%See http://docs.eiffel.com/technologies/dotnet for more details.%N"
		end
		
	make_output_in_use (t: STRING) is
			-- Error when trying to delete file `t'.
		require
			t_not_void: t /= Void
			t_not_empty: not t.is_empty
		do
			internal_error_string := "File: " + t + " is in use.%NSystem compilation aborted.%N"
		end
		
feature -- Properties

	code: STRING is
			-- Error code
		once
			Result := "IL_Error"
		end
	
	Error_string: STRING is
			-- Error description
		do
			Result := internal_error_string
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
		end

	print_error_message (st: STRUCTURED_TEXT) is
			-- Print error message on output.
		local
			i, j: INTEGER
		do
			from
				i := error_string.index_of ('%N', 1)
				st.add_string ("IL Generation Error:")
				st.add_new_line
			until
				i = 0
			loop
				st.add_string (error_string.substring (j + 1, i - 1))
				st.add_new_line
				j := i
				i := error_string.index_of ('%N', i + 1)
			end
		end

feature {NONE} -- Implementation

	internal_error_string: STRING
			-- Internal copy of error description

end -- class UNUSED_LOCAL_WARNING

indexing
	description: "Error when a class name is not found in the surrounding universe."
	date: "$Date$"
	revision: "$Revision$"

class VTCT 

inherit
	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	class_name: STRING
			-- Class name not found

	code: STRING is "VTCT"
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Unknown class name: ")
			st.add_string (class_name)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		require
			s_not_void: s /= Void
		do
			class_name := s.as_upper
		ensure
			class_name_set: class_name /= Void
		end

	set_dotnet_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		require
			s_not_void: s /= Void
		do
			class_name := s
		ensure
			class_name_set: class_name = s
		end

end -- class VTCT

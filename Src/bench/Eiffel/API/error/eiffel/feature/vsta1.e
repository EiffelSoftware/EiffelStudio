indexing
	description: "Error when an invalid class type is specified for a static access."
	date: "$Date$"
	revision: "$Revision$"

class VSTA1

inherit
	EIFFEL_ERROR
		redefine
			build_explain, is_defined, subcode
		end

create
	make

feature {NONE} -- Initialization

	make (s, f: STRING) is
			-- Create new instance of VSTA1 with class name `s'
			-- and feature name `f'.
		require
			s_not_void: s /= Void
			f_not_void: f /= Void
		do
			class_name := s
			feature_name := f
		ensure
			class_name_set: class_name = s
			feature_name_set: feature_name = f
		end

feature -- Access

	code: STRING is "VSTA"
			-- Error code
			
	subcode: INTEGER is 1

	class_name, feature_name: STRING
			-- Class name and feature name of routine on which invalid static access is performed.

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := class_name /= Void and feature_name /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		local
			c_name: STRING
		do
			c_name := clone (class_name)
			c_name.to_upper
			st.add_string ("Invalid class name %"" + c_name + "%" in direct access of ")
			st.add_feature_name (feature_name, class_c)
			st.add_new_line
		end

end -- class VSTA1

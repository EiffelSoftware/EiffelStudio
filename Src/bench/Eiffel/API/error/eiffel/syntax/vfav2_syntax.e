indexing
	description: "VFAV(2) error detected at parsing time.";
	date: "$Date$";
	revision: "$Revision$"

class VFAV2_SYNTAX

inherit

	SHARED_EIFFEL_PARSER
	SYNTAX_ERROR
		rename
			make as make_syntax
		end

create
	make

feature {NONE} -- Creation

	make (f: FEATURE_NAME) is
			-- Create error object.
		require
			feature_name_not_void: f /= Void
			alias_name_not_void: f.alias_name /= Void
			is_bracket: f.is_bracket
		do
			(create {REFACTORING_HELPER}).fixme ("Redesign this class to provide better reporting facilities")
			make_syntax (f.start_location.line, f.start_location.column, create {FILE_NAME}.make_from_string (eiffel_parser.filename),
				"Feature with bracket alias should be a query and have at least one argument", False)
			set_location (f.start_location)
		end

feature -- Property

--	code: STRING is "VFAV2_syntax"
			-- Error code

end

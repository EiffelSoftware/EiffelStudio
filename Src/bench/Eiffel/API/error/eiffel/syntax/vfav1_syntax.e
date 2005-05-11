indexing
	description: "VFAV(1) error detected at parsing time.";
	date: "$Date$";
	revision: "$Revision$"

class VFAV1_SYNTAX

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
			is_binary_or_unary: f.is_binary or f.is_unary
		do
			(create {REFACTORING_HELPER}).fixme ("Redesign this class to provide better reporting facilities")
			make_syntax (f.start_location.line, f.start_location.column, create {FILE_NAME}.make_from_string (eiffel_parser.filename), 
				"Feature with operator alias should be a query and %
				%have no arguments if operator is unary or one argument if operator is binary", False
			)
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

feature -- Property

--	code: STRING is "VFAV1_syntax"
			-- Error code

	feature_name: FEATURE_NAME
			-- Erroneous feature name

end

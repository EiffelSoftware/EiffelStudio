indexing
	description: "Abstract description of expanded class type. %
			%Version for Bench version."
	date: "$Date$"
	revision: "$Revision$"

class EXP_TYPE_AS_B

inherit
	EXP_TYPE_AS
		undefine
			same_as, associated_eiffel_class, append_to
		redefine
			record_expanded,
			class_name, generics
		end

	CLASS_TYPE_AS_B
		undefine
			set, dump, simple_format
		redefine
			actual_type, solved_type, class_name, generics
		end

feature -- Properties

	class_name: ID_AS_B

	generics: EIFFEL_LIST_B [TYPE_B]

feature

	record_expanded is
			-- This must be done before pass2
			-- `solved_type' and `actual type' are called in pass3 for
			-- local variables
		do
			System.set_has_expanded
			System.current_class.set_has_expanded
		end

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
		do
			Result := {CLASS_TYPE_AS_B} Precursor (feat_table, f)
			Result.set_is_expanded (True)
			record_exp_dependance (Result.associated_class)
		end

	actual_type: CL_TYPE_A is
			-- Expanded actual class type
		do
			Result := {CLASS_TYPE_AS_B} Precursor
			Result.set_is_expanded (True)
			record_exp_dependance (Result.associated_class)
		end

end -- class EXP_TYPE_AS_B

indexing

	description:
		"Abstract description of expanded class type. %
		%Version for Bench version.";
	date: "$Date$";
	revision: "$Revision$"

class EXP_TYPE_AS_B

inherit

	EXP_TYPE_AS
		undefine
			same_as, associated_eiffel_class, append_to
		redefine
			record_expanded,
			class_name, generics
		end;

	CLASS_TYPE_AS_B
		rename
			actual_type as basic_actual_type,
			solved_type as basic_solved_type,
			format as basic_format
		undefine
			set, dump, simple_format
		redefine
			class_name, generics
		end;
	CLASS_TYPE_AS_B
		undefine
			set, dump, simple_format
		redefine
			actual_type, solved_type, format, class_name, generics
		select
			actual_type, solved_type, format
		end

feature -- Properties

	class_name: ID_AS_B;

	generics: EIFFEL_LIST_B [TYPE_B]

feature

	record_expanded is
			-- This must be done before pass2
			-- `solved_type' and `actual type' are called in pass3 for
			-- local variables
		do
			System.set_has_expanded;
			System.current_class.set_has_expanded;
		end;

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): CL_TYPE_A is
		do
			Result := basic_solved_type (feat_table, f);
			Result.set_is_expanded (True);
			record_exp_dependance (Result.associated_class);
		end;

	actual_type: CL_TYPE_A is
			-- Expanded actual class type
		do
			Result := basic_actual_type;
			Result.set_is_expanded (True);
			record_exp_dependance (Result.associated_class);
		end;

feature -- Output

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.put_text_item (ti_Expanded_keyword);
			ctxt.put_space;
			basic_format (ctxt);
		end;

end -- class EXP_TYPE_AS_B

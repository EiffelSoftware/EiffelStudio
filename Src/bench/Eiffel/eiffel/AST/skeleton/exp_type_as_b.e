indexing

	description:
		"Abstract description of expanded class type. %
		%Version for Bench version.";
	date: "$Date$";
	revision: "$Revision$"

class EXP_TYPE_AS_B

inherit

	EXP_TYPE_AS
		rename
			class_name as old_class_name,
			generics as old_generics
		undefine
			same_as
		redefine
			record_expanded, is_deep_equal
		end;

	CLASS_TYPE_AS_B
		rename
			actual_type as basic_actual_type,
			solved_type as basic_solved_type,
			format as basic_format
			--class_name as basic_class_name
		undefine
			set, is_deep_equal, dump, simple_format
		end;
	CLASS_TYPE_AS_B
		undefine
			set, is_deep_equal, dump, simple_format
		redefine
			actual_type, solved_type, format
		select
			actual_type, solved_type, format, generics,
			class_name
		end

feature

	is_deep_equal (other: TYPE_B): BOOLEAN is
		local
			o: like Current
		do
			o ?= other;
			Result := o /= Void and then basic_is_deep_equal (other)
		end;

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

	format (ctxt: FORMAT_CONTEXT_B) is 
		do
			ctxt.put_text_item (ti_Expanded_keyword);
			ctxt.put_space;
			basic_format (ctxt);
		end;

end -- class EXP_TYPE_AS_B

-- Abstract description of expanded class type

class EXP_TYPE_AS

inherit

	CLASS_TYPE_AS
		rename
			actual_type as basic_actual_type,
			solved_type as basic_solved_type,
			dump as basic_dump,
			set as basic_set,
			format as basic_format,
			is_deep_equal as basic_is_deep_equal
		end;
	CLASS_TYPE_AS
		redefine
			actual_type, solved_type, dump, set, format,
			is_deep_equal
		select
			actual_type, solved_type, dump, set, format,
			is_deep_equal
		end;

feature

	set is
			-- Yacc initialization
		do
			basic_set;
			record_expanded
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

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			o: EXP_TYPE_AS
		do
			o ?= other;
			Result := o /= Void and then basic_is_deep_equal (other)
		end;

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (class_name.count + 9);
			Result.append ("expanded ");
			Result.append (basic_dump);
		end;

	format (ctxt: FORMAT_CONTEXT) is 
		do
			ctxt.put_text_item (ti_Expanded_keyword);
			ctxt.put_space;
			basic_format (ctxt);
		end;

end

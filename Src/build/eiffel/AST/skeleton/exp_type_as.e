-- Abstract description of expanded class type

class EXP_TYPE_AS

inherit

	CLASS_TYPE_AS
		rename
			dump as basic_dump,
			set as basic_set,
			simple_format as basic_simple_format,
			is_deep_equal as basic_is_deep_equal
		end;

	CLASS_TYPE_AS
		redefine
			dump, set, simple_format, is_deep_equal
		select
			dump, set, simple_format, is_deep_equal
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

	simple_format (ctxt: FORMAT_CONTEXT) is 
		do
			ctxt.put_text_item (ti_Expanded_keyword);
			ctxt.put_space;
			basic_simple_format (ctxt);
		end;

end

indexing

	description: 
		"AST representation of separate class type.";
	date: "$Date$";
	revision: "$Revision$"

class SEPARATE_TYPE_AS

inherit

	CLASS_TYPE_AS
		rename
			dump as basic_dump,
			set as basic_set,
			simple_format as basic_simple_format
		end;

	CLASS_TYPE_AS
		redefine
			dump, simple_format, set
		select
			dump, simple_format, set
		end;

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			basic_set;
			record_separate
		end;

	record_separate is
			-- Record the use of the separate keyword
		do
			-- Do nothing
		end;
 
feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (class_name.count + 9);
			Result.append ("separate ");
			Result.append (basic_dump);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Separate_keyword);
			ctxt.put_space;
			basic_simple_format (ctxt);
		end;

end -- class SEPARATE_TYPE_AS

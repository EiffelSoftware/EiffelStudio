indexing

	description: "Node for `like Current' type.";
	date: "$Date$";
	revision: "$Revision$"

class LIKE_CUR_AS

inherit

	TYPE
		redefine
			has_like, simple_format
		end;

feature
		
	set is
			-- Yacc initialization
		do
			-- Do nothing
		end; -- set

feature

	has_like: BOOLEAN is True;
			-- Does the type have anchor in its definition ?

	dump: STRING is "like Current";
			-- Dump trace

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Like_keyword);
			ctxt.put_string (" Current");
		end;

end -- class LIKE_CUR_AS

indexing

	description: 
		"AST representation for `like Current' type.";
	date: "$Date$";
	revision: "$Revision$"

class LIKE_CUR_AS

inherit

	TYPE
		redefine
			has_like, simple_format
		end;

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new LIKE_CURRENT AST node.
		do
			-- Do nothing.
		end

feature {NONE} -- Initialization
		
	set is
			-- Yacc initialization
		do
			-- Do nothing
		end; -- set

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	has_like: BOOLEAN is True;
			-- Does the type have anchor in its definition ?

feature -- Output

	dump: STRING is "like Current";
			-- Dump trace

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Like_keyword);
			ctxt.put_space;
			ctxt.put_text_item_without_tabs (ti_Current)
		end;

end -- class LIKE_CUR_AS

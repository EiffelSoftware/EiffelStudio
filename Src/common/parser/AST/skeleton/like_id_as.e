indexing
		
	description: 
		"AST representation for `like id' type.";
	date: "$Date$";
	revision: "$Revision$"

class LIKE_ID_AS

inherit

	TYPE
		redefine
			has_like, simple_format
		end;

feature {AST_FACTORY} -- Initialization

	initialize (a: like anchor) is
			-- Create a new LIKE_ID AST node.
		require
			a_not_void: a /= Void
		do
			anchor := a
		ensure
			anchor_set: anchor = a
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			anchor ?= yacc_arg (0);
		ensure then
			anchor_exists: anchor /= Void
		end;

feature -- Properties

	anchor: ID_AS;
			-- Anchor name

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (anchor, other.anchor)
		end

feature -- Access

	has_like: BOOLEAN is True
			-- Has the type anchored type in its definition ?

feature -- Output

	dump: STRING is
			-- Dump string
		do
			!!Result.make (5 + anchor.count);
			Result.append ("like ");
			Result.append (anchor);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Like_keyword);
			ctxt.put_space;
			ctxt.prepare_for_feature (anchor, Void);
			ctxt.put_current_feature;
		end;
	
feature {LIKE_ID_AS} -- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end;

end -- class LIKE_ID_AS

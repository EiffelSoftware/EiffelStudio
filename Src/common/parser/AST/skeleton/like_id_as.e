indexing
		
	description: "Abstract description for `like id' type.";
	date: "$Date$";
	revision: "$Revision$"

class LIKE_ID_AS

inherit

	TYPE
		redefine
			has_like, is_deep_equal, simple_format
		end;

feature -- Attributes

	anchor: ID_AS;
			-- Anchor name

feature -- Initialization

	set is
			-- Yacc initialization
		do
			anchor ?= yacc_arg (0);
		ensure then
			anchor_exists: anchor /= Void
		end;

feature -- Implementation of inherited deferred features

	is_deep_equal (other: TYPE): BOOLEAN is
		local
			o: like Current
		do
			o ?= other;
			Result := o /= Void and then
				anchor.is_equal (o.anchor);
		end;

	has_like: BOOLEAN is
			-- Has the type anchored type in its definition ?
		do
			Result := True;
		end;

	dump: STRING is
			-- Dump string
		do
			!!Result.make (5 + anchor.count);
			Result.append ("like ");
			Result.append (anchor);
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item_without_tabs (ti_Like_keyword);
			ctxt.put_space;
			ctxt.prepare_for_feature (anchor, Void);
			ctxt.put_current_feature;
		end;
	
feature {LIKE_ID_AS}	-- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end;

end -- class LIKE_ID_AS

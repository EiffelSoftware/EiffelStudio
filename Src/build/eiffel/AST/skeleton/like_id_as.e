-- Abstract description for "like id" type

class LIKE_ID_AS

inherit

	TYPE
		redefine
			has_like, simple_format, is_deep_equal
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
			o: LIKE_ID_AS
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
	
	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.put_text_item (ti_Like_keyword);
			ctxt.put_space;
			ctxt.prepare_for_feature (anchor, Void);
			ctxt.put_current_feature;
			ctxt.commit;
		end;

feature {LIKE_ID_AS}	-- Replication

	set_anchor (a: like anchor) is
		do
			anchor := a
		end;

end

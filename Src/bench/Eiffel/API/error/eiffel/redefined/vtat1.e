indexing

	description: 
			"Error for unvalid anchored type (an anchored type cannot be evaluated). %
				%1. cycle in like features %
				%2. like feature wich is defined in terms of like argument %
				%3. unvalid feature name for anchor %
				%4. anchor is a procedure %
				%5. cycle involving like arguments";
	date: "$Date$";
	revision: "$Revision $"


class VTAT1 obsolete "NOT THE SAME MEANING AS THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end
create
	default_create, make

feature {NONE} -- Initialize

	make (a_type, an_anchor: TYPE_AS) is
			-- New error occuring in `a_type' for anchor `an_anchor'.
		require
			a_type_not_void: a_type /= Void
			an_anchor_not_void: an_anchor /= Void
		do
			type := a_type
			anchor_type := an_anchor
		ensure
			type_set: type = a_type
			anchor_set: anchor_type = an_anchor
		end
		
feature -- Properties

	type: TYPE_AS;
			-- Type in which VTAT error occurs

	anchor_type: TYPE_AS
			-- Anchor in which error occurs.

	code: STRING is "VTAT";
			-- Error code

	subcode: INTEGER is 1;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			if anchor_type /= Void then
				st.add_string ("Anchored type: ")
				anchor_type.append_to (st)
				st.add_new_line
			end
			st.add_string ("Appearing in type: ")
			type.append_to (st)
			st.add_new_line
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

end

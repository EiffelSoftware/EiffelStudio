-- Error for unvalid anchored type (an anchored type cannot be evaluated).
--	1. cycle in like features
--	2. like feture wich is defined in terms of like argument
--	3. unvalid feature name for anchor
--	4. anchor is a procedure
--	5. cycle involving like arguments

class VTAT1 

inherit

	EIFFEL_ERROR
		redefine
			build_explain, subcode
		end

feature

	type: TYPE;
			-- Type non evaluated

	body_id: INTEGER;
			-- Body id of the feature involved in.
			-- [Note that this feature is written in the class of id
			-- `class_id'.]

	set_body_id (i: INTEGER) is
			-- Assign `i' to `body_id'.
		do
			body_id := i;
		end;

	set_type (t: TYPE) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	code: STRING is "VTAT";
			-- Error code

	subcode: INTEGER is 1;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("%Ttype: ");
-- FIXME: pass the classc for the type as argument
			put_string (type.dump);
			new_line;
		end;

end

-- Error for unvalid anchored type (an anchored type cannot be evaluated).
--	1. cycle in like features
--	2. like feture wich is defined in terms of like argument
--	3. unvalid feature name for anchor
--	4. anchor is a procedure
--	5. cycle involving like arguments

class VTAT1 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
			build_explain
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

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
		local
			class_stone: CLASSC_STONE;
			class_c: CLASS_C
        do
            old_build_explain (a_clickable);
			error_window.put_string ("%Ttype: ");
-- FIXME: pass the classc for the type as argument
			!!class_stone.make (class_c);
			error_window.put_clickable_string (class_stone, type.dump);
			error_window.put_string ("%N");
		end;

end

-- Error when bad conformance on first argument of an infix function

class VWOE1 

inherit

	VWOE
		rename
			build_explain as vwoe_build_explain
		redefine
			subcode
		end;

	VWOE
		redefine
			build_explain, subcode
		select
			build_explain
		end
	
feature

	subcode: INTEGER is 1;

	formal_type: TYPE_A;
			-- Formal argument type

	actual_type: TYPE_A;
			-- Actual type of the argument in the call

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `actual_type'
		do
			actual_type := t;
		end;

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
            vwoe_build_explain;
			put_string ("%T%T");
-- FIXME:
--			actual_type.build_explain;
			put_string (" doesn't conform to ");
-- FIXME:
--			formal_type.build_explain;
			new_line;
		end;

end

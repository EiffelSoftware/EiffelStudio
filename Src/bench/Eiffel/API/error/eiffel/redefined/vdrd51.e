-- Error for non-conformance of Result types for redefinitions

class VDRD51 

inherit

	VDRD5
		rename 
			build_explain as vdrd5_build_explain
		end;

	VDRD5
		redefine
			build_explain
		select
			build_explain
		end
	
feature 

	type: TYPE_A;
			-- New type

	precursor_type: TYPE_A;
			-- Old type

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_precursor_type (t: TYPE_A) is
			-- Assign `t' to `precursor_type'.
		do
			precursor_type := t;
		end;

	code: STRING is 
			-- Error code
		do
			Result := "VDRD";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
			vdrd5_build_explain (a_clickable);
			io.error.putstring ("%Tprecursor type: ");
-- FIXME:
--			precursor_type.build_explain;
			io.error.putstring ("%N%Tredeclared type: ");
-- FIXME:
--			type.build_explain;
			io.error.new_line;
		end;

end

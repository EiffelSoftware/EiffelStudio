-- Error for non-conformance of Result types for redefinitions

class VDRD51 

inherit

	VDRD5
		rename 
			build_explain as vdrd5_build_explain
		redefine
			subcode
		end;

	VDRD5
		redefine
			build_explain, subcode
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

	subcode: INTEGER is 
			-- Error code
		do
			Result := 51;
		end;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			vdrd5_build_explain;
			put_string ("%Tprecursor type: ");
-- FIXME:
--			precursor_type.build_explain;
			put_string ("%N%Tredeclared type: ");
-- FIXME:
--			type.build_explain;
			new_line;
		end;

end

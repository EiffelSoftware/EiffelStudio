-- Error for undeclared identifier

class VEEN 

inherit

	FEATURE_ERROR
		rename
			build_explain as old_build_explain
		end;

	FEATURE_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature 

	identifier: ID_AS;
			-- Undeclared identifier

	set_identifier (i: ID_AS) is
			-- Assign `i' to `identifier'.
		do
			identifier := i;
		end;

	code: STRING is "VEEN";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Tidentifier: `");
			a_clickable.put_string (identifier);
			a_clickable.put_string ("'%N")
		end

end

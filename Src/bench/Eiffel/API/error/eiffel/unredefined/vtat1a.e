class VTAT1A 

inherit

	VTAT1
		rename
			build_explain as old_build_explain
		end;
	VTAT1
		redefine
			build_explain
		select
			build_explain
		end;

feature 

	argument_name: STRING;
			-- Argument name which anchored type in unvalid

	set_argument_name (s: STRING) is
			-- Assign `s' to `argument_name'.
		do
			argument_name := s;
		end;

	build_explain is
		do
			put_string ("Anchor name: ");
			put_string (argument_name);
			new_line;
			old_build_explain;
		end;

end

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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Anchor name: ");
			ow.put_string (argument_name);
			ow.new_line;
			old_build_explain (ow);
		end;

end

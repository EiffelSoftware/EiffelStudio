-- Error for calling a feature with the wrong number of arguments

class VUAR1 

inherit

	VUAR
		rename
			build_explain as old_build_explain
		redefine
			code
		end;
	VUAR
		redefine
			code, build_explain
		select
			build_explain
		end;

feature

	code: STRING is "VUAR1";

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%T%Twrong number of arguments");
		end;

end

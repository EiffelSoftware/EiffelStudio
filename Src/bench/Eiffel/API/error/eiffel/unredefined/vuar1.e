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
		local
			class_name: STRING;
		do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%T%Twrong number of arguments for ");
			a_clickable.put_string (feature_i.feature_name);
			a_clickable.put_string (" written in ");
			class_name := feature_i.written_class.class_name.duplicate;
			class_name.to_upper;
			a_clickable.put_string (class_name);
			a_clickable.new_line;
		end;

end

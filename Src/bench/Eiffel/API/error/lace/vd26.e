-- Error when there is an ambiguity for a visible class name

class VD26

inherit

	CLUSTER_ERROR
		rename
			build_explain as basic_build_explain
		end;
	CLUSTER_ERROR
		redefine
			build_explain
		select
			build_explain
		end

feature

	class_name: STRING;
			-- Class name subject to ambiguity

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	code: STRING is "VD26";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			basic_build_explain (a_clickable);
			a_clickable.put_string ("%Tclass name: ");
			a_clickable.put_string (class_name);
			a_clickable.new_line;
		end;

end

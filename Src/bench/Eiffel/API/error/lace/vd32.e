-- Warning for unknown free option

class VD32

inherit

	ERROR
		redefine
			Error_string,
			build_explain
		end;

feature

	node: D_OPTION_SD;
			-- Option node

	option_name: STRING;
			-- Option name

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	set_option_name (s: STRING) is
			-- Assign `s' to `option_name'
		do
			option_name := s
		end;

	code: STRING is
			-- Error code
		do
			Result := "VD32";
		end;

	Error_string: STRING is
		do
			Result := "Warning "
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TUnknown option: ");
			a_clickable.put_string (option_name);
			a_clickable.new_line;
		end;

end

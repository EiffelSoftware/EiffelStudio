-- Error for unvalid value for option

class VD15

inherit

	ERROR
		redefine
			build_explain
		end

feature

	node: D_OPTION_SD;
			-- Option node

	set_node (n: like node) is
			-- Assign `n' to `node'.
		do
			node := n;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VD15";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("Invalid option value: ");
			a_clickable.put_string (node.value.value);
			a_clickable.put_string (" for option ");
			a_clickable.put_string (node.option.option_name);
			a_clickable.new_line;
		end;

end

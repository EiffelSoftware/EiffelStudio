-- Error for invalid value for option

class VD15

inherit

	LACE_ERROR
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

	build_explain is
		do
			put_string ("Option name: `");
			put_string (node.option.option_name);
			put_string ("'%NOption value: `");
			put_string (node.value.value);
			put_char ('%'');
			new_line
		end;

end

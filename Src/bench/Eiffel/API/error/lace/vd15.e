-- Error for unvalid value for option

class VD15

inherit

	ERROR

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

end

class EWB_SUBQUERY

inherit
	EWB_ACTIVATABLE

creation
	make

feature -- Initialization

	make (c, o, v: STRING) is
			-- Create a subquery for column `c', with operator `o',
			-- and specified value `v'.
		require
			c_not_void: c /= Void;
			o_not_void: o /= Void;
			v_not_void: v /= Void;
		do
			int_column := c;
			int_operator := o;
			int_value := v;
			activate;
		ensure
			activated: is_active;
			correct_body: column = c and then operator = o and then
							value = v;
		end;

feature -- Properties

	column: STRING is
		do
			Result := int_column;
		end;

	operator: STRING is
		do
			Result := int_operator;
		end;

	value: STRING is
		do
			Result := int_value;
		end;

feature {NONE} -- Attributes

	int_column,
	int_operator,
	int_value: STRING;

end -- class EWB_SUBQUERY

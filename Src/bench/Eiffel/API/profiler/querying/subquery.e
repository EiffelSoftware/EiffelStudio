indexing
	description: "Sub query used to build a total query to query the profile information"
	date: "$Date$"
	revision: "$Revision$"

class 
	SUBQUERY

inherit
	ACTIVATABLE

create 
	make

feature -- Initialization

	make (c, o, v: STRING) is
			-- Create a subquery for column `c', with operator `o',
			-- and specified value `v'.
		require
			c_not_void: c /= void
			o_not_void: o /= void
			v_not_void: v /= void
		do
			int_column := c
			int_operator := o
			int_value := v
			activate
		ensure
			activated: is_active
			correct_body: column = c and then operator = o and then value = v
		end
	
feature -- Properties

	column: STRING is
		do
			Result := int_column
		end

	operator: STRING is
		do
			Result := int_operator
		end

	value: STRING is
		do
			Result := int_value
		end

	image: STRING is
		do
			create Result.make (0)
			Result.append (column)
			Result.extend (' ')
			Result.append (operator)
			Result.extend (' ')
			Result.append (value)
		end
	
feature {NONE} -- Attributes

	int_column: STRING

	int_operator: STRING

	int_value: STRING
	
end -- class SUBQUERY

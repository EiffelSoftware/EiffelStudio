indexing
	description: "[
		Objects that represent an EiffelBuild INTEGER constant.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_INTEGER_CONSTANT
	
inherit
	GB_CONSTANT
	
create
	make_with_name_and_value
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name: STRING; a_value: INTEGER) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
			a_value_valid: a_value /= Void and then a_value /= Void
		do
			name := clone (a_name)
			value := a_value
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end

feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := Integer_constant_type
		end
		
	value: INTEGER
		-- Value of `Current'.
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		do
			Result := value.out
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.extend (type)
			Result.extend (name)
			Result.extend (value.out)
			Result.set_data (current)
		end

feature -- Status setting

	set_value (a_value: INTEGER) is
			-- Assign `a_value' to `value'.
		do
			value := a_value
		ensure
			value_set: a_value = value
		end

invariant
	value_not_void: value /= Void

end -- class GB_INTEGER_CONSTANT
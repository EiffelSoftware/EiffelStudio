indexing
	description: "Objects that represent an EiffelBuild STRING constant."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_STRING_CONSTANT
	
inherit
	GB_CONSTANT
	
create
	make_with_name_and_value
	
feature {NONE} -- Initialization

	make_with_name_and_value (a_name, a_value: STRING) is
			-- Assign `a_name' to `name' and `a_value' to value.
		require
			a_name_valid: a_name /= Void and then a_value /= Void
			a_value_valid: a_value /= Void and then a_value /= Void
		do
			name := clone (a_name)
			value := clone (a_value)
			create referers.make (4)
		ensure
			name_set: name.is_equal (a_name) and name /= a_name
			value_set: value.is_equal (a_Value) and value /= a_value
		end

feature -- Access

	type: STRING is
			-- Type represented by `Current'
		once
			Result := String_constant_type
		end

	value: STRING
		-- Value of `Current'.
		
	value_as_string: STRING is
			-- Value represented by `Current' as a STRING.
		do
			Result := clone (value)
		end
		
	as_multi_column_list_row: EV_MULTI_COLUMN_LIST_ROW is
			-- Representation of `Current' as a multi column list row.
		do
			create Result
			Result.set_pixmap (icon_string @ 1)
			Result.extend (name)
			Result.extend (type)
			Result.extend (value)
			Result.set_data (Current)
		end

feature -- Status setting

	set_value (a_value: STRING) is
			-- Assign `a_value' to `value'.
		require
			value_ok: a_value /= Void and then not a_value.is_empty
		do
			value := a_value
		ensure
			value_set: a_value = value
		end

invariant
	value_not_void: value /= Void

end -- class GB_STRING_CONSTANT

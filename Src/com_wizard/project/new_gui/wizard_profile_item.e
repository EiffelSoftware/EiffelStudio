indexing
	description: "Profile item, consists of a name and a list of values"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROFILE_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_value: like value) is
			-- Set `name' with `a_name' and `value' with `a_value'.
		require
			non_void_name: a_name /= Void
			non_void_value: a_value /= Void
		do
			name := a_name
			value := a_value
		ensure
			name_set: name = a_name
			value_set: value = a_value
		end

feature -- Access

	name: STRING
			-- Item name
	
	value: STRING
			-- Item value

	linear_representation: LIST [STRING] is
			-- List composed of (name, value)
		do
			create {ARRAYED_LIST [STRING]} Result.make (2)
			Result.extend (name)
			Result.extend (value)
		ensure
			non_void_representation: Result /= Void
			definition: Result.first.is_equal (name) and Result.i_th (2).is_equal (value)
		end

invariant
	non_void_name: name /= Void
	non_void_value: value /= Void

end -- class WIZARD_PROFILE_ITEM

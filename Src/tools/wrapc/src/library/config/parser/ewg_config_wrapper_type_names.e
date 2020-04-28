note

	description:

		"EWG config attribute names"

	copyright: "Copyright (c) 2004, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class EWG_CONFIG_WRAPPER_TYPE_NAMES

inherit

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end
	ANY

feature -- Constants

	default_name: STRING = "default"

	none_name: STRING = "none"


	name_set: DS_HASH_SET [STRING]
		once
			create Result.make (2)
			Result.set_equality_tester (string_equality_tester)
			Result.put_new (default_name)
			Result.put_new (none_name)
		ensure
			name_set_not_void: Result /= Void
--			no_void_name: not Result.has (Void)
		end


	is_valid_wrapper_type_name (a_value: STRING): BOOLEAN
		require
			a_value_not_void: a_value /= Void
		do
			Result := name_set.has (a_value)
		end


end

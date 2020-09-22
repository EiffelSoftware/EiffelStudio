note

	description:

		"Feature names found in EWG_STRUCT"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_STRUCT_FEATURE_NAMES

inherit

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end

	ANY

create {EWG_SHARED_STRUCT_FEATURE_NAMES}

	make

feature {NONE} -- Initialization

	make
			-- Create new feature name object.
		do
		end

feature -- Status

	has (a_name: STRING): BOOLEAN
			-- Is `a_name' a feature name in class ANY?
		do
			Result := names.has (a_name.as_lower)
		end

feature {NONE} -- Implementation

	names: DS_HASH_SET [STRING]
			-- Set of names of features from class ANY
		once
			create Result.make (8)
			Result.set_equality_tester (string_equality_tester)
			Result.put_new ("make")
			Result.put_new ("make_by_pointer")
			Result.put_new ("item")
			Result.put_new ("structure_size")
			Result.put_new ("internal_item")
			Result.put_new ("exists")
			Result.put_new ("managed_pointer")
			Result.put_new ("shared")
		ensure
			names_not_void: names /= Void
		end

end

note

	description:

		"Feature names found in ANY"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_ANY_FEATURE_NAMES

inherit

	EWG_SHARED_STRING_EQUALITY_TESTER
		export {NONE} all end
	ANY

create {EWG_SHARED_ANY_FEATURE_NAMES}

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
			create Result.make (29)
			Result.set_equality_tester (string_equality_tester)
			Result.put_new ("generator")
			Result.put_new ("generating_type")
			Result.put_new ("conforms_to")
			Result.put_new ("same_type")
			Result.put_new ("is_equal")
			Result.put_new ("standard_is_equal")
			Result.put_new ("equal")
			Result.put_new ("standard_equal")
			Result.put_new ("deep_equal")
			Result.put_new ("twin")
			Result.put_new ("copy")
			Result.put_new ("standard_copy")
			Result.put_new ("clone")
			Result.put_new ("standard_clone")
			Result.put_new ("standard_twin")
			Result.put_new ("deep_twin")
			Result.put_new ("deep_clone")
			Result.put_new ("deep_copy")
			Result.put_new ("internal_correct_mismatch")
			Result.put_new ("io")
			Result.put_new ("out")
			Result.put_new ("tagged_out")
			Result.put_new ("print")
			Result.put_new ("operating_environment")
			Result.put_new ("default_create")
			Result.put_new ("default_rescue")
			Result.put_new ("do_nothing")
			Result.put_new ("default")
			Result.put_new ("default_pointer")
		ensure
			names_not_void: names /= Void
		end

end

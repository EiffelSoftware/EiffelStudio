indexing

	description: 
		"Table representing features for a class hashed on feature name.";
	date: "$Date$";
	revision: "$Revision $"

class
	E_FEATURE_TABLE

inherit
	HASH_TABLE [E_FEATURE, STRING]

	SHARED_EIFFEL_PROJECT
		undefine
			copy, is_equal
		end

creation
	make

feature -- Properties

	class_id: INTEGER;
			-- Id of the class to which the feature table belongs to.

	associated_class: CLASS_C is
			-- Associated class
		require
			valid_class_id: class_id /= 0
		do
			Result := Eiffel_system.class_of_id (class_id);
		end;

feature {FEATURE_TABLE} -- Optimization

	set_class_id (i: like class_id) is
			-- Set the `class_id' to i.
		do
			class_id := i
		ensure
			set: class_id = i
		end

end -- class E_FEATURE_TABLE

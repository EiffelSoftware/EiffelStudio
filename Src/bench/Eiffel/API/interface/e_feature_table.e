indexing

	description: 
		"Table representing features for a class hashed on feature name.";
	date: "$Date$";
	revision: "$Revision $"

class E_FEATURE_TABLE

inherit

	HASH_TABLE [E_FEATURE, STRING]
		export
			{FEATURE_TABLE} set_content, set_deleted_marks, set_keys
		end;
	SHARED_EIFFEL_PROJECT
		undefine
			copy, is_equal
		end

creation
	make

feature -- Properties

	class_id: CLASS_ID;
			-- Id of the class to which the feature table belongs to.

	associated_class: E_CLASS is
			-- Associated class
		require
			valid_class_id: class_id /= Void
		do
			Result := Eiffel_system.class_of_id (class_id);
		end;

feature {FEATURE_TABLE} -- Element change

	set_capacity (new_capacity: INTEGER) is
		do
			capacity := new_capacity
		end

feature {FEATURE_TABLE} -- Optimization

	set_class_id (i: like class_id) is
			-- Set the `class_id' to i.
		do
			class_id := i
		ensure
			set: class_id = i
		end

	basic_copy_from (table: HASH_TABLE [ANY, STRING]) is
			-- Do the basic copy from `table'.
			-- (Skip copying the content)
		do
			object_comparison := table.object_comparison;
			count := table.count;
		end

end -- class E_FEATURE_TABLE

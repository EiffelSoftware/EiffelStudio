indexing
	description: "Eiffel class representation"
	date: "$Date$"
	revision: "$Revision$"

class
	EI_CLASS

create
	make

feature {NONE} -- Initialization

	make (c_name: STRING) is
			-- Initialize and set 'name' to 'c_name'.
		require
			non_void_name: c_name /= Void
			valid_name: not c_name.is_empty
		do
			name := clone (c_name)
			create description.make (0)
			create features.make (5)
		end

feature -- Access

	name: STRING
			-- Class name

	features: HASH_TABLE[EI_FEATURE, STRING]
			-- Features (routines, functions, attributes)
			-- Feature name as key.

	description: STRING
			-- Class description

feature -- Basic operations

	set_name (c_name: STRING) is
			-- Set 'name' to 'c_name'.
		require
			valid_name: c_name /= Void and then not c_name.is_empty
		do
			name := clone (c_name)
		ensure
			name_set: name.is_equal (c_name)
		end

	set_description (desc: STRING) is
			-- Set 'description' to 'desc'.
		require
			valid_description: desc /= Void and then not desc.is_empty
		do
			description := clone (desc)
		ensure
			description_set: description.is_equal (desc)
		end

	add_feature (l_feature: EI_FEATURE) is
			-- Add 'feature' to 'features'.
		require
			non_void_feature: l_feature /= Void
		do
			features.put (l_feature, l_feature.name)
		ensure
			feature_added: features.has (l_feature.name)
		end

invariant
	non_void_name: name /= Void
	valid_name: not name.is_empty
	non_void_description: description /= Void
	non_void_features: features /= Void

end -- class EI_CLASS

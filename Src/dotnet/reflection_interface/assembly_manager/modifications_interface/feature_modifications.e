indexing
	description: "Feature modifications"
	external_name: "ISE.AssemblyManager.FeatureModifications"

class
	FEATURE_MODIFICATIONS

create
	make,
	make_from_info
	
feature {NONE} -- Initialization

	make is
		indexing
			description: "Initialize `arguments_modifications'."
			external_name: "Make"
		do
			create arguments_modifications.make
		ensure
			non_void_arguments_modifications: arguments_modifications /= Void
		end
	
	make_from_info (old_name: like old_feature_name) is
		indexing
			description: "Set `old_feature_name' with `old_name'."
			external_name: "MakeFromInfo"
		require
			non_void_old_name: old_name /= Void
		do
			set_old_feature_name (old_name)
			create arguments_modifications.make
		ensure
			old_feature_name_set: old_feature_name.equals_string (old_name)
			non_void_arguments_modifications: arguments_modifications /= Void
		end

feature -- Access
		
	old_feature_name: STRING 
		indexing
			description: "Old feature name"
			external_name: "OldFeatureName"
		end
	
	new_feature_name: STRING
		indexing
			description: "New feature name"
			external_name: "NewFeatureName"
		end

	arguments_modifications: SYSTEM_COLLECTIONS_HASHTABLE
			-- | Key: Instance of `NAMED_SIGNATURE_TYPE'
			-- | Value: New argument name
		indexing
			description: "Features modifications"
			external_name: "ArgumentsModifications"
		end
		
feature -- Status Setting
	
	set_old_feature_name (a_name: like old_feature_name) is
		indexing
			description: "Set `old_feature_name' with `a_name'."
			external_name: "SetOldFeatureName"
		require
			non_void_name: a_name /= Void
		do
			old_feature_name := a_name
		ensure
			old_feature_name_set: old_feature_name.equals_string (a_name)
		end
		
	set_new_feature_name (a_name: like old_feature_name) is
		indexing
			description: "Set `new_feature_name' with `a_name'."
			external_name: "SetNewFeatureName"
		require
			non_void_name: a_name /= Void
		do
			new_feature_name := a_name
		ensure
			new_feature_name_set: new_feature_name.equals_string (a_name)
		end

feature -- Basic Operations

	add_argument_modification (an_argument: ISE_REFLECTION_NAMEDSIGNATURETYPE; new_argument_name: STRING) is
		indexing
			description: "[Add `new_argument_name' to `arguments_modifications' with key `an_argument'.%
					%If `an_argument' is already in table, the existing value will be replaced by `new_argument_name'.]"
			external_name: "AddArgumentModification"
		require
			non_void_argument: an_argument /= Void
			non_void_argument_name: new_argument_name /= Void
		do
			if not arguments_modifications.containskey (an_argument) then
				arguments_modifications.add (an_argument, new_argument_name)
			else
				arguments_modifications.remove (an_argument)
				arguments_modifications.add (an_argument, new_argument_name)
			end
		ensure
			argument_modification_added: arguments_modifications.containsvalue (new_argument_name)
		end
		
invariant
	non_void_arguments_modifications: arguments_modifications /= Void
	
end -- class FEATURE_MODIFICATIONS
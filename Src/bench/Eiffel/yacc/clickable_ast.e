indexing

	description: 
		"An ast that has a position and associated api class.";
	date: "$Date$";
	revision: "$Revision $"

class CLICKABLE_AST

feature -- Properties

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
		end;

	is_feature: BOOLEAN is
			-- Does the Current AST represent a feature?
		do
		end;

	is_precursor: BOOLEAN is
			-- Does the Current AST represent a Precursor construct?
		do
		end

feature -- Access

	valid_reference_class (reference_class: CLASS_C): BOOLEAN is
			-- Is `reference_class' valid?
			-- (By default, yes it is if it is not void)
		do
			Result := reference_class /= Void
		end

	associated_eiffel_class (reference_class: CLASS_C): CLASS_C is
			-- Associated eiffel class representating AST.
			-- `ref_class' cluster is used to resolve name conflict 
			-- arising from class renaming.
		require
			is_class_or_precursor: is_class or is_precursor;
			valid_ref_class: valid_reference_class (reference_class)
		do
		end;

    associated_feature_name: STRING is
			-- Associated feature name representing AST
		require
			is_feature: is_feature
		do
		ensure
			non_void_result: Result /= Void
		end;

end -- class CLICKABLE_AST

indexing

	description: 
		"An ast that has a position and associated api class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	CLICKABLE_AST
	
inherit
	AST_EIFFEL
		undefine
			type_check, byte_node, number_of_breakpoint_slots
		end

feature -- Properties

	is_class: BOOLEAN is
			-- Does the Current AST represent a class?
		do
		end

	is_feature: BOOLEAN is
			-- Does the Current AST represent a feature?
		do
		end

	is_precursor: BOOLEAN is
			-- Does the Current AST represent a Precursor construct?
		do
		end

feature -- Access

	associated_eiffel_class (reference_class: CLASS_I): CLASS_I is
			-- Associated eiffel class representating AST.
			-- `reference_class' cluster is used to resolve name conflict 
			-- arising from class renaming.
		require
			is_class_or_precursor: is_class or is_precursor
			reference_class_not_void: reference_class /= Void
		do
		end

    associated_feature_name: STRING is
			-- Associated feature name representing AST
		require
			is_feature: is_feature
		do
		ensure
			non_void_result: Result /= Void
		end

end -- class CLICKABLE_AST

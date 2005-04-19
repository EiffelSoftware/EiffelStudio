indexing
	description: "An ast that has a position and associated api class."
	date: "$Date$"
	revision: "$Revision $"

deferred class
	CLICKABLE_AST
	
inherit
	AST_EIFFEL
		undefine
			number_of_breakpoint_slots
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

	feature_name: ID_AS is
			-- Associated `feature_name' if Current represents a feature
		require
			is_feature: is_feature
		do
		ensure
			feature_name_not_void: Result /= Void
		end

end -- class CLICKABLE_AST

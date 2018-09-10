note
	description: "[
		Base type of translation units that translate an aspect of a feature.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_TU_FEATURE

inherit

	E2B_TRANSLATION_UNIT

feature {NONE} -- Initialization

	make (a_feature: FEATURE_I; a_context_type: CL_TYPE_A)
			-- Initialize this translation unit with feature `a_feature' and context `a_context_type'.
		do
			feat := a_feature
			type := a_context_type
			id := base_id + "/" + type_id (a_context_type) + "/" + feature_id (a_feature)
		end

feature -- Access

	base_id: STRING
			-- Base id for these types of translation units.
		deferred
		end

	id: STRING
			-- <Precursor>

	feat: FEATURE_I
			-- Feature to be translated.

	type: CL_TYPE_A
			-- Context type of feature to be translated.

end

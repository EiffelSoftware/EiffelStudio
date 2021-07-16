note
	description: "Base class for feature translators."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_FEATURE_TRANSLATOR

inherit

	E2B_SHARED_CONTEXT

	SHARED_WORKBENCH
		export {NONE} all end

	SHARED_SERVER
		export {NONE} all end

	SHARED_BYTE_CONTEXT
		export {NONE} all end

	SHARED_NAMES_HEAP

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

feature -- Access

	current_feature: FEATURE_I
			-- Currently translated feature.

	current_type: CL_TYPE_A
			-- Context type of the currently translated feature.	

feature -- Element change

	set_context (a_feature: FEATURE_I; a_type: CL_TYPE_A)
			-- Set context of current translation.
		do
			current_feature := a_feature
			current_type := if a_type.is_attached then a_type else a_type.as_attached_type end
		ensure
			current_feature_set: current_feature = a_feature
			current_type_set: current_type.same_as (if a_type.is_attached then a_type else a_type.as_attached_type end)
		end

end

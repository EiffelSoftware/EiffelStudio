indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEFINITION_SEARCH_RESULT_FEATURE
	
inherit	
	DEFINITION_SEARCH_RESULT
		rename 
			make as make_class_result,
			create_item as create_result_item,
			ccom_create_item as ccom_create_result_item
		export
			{NONE} make_class_result, ccom_create_result_item, create_result_item
		select
			class_descriptor,
			module_name,
			namespace			
		end

	IEIFFEL_DEFINITION_FEATURE_RESULT_IMPL_STUB
		rename
			class_descriptor as class_descriptor_result,
			module_name as module_name_result,
			namespace as namespace_result
		export
			{NONE} namespace_result, module_name_result, class_descriptor_result
		redefine
			feature_descriptor
		select
			create_item
		end

create 
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_I; a_feature: like feature_i) is
			-- create instance using `feature_i' and `class_i'
		require
			non_void_class: a_class /= Void
			non_void_feature: a_feature /= Void
		do
			make_class_result (a_class)
			feature_i := a_feature
			create {FEATURE_DESCRIPTOR} feature_descriptor.make_with_class_i_and_feature_i (a_class, a_feature)
		end

feature -- Access

	feature_descriptor: FEATURE_DESCRIPTOR
			-- feature where definition was located
		
	feature_i: FEATURE_I
			-- feature corresponding to located definition

invariant
	non_void_feature_descriptor: feature_descriptor /= Void
	non_void_feature_i: feature_i /= Void

end -- class DEFINITION_SEARCH_RESULT_FEATURE

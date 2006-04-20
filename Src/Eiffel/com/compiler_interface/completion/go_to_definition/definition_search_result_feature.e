indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class DEFINITION_SEARCH_RESULT_FEATURE

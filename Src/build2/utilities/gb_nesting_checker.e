indexing
	description: "Objects that check the nesting structures within EiffelBuild"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NESTING_CHECKER

create
	make_with_components

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		require
			a_components_not_void: a_components /= Void
		do
			components := a_components
			default_create
		ensure
			components_set: components = a_components
		end

feature -- Access

	check_nesting is
			-- Check nesting of all top level objects within the current project
			-- to ensure that they are consistent and not corrupted. Simply
			-- checks types and structure, not the properties.
		local
			top_objects: ARRAYED_LIST [GB_OBJECT]
		do
			top_objects := components.tools.widget_selector.objects
			from
				top_objects.start
			until
				top_objects.off
			loop
				check_object (top_objects.item)
				top_objects.forth
			end
		end

	check_object (an_object: GB_OBJECT) is
			--
		require
			an_object_is_top_level: an_object.is_top_level_object
		local
			all_children: ARRAYED_LIST [GB_OBJECT]
			all_instance_children: ARRAYED_LIST [GB_OBJECT]
			instance_object: GB_OBJECT
		do
			create all_children.make (20)
			an_object.all_children_recursive (all_children)
			all_children.extend (an_object)
			from
				an_object.instance_referers.start
			until
				an_object.instance_referers.off
			loop
				instance_object := components.object_handler.deep_object_from_id (an_object.instance_referers.item_for_iteration)
				create all_instance_children.make (20)
				instance_object.all_children_recursive (all_instance_children)
				all_instance_children.extend (instance_object)
				check
					all_children.count = all_instance_children.count
				end
				from
					all_children.start
					all_instance_children.start
				until
					all_children.off
				loop
					check
						types_correct: all_children.item.type.is_equal (all_instance_children.item.type)
					end
					all_instance_children.forth
					all_children.forth
				end
				an_object.instance_referers.forth
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_NESTING_CHECKER

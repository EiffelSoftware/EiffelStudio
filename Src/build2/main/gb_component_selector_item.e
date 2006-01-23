indexing
	description: "Objects that represent a user defined component."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_SELECTOR_ITEM

inherit

	GB_XML_OBJECT_BUILDER
		undefine
			default_create, copy
		end

	EV_LIST_ITEM

create
	make_from_object,
	make_with_name

feature {NONE} -- Initialization

	components: GB_INTERNAL_COMPONENTS
		-- Access to a set of internal components for an EiffelBuild instance.

	make_from_object (an_object: GB_OBJECT; a_name: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' from `an_object' and assign `a_components' to `components'.
		require
			an_object_not_void: an_object /= Void
			a_name_not_void_or_empty: a_name /= Void or not a_name.is_empty
			a_components_not_void: a_components /= Void
		do
			components.xml_handler.add_new_component (an_object, a_name)
			make_with_name (a_name, components)
		ensure
			components_set: components = a_components
		end

	make_with_name (a_name: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create a new component representation from `a_name'.
		require
			a_name_not_void_or_empty: a_name /= Void or not a_name.is_empty
			a_components_not_void: a_components /= Void
		local
			component: GB_COMPONENT
			pixmaps: GB_SHARED_PIXMAPS
		do
			components := a_components
			make_with_text (a_name)
			set_pebble_function (agent generate_pebble)
			create component.make_with_name (a_name, components)
			create pixmaps
			set_pixmap (pixmaps.pixmap_by_name (component.root_element_type.as_lower))
		ensure
			components_set: components = a_components
		end

feature {NONE} -- Implementation

	generate_pebble: GB_COMPONENT_OBJECT_STONE is
			-- `Result' is used for a pick and drop.
		local
			component: GB_COMPONENT
		do
			if application.ctrl_pressed then
				create component.make_with_name (text, components)
				components.tools.component_viewer.set_component (component)
					-- We don't call execute on the component viewer command
					-- as this toggles between states, and we do not want the
					-- viewer hidden
				if not components.tools.component_viewer.is_show_requested then
					components.commands.show_hide_component_viewer_command.execute
				end
			else
				create Result.make_with_component (create {GB_COMPONENT}.make_with_name (text, components))
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


end -- class GB_COMPONENT

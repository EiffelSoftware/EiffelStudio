indexing
	description: "Objects that represent stones carrying a GB_OBJECT representing a component."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMPONENT_OBJECT_STONE
	
inherit
	GB_OBJECT_STONE
		redefine
			object
		end

create
	make_with_component
	
feature {NONE} -- Initialization

	make_with_component (a_component: GB_COMPONENT) is
			-- Create `Curent' and assign `a_component' to `component'.
		require
			a_component_not_void: a_component /= Void
		do
			component ?= a_component
				-- As this represents a component, there are no nested dependencies.
			create all_contained_instances.make (10)
		ensure
			component_set: component = a_component
		end

feature -- Access

	object: GB_OBJECT is
			-- Object which `Current' is representing.
			-- Warning this builds new objects, so do not call
			-- from a veto pebble function, only on the drop.
		do
			Result := component.object
		end
		
	object_type: STRING is
			-- EiffelVision2 Type of object represented.
		do
			Result := component.root_element_type
		end
		
	component: GB_COMPONENT;
		-- Component represented by `Current'.

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


end -- class GB_STANDARD_OBJECT_STONE

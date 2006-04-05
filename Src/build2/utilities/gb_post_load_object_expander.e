indexing
	description: "Objects that permit expansion of layout items on objects after loading."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_POST_LOAD_OBJECT_EXPANDER

feature {GB_XML_LOAD}-- Status setting

	register_object_as_expanded (an_object: GB_OBJECT) is
			-- Add `an_object' to `expanded_objects'.
		require
			an_object_not_void: an_object /= Void
			not_already_marked: not Expanded_objects.has (an_object)
		do
			expanded_objects.extend (an_object)
		ensure
			registered: expanded_objects.has (an_object)
		end
		
feature {GB_XML_LOAD}-- Basic operations

	expand_all_registered_objects is
			-- Expand all relevent representations of all objects in
			-- `expanded_objects', and leave `expanded_objects' empty.
		local
			layout_item: GB_LAYOUT_CONSTRUCTOR_ITEM
		do
			from
				expanded_objects.start
			until
				expanded_objects.off
			loop
				layout_item := expanded_objects.item.layout_item
				if layout_item.is_expandable and layout_item.parent_tree /= Void then
					layout_item.expand	
				end
				expanded_objects.remove
			end
		ensure
			expanded_objects_empty: expanded_objects.is_empty
		end
		
feature {GB_XML_LOAD} -- Implementation

	expanded_objects: ARRAYED_LIST [GB_OBJECT] is
			-- `Result' is all objects marked as expanded.
		once
			create Result.make (0)
		end

invariant
	expanded_objects_not_void: expanded_objects /= Void

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


end -- class GB_POST_LOAD_OBJECT_EXPANDER

indexing
	description: "Figure representations of type selector items"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FIGURE_TYPE_SELECTOR_ITEM

inherit
	GB_TYPE_SELECTOR_ITEM
		export
			{NONE} all
		redefine
			item
		end

create
	make_with_text

feature {NONE} -- Initialization

	make_with_text (a_text: STRING; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current', assign `a_text' to `text'
			-- , "EV_" + `a_text' to `type' and `a_components' to `components'.
		local
			pixmaps: GB_SHARED_PIXMAPS
		do
			components := a_components
			type := a_text
			create pixmaps
			create item.make_with_pixmap (pixmaps.pixmap_by_name (type.as_lower))
			item.set_data (Current)
			item.pointer_motion_actions.force_extend (agent display_type)
			item.set_pebble_function (agent generate_transportable)
			item.drop_actions.extend (agent replace_layout_item (?))
			item.drop_actions.set_veto_pebble_function (agent can_drop_object)
		end

feature -- Access

	item: FIGURE_PICTURE_WITH_DATA
		-- Graphical representation of `Current' used in the type selector.

feature {NONE} -- Implementation

	process_number_key is
			-- Begin processing by `digit_checker', so that
			-- it can be determined if a digit key is held down.
		do
			components.digit_checker.begin_processing (components.tools.type_selector.drawing_area)
		end

	display_type is
			-- Display type of `Current' on status bar.
		do
			components.status_bar.set_timed_status_text (type)
		end

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


end -- class GB_FIGURE_TYPE_SELECTOR_ITEM

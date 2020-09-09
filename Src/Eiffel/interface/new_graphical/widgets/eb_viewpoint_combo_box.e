note
	description: "Combo box used to select viewpoints"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VIEWPOINT_COMBO_BOX

inherit
	CLASS_VIEWPOINTS
		undefine
			default_create,
			is_equal,
			copy
		redefine
			calculate_viewpoints,
			current_viewpoint
		end

	EV_COMBO_BOX

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	default_create,
	make_class,
	make_group

feature -- Access

	current_viewpoint: detachable CONF_GROUP
			-- Current viewpoint
		do
			if
				attached selected_item as l_item and then
				attached {CONF_GROUP} l_item.data as g
			then
				Result := g
			end
		end

feature {NONE} -- Implementation

	calculate_viewpoints
			-- Calculate all viewpoints for `conf_group'
			-- Refresh combo list
		local
			l_group: CONF_GROUP
			l_item: EV_LIST_ITEM
		do
			Precursor {CLASS_VIEWPOINTS}
			wipe_out
			select_actions.block
			from
				view_points.start
			until
				view_points.after
			loop
				l_group := view_points.item
				create l_item.make_with_text (l_group.name)
				l_item.set_pixmap (pixmap_from_group (l_group))
				l_item.set_tooltip (l_group.name)
				l_item.set_data (l_group)
				extend (l_item)
				view_points.forth
			end
			select_actions.resume
			if not has_renamed_view_point then
				disable_sensitive
			else
				enable_sensitive
			end
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

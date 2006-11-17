indexing
	description: "Grid item that represents a local"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_LOCAL_ITEM

inherit
	EB_GRID_COMPILER_ITEM

	EB_CONSTANTS
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make,
	make_with_type

feature {NONE} -- Initialization

	make (a_name: STRING; a_style: EB_GRID_LOCAL_ITEM_STYLE) is
			-- Initialization
		require
			a_name_not_void: a_name /= Void
			a_style_not_void: a_style /= Void
		do
			default_create
			name := a_name
			set_spacing (layout_constants.Tiny_padding_size)
--			set_style (a_style)
		end

	make_with_type (a_name: STRING; a_type: TYPE_A; a_feature: FEATURE_I; a_style: EB_GRID_LOCAL_ITEM_STYLE) is
			-- Initialization
		require
			a_name_not_void: a_name /= Void
			a_type_not_void: a_type /= Void
			a_style_not_void: a_style /= Void
		do
			type := a_type
			feature_i := a_feature
			make (a_name, a_style)
		end

feature -- Access

	name: STRING
			-- Name of the local.

	type: TYPE_A
			-- Type of the local.

	feature_i: FEATURE_I
			-- Feature to print `type'

	item_pixmap: EV_PIXMAP is
			-- Pixmap associated to current compiler item
		do
			Result := pixmaps.icon_pixmaps.feature_local_variable_icon
		end

invariant
	invariant_clause: True -- Your invariant here

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

end

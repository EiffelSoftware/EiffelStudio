indexing
	description: "Object that represents a class in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_CLASS_ITEM

inherit
	EB_GRID_COMPILER_ITEM
		redefine
			general_tooltip,
			style
		end

	EB_CONSTANTS
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_class: like associated_class; a_style: like style) is
			-- Initialize `associated_class' with `a_class'.
			-- Display `associated_class' with `a_style'.
		require
			a_class_not_void: a_class /= Void
			a_style_attached: a_style /= Void
		do
			default_create
			associated_class := a_class
			set_spacing (3)
			set_style (a_style)
		ensure
			associated_class_set: associated_class = a_class
		end

feature -- Access

	associated_class: CLASS_C
			-- Compiled class associated with current item

	general_tooltip: EB_EDITOR_TOKEN_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided can not satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.	

	style: EB_GRID_CLASS_ITEM_STYLE
			-- Style of current item

feature -- Status report

	is_invisible_pixmap_enabled: BOOLEAN
			-- Is invisible pixmap enabled?

feature -- Setting

	enable_invisible_pixmap is
			-- Ensure `is_invisible_pixmap_enabled' is True.
		do
			is_invisible_pixmap_enabled := True
			if is_pixmap_enabled then
				set_pixmap (item_pixmap)
			end
		ensure
			is_invisible_pixmap_enabled_set: is_invisible_pixmap_enabled
		end

	disable_invisible_pixmap is
			-- Ensure `is_invisible_pixmap_enabled' is False.
		do
			is_invisible_pixmap_enabled := False
			if is_pixmap_enabled then
				set_pixmap (item_pixmap)
			end
		ensure
			is_invisible_pixmap_enabled_set: not is_invisible_pixmap_enabled
		end

feature{NONE} -- Pixmap

	item_pixmap: EV_PIXMAP is
			-- Pixmap associated to current compiler item
		do
			if not is_invisible_pixmap_enabled then
				Result := pixmap_from_class_i (associated_class.lace_class)
			else
				Result := pixmaps.icon_invisible_icon
			end
		end

	internal_replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		do
		end

invariant
	associated_class_not_void: associated_class /= Void

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

indexing
	description: "Object that represents a class in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GRID_CLASS_ITEM

inherit
	EB_GRID_COMPILER_ITEM
		redefine
			general_tooltip
		end

	EB_CONSTANTS
		undefine
			copy,
			is_equal,
			default_create
		end

feature -- Access

	associated_class_i: CLASS_I is
			-- CLASS_I associated with current item
		deferred
		ensure
			result_attached: Result /= Void
		end

	general_tooltip: EB_EDITOR_TOKEN_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.	

feature{NONE} -- Pixmap

	item_pixmap: EV_PIXMAP is
			-- Pixmap associated to current compiler item
		do
--			if not is_invisible_pixmap_enabled then
--				Result := pixmap_from_class_i (associated_class_i)
--			else
--				Result := pixmaps.icon_pixmaps.general_blank_icon
--			end
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
end

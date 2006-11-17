indexing
	description: "Object that represents a searchable, tooltipable, pick-and-dropable item in EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_COMPILER_ITEM

inherit
	EB_GRID_EDITOR_TOKEN_ITEM

	EB_SHARED_MANAGERS
		undefine
			copy,
			is_equal,
			default_create
		end

	EVS_GRID_SEARCHABLE_ITEM
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
		undefine
			copy,
			is_equal,
			default_create
		end

	EVS_GENERAL_TOOLTIP_UTILITY
		undefine
			copy,
			is_equal,
			default_create
		end

feature -- Setting

	enable_pixmap is
			-- Enable pixmap display.
		do
		ensure
		end

	disable_pixmap is
			-- Disable pixmap display.
		do
		ensure
		end

	set_general_tooltip (a_tooltip: like general_tooltip) is
			-- Set `general_tooltip' with `a_tooltip' and enable it at the same time.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := a_tooltip
			general_tooltip.enable_tooltip
		ensure
			general_tooltip_set: general_tooltip = a_tooltip
		end

	remove_general_tooltip is
			-- Remove `general_tooltip'.
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := Void
		ensure
			general_tooltip_removed: general_tooltip = Void
		end

	set_tooltip_display_function (a_function: like tooltip_display_function) is
			-- Set `tooltip_display_function' with `a_function'.
		do
			tooltip_display_function := a_function
		ensure
			tooltip_display_function_set: tooltip_display_function = a_function
		end

feature -- Setting

	set_image (a_image: like image) is
			-- Set `image' with `a_image'.
		require
			a_image_attached: a_image /= Void
		do
			create image_internal.make_from_string (a_image)
		ensure
			image_set: image /= Void and then image.is_equal (a_image)
		end

feature -- Status report

	should_tooltip_be_displayed: BOOLEAN is
			-- Should tooltip be displayed?
		do
			if tooltip_display_function /= Void then
				Result := tooltip_display_function.item ([])
			end
		end

feature -- Access

	general_tooltip: EVS_GENERAL_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.

feature -- Searchable

	image: STRING is
			-- Image of current used in search
		do
			Result := image_internal
			if Result = Void then
				Result := ""
			end
		end

feature{NONE} -- Implementation

	tooltip_display_function: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Funtion which decides whether or not tooltip should be displayed

	image_internal: like image
			-- Implementation of `image'

	internal_replace (original, new: STRING) is
			-- Replace every occurrence of `original' with `new' in `image'.
		do
		end

	grid_item: EV_GRID_ITEM is
			-- EV_GRID item associated with current
		do
			Result := Current
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

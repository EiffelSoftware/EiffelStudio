indexing
	description: "[
		A utility widget wrapper to create a widget with a standard border.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_BORDERED_WIDGET [G -> EV_WIDGET]

inherit
	ES_WIDGET [EV_HORIZONTAL_BOX]
		rename
			make as make_widget,
			widget as border_widget,
			create_widget as create_border_widget
		end

create
	make

convert
	border_widget: {EV_WIDGET}

feature {NONE} -- Initialization

	make (a_widget: !G)
			-- Initializes a bordered widget with a existing widget.
			--
			-- `a_widget': The widget to surround with a border
		require
			not_a_widget_is_destroyed: not a_widget.is_destroyed
			not_a_widget_is_parented: not a_widget.has_parent
		do
			widget := a_widget
			make_widget
		ensure
			widget_set: widget = a_widget
			is_initialized: is_initialized
			is_initializing_unchanged: old is_initializing = is_initializing
		end

feature {NONE} -- User interface initialization

	build_widget_interface (a_widget: !EV_HORIZONTAL_BOX)
			-- <Precursor>
		do
			a_widget.set_border_width (border_width)
			a_widget.set_background_color (border_color)
			a_widget.extend (widget)
		end

feature {NONE} -- Access

	border_width: NATURAL_8
			-- Width of widget border.
		require
			is_interface_usable: is_interface_usable
			is_initializing_or_initialized: is_initializing or is_initialized
		do
			Result := 1
		ensure
			result_positive: Result > 0
		end

	border_color: !EV_COLOR
			-- Color of the widget border.
		require
			is_interface_usable: is_interface_usable
			is_initializing_or_initialized: is_initializing or is_initialized
		do
			Result ?= colors.stock_colors.color_3d_shadow
		end

feature -- User interface elements

	widget: !G
			-- Actual widget

feature {NONE} -- Factory

	create_border_widget: !EV_HORIZONTAL_BOX
			-- <Precursor>
		do
			create Result
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

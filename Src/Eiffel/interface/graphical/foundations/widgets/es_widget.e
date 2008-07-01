indexing
	description: "[
		A base widget implementation for all custom/composite widgets used in EiffelStudio.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_WIDGET [G -> EV_WIDGET]

inherit
	ES_TOOL_FOUNDATIONS
		rename
			foundation_widget as widget
		redefine
			internal_recycle
		end

convert
	widget: {EV_WIDGET, !G}

feature {NONE} -- User interface initialization

	frozen build_interface
			-- Builds the foundataion tool's user interface.
		do
			widget := create_widget
			build_widget_interface (widget)
		end

	build_widget_interface (a_widget: !G)
			-- Builds widget's interface.
			--
			-- `a_widget': The widget to initialize of build upon.
		require
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
			not_a_widget_has_parent: not a_widget.has_parent
			not_a_widget_is_destroyed: not a_widget.is_destroyed
		deferred
		ensure
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			if is_initialized then
				widget.destroy
			end
			Precursor {ES_TOOL_FOUNDATIONS}
		ensure then
			widget_is_destroyed: (old widget) /= Void implies (old widget).is_destroyed
		end

feature -- Access

	widget: !G
			-- Actual widget

feature {NONE} -- Access

	window: ?EV_WINDOW
			-- Acces to window containing widget
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			widget_has_parent: widget.has_parent
		do
			Result := helpers.widget_top_level_window (widget, False)
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.width
		ensure
			widget_width_reported: Result = widget.width
			positive_or_zero: Result >= 0
		end

	height: INTEGER
			-- Vertical size in pixels.
			-- Same as `minimum_height' when not displayed.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.height
		ensure
			widget_height_reported: Result = widget.height
			positive_or_zero: Result >= 0
		end

	minimum_width: INTEGER assign set_minimum_width
			-- Lower bound on `width' in pixels.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.minimum_width
		ensure
			widget_minimum_width_reported: Result = widget.minimum_width
			positive_or_zero: Result >= 0
		end

	minimum_height: INTEGER assign set_minimum_height
			-- Lower bound on `height' in pixels.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.minimum_height
		ensure
			widget_minimum_height_reported: Result = widget.minimum_height
			positive_or_zero: Result >= 0
		end

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.x_position
		ensure
			widget_x_position_reported: Result = widget.x_position
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.y_position
		ensure
			widget_y_position_reported: Result = widget.y_position
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.screen_x
		ensure
			widget_screen_x_reported: Result = widget.screen_x
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.screen_y
		ensure
			widget_screen_y_reported: Result = widget.screen_y
		end

feature -- Element change

	set_minimum_width (a_minimum_width: like minimum_width)
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
			-- From now, `minimum_width' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
			a_minimum_width_positive: a_minimum_width >= 0
		do
			widget.set_minimum_width (a_minimum_width)
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
		end

	set_minimum_height (a_minimum_height: like minimum_height)
			-- Set `a_minimum_height' in pixels to `minimum_height'.
			-- If `height' is less than `a_minimum_height', resize.
			-- From now, `minimum_height' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			is_interface_usable: is_interface_usable
			a_minimum_height_positive: a_minimum_height >= 0
		do
			widget.set_minimum_height (a_minimum_height)
		ensure
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
		end

	set_minimum_size (a_minimum_width: like minimum_width; a_minimum_height: like minimum_height)
			-- Assign `a_minimum_height' to `minimum_height'
			-- and `a_minimum_width' to `minimum_width' in pixels.
			-- If `width' or `height' is less than minimum size, resize.
			-- From now, minimum size is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			is_interface_usable: is_interface_usable
			a_minimum_width_positive: a_minimum_width >= 0
			a_minimum_height_positive: a_minimum_height >= 0
		do
			widget.set_minimum_size (a_minimum_width, a_minimum_height)
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
		end

feature -- Status report

	is_sensitive: BOOLEAN assign set_is_senstive
			-- Is widget sensitive to user input.
		require
			is_interface_usable: is_interface_usable
		do
			Result := widget.is_sensitive
		ensure
			widget_is_sensitive_reported: Result = widget.is_sensitive
		end

feature -- Status setting

	set_is_senstive (a_sensitive: like is_sensitive)
			-- Make object sensitive to user input base of state argument.
			--
			-- `a_sensitive': True to ensure the widget is sensitive; False otherwise.
		require
			is_interface_usable: is_interface_usable
		do
			if a_sensitive then
				widget.enable_sensitive
			else
				widget.disable_sensitive
			end
		ensure
			widget_sensitivity_set: a_sensitive = widget.is_sensitive
		end

feature {NONE} -- Factory

	create_widget: !G
			-- Creates a new widget, which will be initialized when `build_interface' is called.
		require
			is_interface_usable: is_interface_usable
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			not_result_is_destroyed: not Result.is_destroyed
			not_result_has_parent: not Result.has_parent
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

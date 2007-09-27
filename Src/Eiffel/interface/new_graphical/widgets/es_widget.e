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
	EB_RECYCLABLE

-- inherit {NONE}

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	SHARED_SERVICE_PROVIDER
		export
			{NONE} all
		end

convert
	widget: {G}

feature {NONE} -- Initialization

	build_widget_interface (a_widget: G)
			-- Builds widget's interface.
		require
			not_is_recycled: not is_recycled
			a_widget_attached: a_widget /= Void
			not_a_widget_has_parent: not a_widget.has_parent
			not_a_widget_is_destroyed: not a_widget.is_destroyed
			is_initializing: is_initializing
		deferred
		ensure
			is_initializing: is_initializing
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- To be called when the button has became useless.
		do
			if is_initialized then
				internal_widget.destroy
				internal_widget := Void
			end
		ensure then
			internal_widget_detached: internal_widget = Void
			not_is_initialized: not is_initialized
		end

feature -- Access

	widget: G
			-- Actual widget
		require
			not_is_recycled: not is_recycled
		do
			Result := internal_widget
			if Result = Void then
				is_initializing := True

				Result := create_widget
				internal_widget := Result
				build_widget_interface (Result)

				is_initializing := False
				is_initialized := True
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = Result
			is_initializing_or_is_initialized: is_initializing or is_initialized
		end

feature {NONE} -- Access

	window: EV_WINDOW
			-- Acces to window containing widget
		require
			not_is_recycled: not is_recycled
			widget_has_parent: widget.has_parent
		do
			Result := helpers.widget_top_level_window (widget, False)
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
		end

	development_window: EB_DEVELOPMENT_WINDOW
			-- Access to top-level parent window
		require
			not_is_recycled: not is_recycled
			widget_has_parent: widget.has_parent
		local
			l_window: EV_WINDOW
			l_windows: BILINEAR [EB_WINDOW]
		do
			l_window := helpers.widget_top_level_window (widget, True)
			if l_window /= Void then
				l_windows := (create {EB_SHARED_WINDOW_MANAGER}).window_manager.windows
				from l_windows.start until l_windows.after or Result /= Void loop
					if l_window = l_windows.item.window then
						Result ?= l_windows.item
					end
					l_windows.forth
				end
			end
		ensure
			not_result_is_recycled: Result /= Void implies not Result.is_recycled
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
			-- Same as `minimum_width' when not displayed.
		require
			not_is_recycled: not is_recycled
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
			not_is_recycled: not is_recycled
		do
			Result := widget.height
		ensure
			widget_height_reported: Result = widget.height
			positive_or_zero: Result >= 0
		end

	minimum_width: INTEGER assign set_minimum_width
			-- Lower bound on `width' in pixels.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.minimum_width
		ensure
			widget_minimum_width_reported: Result = widget.minimum_width
			positive_or_zero: Result >= 0
		end

	minimum_height: INTEGER assign set_minimum_height
			-- Lower bound on `height' in pixels.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.minimum_height
		ensure
			widget_minimum_height_reported: Result = widget.minimum_height
			positive_or_zero: Result >= 0
		end

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.x_position
		ensure
			widget_x_position_reported: Result = widget.x_position
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.y_position
		ensure
			widget_y_position_reported: Result = widget.y_position
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.screen_x
		ensure
			widget_screen_x_reported: Result = widget.screen_x
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.screen_y
		ensure
			widget_screen_y_reported: Result = widget.screen_y
		end

feature -- Element change

	set_minimum_width (a_minimum_width: like minimum_width) is
			-- Assign `a_minimum_width' in pixels to `minimum_width'.
			-- If `width' is less than `a_minimum_width', resize.
			-- From now, `minimum_width' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_is_recycled: not is_recycled
			a_minimum_width_positive: a_minimum_width >= 0
		do
			widget.set_minimum_width (a_minimum_width)
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
		end

	set_minimum_height (a_minimum_height: like minimum_height) is
			-- Set `a_minimum_height' in pixels to `minimum_height'.
			-- If `height' is less than `a_minimum_height', resize.
			-- From now, `minimum_height' is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_is_recycled: not is_recycled
			a_minimum_height_positive: a_minimum_height >= 0
		do
			widget.set_minimum_height (a_minimum_height)
		ensure
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
		end

	set_minimum_size (a_minimum_width: like minimum_width; a_minimum_height: like minimum_height) is
			-- Assign `a_minimum_height' to `minimum_height'
			-- and `a_minimum_width' to `minimum_width' in pixels.
			-- If `width' or `height' is less than minimum size, resize.
			-- From now, minimum size is fixed and will not be changed
			-- dynamically by the application anymore.
		require
			not_is_recycled: not is_recycled
			a_minimum_width_positive: a_minimum_width >= 0
			a_minimum_height_positive: a_minimum_height >= 0
		do
			widget.set_minimum_size (a_minimum_width, a_minimum_height)
		ensure
			minimum_width_assigned: (a_minimum_width > 0 implies minimum_width = a_minimum_width) or (a_minimum_width = 0 implies (minimum_width <= 1))
			minimum_height_assigned: (a_minimum_height > 0 implies minimum_height = a_minimum_height) or (a_minimum_height = 0 implies (minimum_height <= 1))
		end

feature {NONE} -- Helpers

	frozen interface_names: INTERFACE_NAMES
			-- Access to EiffelStudio's interface names
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen stock_pixmaps: ES_PIXMAPS_16X16
			-- Shared access to stock 16x16 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen stock_mini_pixmaps: ES_PIXMAPS_10X10
			-- Shared access to stock 10x10 EiffelStudio pixmaps
		once
			Result := (create {EB_SHARED_PIXMAPS}).mini_pixmaps
		ensure
			result_attached: Result /= Void
		end

	frozen cursor_factory: EVS_CURSOR_FACTORY
			-- Shared access to cursor factory for generating stone cursors from an icon
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen preferences: EB_PREFERENCES
		require
			preferences_initialized: (create {EB_SHARED_PREFERENCES}).preferences_initialized
		once
			Result := (create {EB_SHARED_PREFERENCES}).preferences
		ensure
			result_attached: Result /= Void
		end

	frozen pixmap_factory: EB_PIXMAPABLE_ITEM_PIXMAP_FACTORY
			-- Factory for generating pixmaps for class data
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

	frozen helpers: EVS_HELPERS
			-- Helpers to extend the operations of EiffelVision2
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Status report

	is_sensitive: BOOLEAN
			-- Is widget sensitive to user input.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.is_sensitive
		ensure
			widget_is_sensitive_reported: Result = widget.is_sensitive
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.is_show_requested
		ensure
			widget_is_show_requested_reported: Result = widget.is_show_requested
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- `True' when show requested and parent displayed.
		require
			not_is_recycled: not is_recycled
		do
			Result := widget.is_displayed
		ensure
			widget_is_displayed_reported: Result = widget.is_displayed
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indicates if the user interface has been initialized

	is_initializing: BOOLEAN
			-- Indicates if the user interface is currently being initialized

feature -- Status setting

	enable_sensitive
			-- Make object sensitive to user input.
		require
			not_is_recycled: not is_recycled
		do
			widget.enable_sensitive
		ensure
			widget_sensitivity_enabled: widget.is_sensitive
		end

	disable_sensitive
			-- Make object non-sensitive to user input.
		require
			not_is_recycled: not is_recycled
		do
			widget.disable_sensitive
		ensure
			widget_sensitivity_disabled: not widget.is_sensitive
		end

feature {NONE} -- Factory

	create_widget: G
			-- Creates a new wrapped widget
		require
			not_is_recycled: not is_recycled
			internal_widget_unattached: internal_widget = Void
			not_is_initialized: not is_initialized
			is_initializing: is_initializing
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
			not_result_has_parent: not Result.has_parent
		end

feature {NONE} -- Internal implementation cache

	internal_widget: like widget
			-- Cached version of `widget'
			-- Note: Do not use directly!

invariant
	internal_widget_attached: is_initialized implies internal_widget /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

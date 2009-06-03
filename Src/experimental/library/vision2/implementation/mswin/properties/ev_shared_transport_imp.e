note
	description: "Objects that hold shared information required for transports."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SHARED_TRANSPORT_IMP

inherit
	ANY

	WEL_SYSTEM_METRICS
		export
			{NONE} all
		end

feature -- Access

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- `Result' is implementation of widget at current
			-- pointer position or Void if none.
		local
			wel_point: WEL_POINT
			wel_window_at_cursor_position: WEL_WINDOW
			combo_field: EV_INTERNAL_COMBO_FIELD_IMP
		do
				--|FIXME make sure pick and drop uses this code.
			create wel_point.make (0, 0)
			wel_point.set_cursor_position
			wel_window_at_cursor_position := wel_point.window_at
				-- Retrieve WEL_WINDOW at cursor position
			if wel_window_at_cursor_position /= Void then
					-- If the cursor is currently over a WEL_WINDOW
				Result ?= wel_window_at_cursor_position
				if Result = Void then
					-- We must now check for an internal combo field, and
					-- use its parent as the widget.
					combo_field ?= wel_window_at_cursor_position
					if combo_field /= Void then
						Result := combo_field.parent
					end
				end
			end
		end

	awaiting_movement: BOOLEAN
		-- Are we currently awaiting the movement threshold to
		-- be reached for as drag and drop or dockable move?

	drag_and_drop_starting_movement: INTEGER = 3
		-- Pointer movement in pixels required to start a drag and drop.

	original_x, original_y: INTEGER
	original_x_tilt, original_y_tilt, original_pressure: DOUBLE
		-- Hold the values passed to start transport so when a transport
		-- actually starts, with real_start_transport,these can be passed
		-- as arguments.

feature {NONE} -- Implementation

	internal_set_pointer_style (a_new_cursor: EV_POINTER_STYLE)
			-- Set pointer style implementation.
		local
			l_wel_cursor: WEL_CURSOR
			l_pointer_style_imp: EV_POINTER_STYLE_IMP
			l_widget: EV_WIDGET_IMP
		do
				-- We do a global setting. This means that if the widget
				-- where the cursor is has a different cursor than
				-- `new_cursor' it will flash, but this is better than to
				-- wait until the on_set_cursor event (WM_SETCURSOR) is
				-- called to change the shape of the cursor.
			cursor_pixmap := a_new_cursor
			l_pointer_style_imp ?= a_new_cursor.implementation
			check not_void: l_pointer_style_imp /= Void end

			l_wel_cursor := l_pointer_style_imp.wel_cursor
			l_wel_cursor.increment_reference

			if current_wel_cursor /= Void then
				current_wel_cursor.decrement_reference
				current_wel_cursor := Void
			end
			current_wel_cursor := l_wel_cursor
			l_widget ?= Current
				-- Sometime the widget does not exist anymore. It is the case when
				-- the implementation of a dialog was changed from a modal back to a normal
				-- window.
			if l_widget /= Void and then l_widget.exists then
				if l_widget.is_displayed then
						-- When the current widget is not yet displayed then
						-- there is no need to change the cursor and thus
						-- avoiding the flashing described above.
					l_wel_cursor.set
				end
			else
					-- If Current is not a EV_WIDGET then we must be in the case of
					-- a Pick and drop thus it is safe to force the update of the cursor
					-- as the parent widget should be visible.
				l_wel_cursor.set
			end
		end

	current_wel_cursor: WEL_CURSOR
			-- Current cursor set, Void if none.

	Default_pixmaps: EV_STOCK_PIXMAPS
			-- Default pixmaps
		deferred
		end

	pnd_screen: EV_SCREEN
		-- Screen used for retrieving current pointer position,
		-- and drawing if transport type necessitates this.

feature {EV_ANY_I, EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	cursor_pixmap: EV_POINTER_STYLE;
			-- Cursor used on the widget.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SHARED_TRANSPORT_IMP


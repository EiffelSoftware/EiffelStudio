indexing
	description: "Objects that hold shared information required for transports."
	status: "See notice at end of class"
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

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
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
		
	drag_and_drop_starting_movement: INTEGER is 3
		-- Pointer movement in pixels required to start a drag and drop.
		
	original_x, original_y: INTEGER
	original_x_tilt, original_y_tilt, original_pressure: DOUBLE
		-- Hold the values passed to start transport so when a transport
		-- actually starts, with real_start_transport,these can be passed
		-- as arguments.

feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

	internal_set_pointer_style (new_cursor: EV_CURSOR) is
			-- Assign `new_cursor' to cursor used on `Current'.
			-- Only called through implementation.
		local
			wel_cursor: WEL_CURSOR
			cursor_imp: EV_PIXMAP_IMP_STATE
		do
				-- We do a global setting. This means that if the widget
				-- where the cursor is has a different cursor than
				-- `new_cursor' it will flash, but this is better than to
				-- wait until the on_set_cursor event (WM_SETCURSOR) is
				-- called to change the shape of the cursor.
			cursor_pixmap := new_cursor
			cursor_imp ?= cursor_pixmap.implementation
			wel_cursor := cursor_imp.cursor
			if wel_cursor = Void then
				wel_cursor := cursor_imp.build_cursor
				wel_cursor.enable_reference_tracking
			else
				wel_cursor.increment_reference
			end
				-- The cursor has been just built from `cursor_imp'
				-- so we can use it's width and height to check they match
				-- the cursor size from WEL_SYSTEM_METRICS.
				--| If we are running on Windows 95 we need to check that
				--| the cursor size is valid.	 	
			check
				cursor_size_valid: (create {WEL_WINDOWS_VERSION}
					).is_windows_95
					implies (cursor_imp.width = cursor_width and
					cursor_imp.height = cursor_height)
			end
			
			if current_wel_cursor /= Void then
				current_wel_cursor.decrement_reference
				current_wel_cursor := Void
			end
			current_wel_cursor := wel_cursor
			wel_cursor.set
		end
		
	current_wel_cursor: WEL_CURSOR
			-- Current cursor set, Void if none.
			
	Default_pixmaps: EV_STOCK_PIXMAPS is
			-- Default pixmaps
		deferred
		end
		
	pnd_screen: EV_SCREEN
		-- Screen used for retrieving current pointer position,
		-- and drawing if transport type necessitates this.
			
feature {EV_ANY_I, EV_INTERNAL_COMBO_FIELD_IMP, EV_INTERNAL_COMBO_BOX_IMP} -- Implementation

	cursor_pixmap: EV_CURSOR
			-- Cursor used on the widget.
			
feature -- Public constants

	Capture_heavy: INTEGER is 1
			-- The mouse [has been/should be] captured through
			-- a call to `set_heavy_capture'

	Capture_normal: INTEGER is 0
			-- The mouse [has been/should be] captured through
			-- a call to `set_capture'
			--
			-- Default value.

end -- class EV_SHARED_TRANSPORT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


indexing
	description: "Objects that provide common attributes for transport mechanisms."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHARED_TRANSPORT_I

feature -- Access EV_PICK_AND_DROPABLE.
		
	over_valid_target: BOOLEAN
			-- Is the cursor over a target that accepts `pebble'?

	default_accept_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `accept_cursor'.
		once
			Result := Default_pixmaps.Standard_cursor
		end

	default_deny_cursor: EV_CURSOR is
			-- Used in lieu of a user defined `deny_cursor'.
		once
			Result := Default_pixmaps.No_cursor
		end
		
	rubber_band_is_drawn: BOOLEAN
			-- Is a rubber band line currently on the screen?
			
	global_pnd_targets: ARRAYED_LIST [INTEGER] is
			-- Shortcut to EV_APPLICATION.pnd_targets.
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result := env.application.implementation.pnd_targets
		end
		
	Default_pixmaps: EV_STOCK_PIXMAPS is
			-- Default pixmaps
		once
			create Result
		end

feature -- Access EV_DRAGABLE_SOURCE.
		
	source_being_docked: EV_DOCKABLE_SOURCE_IMP
		-- Dragable source currently being transported. May be a
		-- WIDGET_IMP or an EV_TOOL_BAR_BUTTON_IMP.
		
	originating_source: EV_DOCKABLE_SOURCE_IMP
		-- Dragable source that originated the transport of `source_being_dragged'.
		
	original_x_offset, original_y_offset: INTEGER
		-- Original x_offset and original_y_offset of transport
		-- realtive to widget. Only used for dragable transports.
	
	global_drag_targets: ARRAYED_LIST [INTEGER] is
			-- Shortcut to EV_APPLICATION.pnd_targets.
		local
			env: EV_ENVIRONMENT
		once
			create env
			Result := env.application.implementation.dockable_targets
		end
		
	insert_label: EV_CELL is
				-- Label used to indicate where `Current' will be placed in target.
			local
				pixmap: EV_PIXMAP
			once
				Create Result
				Result.set_minimum_size (10, 10)
				create pixmap
				pixmap.set_size (2, 2)
				pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).default_background_color)
				pixmap.draw_point (0, 0)
				pixmap.draw_point (1, 1)
				pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).black)
				pixmap.draw_point (0, 1)
				pixmap.draw_point (1, 0)
				Result.set_background_pixmap (pixmap)
			ensure
				result_not_void: Result /= Void
			end
			
	insert_label_imp: EV_CELL_IMP is
			-- Once access to implementation of `insert_label'.
		once
			Result ?= insert_label.implementation
		ensure
			Result /= Void
		end
		
	remove_insert_label is
				-- Remove `insert_label' from its current `parent'.
			do
				if insert_label.parent /= Void then
					insert_label.parent.prune (insert_label)
				end
			ensure
				not_parented: insert_label.parent = Void
			end
		
	insert_sep: EV_TOOL_BAR_SEPARATOR is
			-- Once access to a separator used to indicate the insertion position
			-- when moving tool bar items.
		once
			Create Result
		end
		
	insert_sep_imp: EV_TOOL_BAR_SEPARATOR_IMP is
			-- Once access to implementation of `insert_sep'.
		once
			Result ?= insert_sep.implementation
		ensure
			Result /= Void
		end
		
	remove_insert_sep is
			-- Ensure `inset_sep' is not parented.
		do
			if insert_sep.parent /= Void then
				insert_sep.parent.prune (insert_sep)
			end
		ensure
			not_parented: insert_sep.parent = Void
		end
		
			
	dockable_dialog_target: EV_DOCKABLE_DIALOG
		-- A dockable dialog that will be created as 
	 	-- necessary. This is not a local, to avoid it
	 	-- being garbage collected.
	 	
	 internal_screen: EV_SCREEN is
	 		-- Once access to an EV_SCREEN.
	 	once
	 		create Result
	 	end

feature -- Access common.

		pointer_x, pointer_y: INTEGER

end -- class EV_SHARED_TRANSPORT_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

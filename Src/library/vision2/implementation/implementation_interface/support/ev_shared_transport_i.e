indexing
	description: "Objects that provide common attributes for transport mechanisms."
	author: ""
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
		
	source_being_dragged: EV_DOCKABLE_SOURCE_IMP--WIDGET_IMP
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
			Result := env.application.implementation.dragable_targets
		end
		
	insert_label: EV_CELL is
				-- Label used to indicate where `Current' will be placed in target.
			local
				pixmap: EV_PIXMAP
			once
				Create Result
				Result.set_minimum_size (10, 10)
				create pixmap
				pixmap.set_with_named_file ("C:\Documents and Settings\Julian Rogers\Desktop\grid_pattern.bmp")
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
			--
		once
			Create Result
		end
		
	insert_sep_imp: EV_TOOL_BAR_SEPARATOR_IMP is
			--
		once
			Result ?= insert_sep.implementation
		ensure
			Result /= Void
		end
		
	remove_insert_sep is
			--
		do
			if insert_sep.parent /= Void then
				insert_sep.parent.prune (insert_sep)
			end
		ensure
			not_parented: insert_sep.parent = Void
		end
		
			
	dragable_dialog_target: EV_DOCKABLE_DIALOG
		-- A dockable dialog that will be created as 
	 	-- necessary. This is not a local, to avoid it
	 	-- being garbage collected.
	 	
	 internal_screen: EV_SCREEN is
	 		--
	 	once
	 		create Result
	 	end
	 	
	 	

feature -- Access common.

		pointer_x, pointer_y: INTEGER

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

invariant
	invariant_clause: True -- Your invariant here

end -- class EV_SHARED_TRANSPORT_I

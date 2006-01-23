indexing
	description: "Objects that provide common attributes for transport mechanisms."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		
	source_being_docked: EV_DOCKABLE_SOURCE_I
		-- Dragable source currently being transported. May be a
		-- WIDGET_IMP or an EV_TOOL_BAR_BUTTON_IMP.
		
	originating_source: EV_DOCKABLE_SOURCE_I
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
			
	insert_label_imp: EV_CELL_I is
			-- Once access to implementation of `insert_label'.
		once
			Result ?= insert_label.implementation
		ensure
			Result /= Void
		end
		
	remove_insert_label is
				-- Remove `insert_label' from its current `parent'.
				-- We must handle a special case for cells. If the parent is a cell,
				-- then we remove the cell from its parent, and then restore it.
				-- Otherwise, when the label, removed, the cell keeps it size, and cells
				-- are normally used with `real_target' when the cell must
				-- not be visible.
			local
				cell_parent: EV_CELL
				box_cell_parent: EV_BOX
				index: INTEGER
				is_expanded: BOOLEAN
			do
				if insert_label.parent /= Void then
					cell_parent ?= insert_label.parent
						-- Unparent `insert_label'.
					insert_label.parent.prune (insert_label)
						-- Now, perform special processing if the parent of `insert_label'
						-- was a cell. Note that we check `cell_parent' is not Void before checking its
						-- generating type.
					if cell_parent /= Void and then cell_parent.generating_type.is_equal ("EV_CELL") then
						box_cell_parent ?= cell_parent.parent
						if box_cell_parent /= Void then
							index := box_cell_parent.index_of (cell_parent, 1)
							is_expanded := box_cell_parent.is_item_expanded (cell_parent)
							box_cell_parent.prune_all (cell_parent)
							box_cell_parent.go_i_th (index)
							box_cell_parent.put_left (cell_parent)
							--box_cell_parent.insert_i_th (cell_parent, index)
							if not is_expanded then
								box_cell_parent.disable_item_expand (cell_parent)
							end
						end
					end
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
		
	insert_sep_imp: EV_TOOL_BAR_SEPARATOR_I is
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

		pointer_x, pointer_y: INTEGER;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SHARED_TRANSPORT_I


indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_DOCKABLE_NOTEBOOK
	
inherit
	ES_NOTEBOOK
		redefine
			build_interface
		end

create
	make
		
feature {NONE} -- Initialization

	build_interface is
		do
			Precursor {ES_NOTEBOOK}
			notebook.pointer_button_press_actions.extend (agent press_received)
			notebook.pointer_button_release_actions.extend (agent release_received)
			notebook.pointer_motion_actions.extend (agent motion_received)
		end
		
feature {NONE} -- Implementation

	press_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
		do
			debug ("es_dockable_notebook")
				print ("press received%N")
			end
			if a_button = 1 then
				if notebook.pointed_tab_index > 0 then
					debug ("es_dockable_notebook")
						print ("pointing to tab%N")
					end
					dock_source := notebook.i_th (notebook.pointed_tab_index)
					initial_x := a_screen_x
					initial_y := a_screen_y
					awaiting_movement := True
				end
			end
		end
		
	release_received (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
		local
			pointed_widget: EV_WIDGET
			pointed_tab_index: INTEGER
			dock_source_index: INTEGER
			dock_source_text: STRING
			
			dock_source_item: ES_NOTEBOOK_ITEM
			l_tab: EV_NOTEBOOK_TAB
		do
			notebook.disable_capture
			debug ("es_dockable_notebook")
				print ("release_received%N")
			end
			if dock_executing then
				if a_button = 1 then
					-- Other than 1st button click will cancel docking
					debug ("es_dockable_notebook")
						print ("dock executing%N")
					end
					pointed_tab_index := notebook.pointed_tab_index
					dock_source_index := notebook.index_of (dock_source, 1)
					dock_source_text := notebook.item_text (dock_source)
					dock_source_item := item_by_index (dock_source_index)
					dock_source_item.on_docking_started

					if pointed_tab_index = 0 then
						debug ("es_dockable_notebook")
							print ("pointed_tab_index is zero%N")
						end
						create dockable_dialog
						dockable_dialog.set_original_parent_index (dock_source_index)
						dock_source.parent.prune_all (dock_source)
						dockable_dialog.set_original_parent (notebook)
						dockable_dialog.extend (dock_source)
						
						dockable_dialog.set_title (dock_source_text)
						dockable_dialog.enable_closeable
						dockable_dialog.close_request_actions.extend (agent close_dockable_dialog (dockable_dialog))
						dockable_dialog.set_position (a_screen_x, a_screen_y)

						dockable_dialog.show
						dockable_dialog := Void
					else
						if dock_source_index /= pointed_tab_index then --and dock_source_index /= pointed_tab_index - 1 then
								-- Do not move the widget if the location is the same.
							notebook.prune_all (dock_source)
							if pointed_tab_index < dock_source_index then
								notebook.go_i_th (pointed_tab_index)
								notebook.put_left (dock_source)
							else 
								notebook.go_i_th (pointed_tab_index - 1)
								notebook.put_right (dock_source)
							end
							l_tab := notebook.item_tab (dock_source)
							dock_source_item.set_tab (l_tab)
							l_tab.set_text (dock_source_text)
							l_tab.enable_select
						end
						debug ("es_dockable_notebook")
							print ("pointing to a tab%N")
						end
					end
					dock_source_item.on_docking_ended
				end
			end
			dock_source	:= Void
			awaiting_movement := False
			if dock_executing then 
				dock_executing := False
				update_pointer_style
			end
	end
	
	motion_received (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
		do
			debug ("es_dockable_notebook")
				print ("motion_received %N")
			end
			if awaiting_movement then
				if (a_screen_x - initial_x).abs > 3 or (a_screen_y - initial_y).abs > 3 then
					debug ("es_dockable_notebook")
						print ("starting dock")
					end
					awaiting_movement := False
					dock_executing := True
					notebook.enable_capture
					update_pointer_style
				end
			end
		end
		
	close_dockable_dialog (a_dialog: ES_DOCKABLE_DIALOG) is
			--
		local
			a_widget: EV_WIDGET
			a_notebook: EV_NOTEBOOK
			a_tab: EV_NOTEBOOK_TAB
			l_item: ES_NOTEBOOK_ITEM
			l_title: STRING
			hv: EV_BOX
		do
			l_title := a_dialog.title
			a_dialog.hide
			a_widget := a_dialog.item

			l_item := item_by_widget (a_widget)
			hv := l_item.inside_toolbar_box
			hv.wipe_out
			hv.hide

			a_dialog.wipe_out
			a_notebook ?= a_dialog.original_parent
			a_notebook.go_i_th (a_dialog.original_parent_index)
			a_notebook.put_left (a_widget)
			a_tab := a_notebook.item_tab (a_widget)
			l_item.set_tab (a_tab)
			a_tab.set_text (l_title)
			a_dialog.destroy
			a_tab.enable_select
		end	

	update_pointer_style is
		local
			win: EV_WINDOW
		do
			win := parent_window (widget)
			if win /= Void then
				if dock_executing then
					orig_cursor := win.pointer_style					
					win.set_pointer_style (drag_cursor)
				else
					win.set_pointer_style (orig_cursor)
					orig_cursor := Void
				end
			end
		end
		
	drag_cursor: EV_CURSOR is
			-- Cursor used when `Current' is being transported.
		once
			Result := (create {EV_STOCK_PIXMAPS}).sizeall_cursor
		end

	orig_cursor: EV_CURSOR
		
	awaiting_movement: BOOLEAN
		
	initial_x, initial_y: INTEGER
	
	dock_executing: BOOLEAN
	
	dock_source: EV_WIDGET
	
	dockable_dialog: ES_DOCKABLE_DIALOG
	
feature {NONE} -- Vision2 helper Implementation

	parent_window (w: EV_WIDGET): EV_WINDOW is
			-- `Result' is window parent of `widget'.
			-- `Void' if none.
		require
			widget_not_void: w /= Void
		local
			win: EV_WINDOW
		do
			win ?= w.parent
			if win = Void then
				if w.parent /= Void then
					Result := parent_window (w.parent)
				end
			else
				Result := win
			end
		end	

end

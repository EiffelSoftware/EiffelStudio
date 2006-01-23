indexing
	description: "Header control for dealing with multiple documents in TEXT_PANEL."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_HEADER

inherit
	DOCUMENT_LIST [TEXT_PANEL_HEADER_ITEM]
		rename
			remove as remove_document
		redefine
			area,
			item,
			remove_document
		end

	SHARED_EDITOR_DATA
		undefine
			is_equal,
			copy
		end
		
	SHARED_EDITOR_FONT
		undefine
			is_equal,
			copy
		end

	TEXT_OBSERVER
		undefine
			is_equal,
			copy
		redefine
			on_text_loaded,
			on_text_fully_loaded
		end

create
	make_with_panel

feature -- Creation

	make_with_panel (a_text_panel: TEXT_PANEL) is
			-- Make with `a_text_panel'
		require
			panel_not_void: a_text_panel /= Void
		do
			make (0)
			panel := a_text_panel
			create open_linked_list.make
			create selection_actions
			create before_selection_actions
			create close_actions
			open_linked_list.compare_objects
			build_header_area
			a_text_panel.text_displayed.add_edition_observer (Current)
		ensure
			has_panel: panel /= Void
		end			

feature -- Basic Operations

	open_document (a_doc: like item) is
			-- Opens `a_doc' and selects it in the tab list.
		local
			l_type: STRING
			l_text: TEXT
		do			
			compare_objects			
			
				-- Update structure
			if not has (a_doc) then
				extend (a_doc)
				go_i_th (count)
				open_linked_list.extend (a_doc)
			else
				go_i_th (index_of (a_doc, 1))
			end
			update_list_order (item)
			update_items
			
			index := index.min (count)
			
			l_type := a_doc.document_type
			if l_type /= Void and then panel.known_document_type (l_type) then
				panel.set_current_document_class (panel.get_class_from_type (l_type))	
			end
			
				-- Update editor panel				
			if item.data /= Void then
				panel.set_text (item.data, a_doc.name)
				if item.cursor_line > 0 then
					panel.setup_editor (item.cursor_line)										
				else					
					panel.setup_editor (1)
				end
			else
				close_button.disable_sensitive
				l_text := panel.new_text_displayed
				l_text.add_edition_observer (Current)
				panel.set_text (l_text, a_doc.name)
				panel.load_file (item.name)
				item.set_data (l_text)
			end		
			on_text_loaded
			update_buffered_screen
			update_display			
			panel.refresh_now			
--			if panel.editor_drawing_area.is_sensitive then
--				panel.set_focus
--			end

			index := index_of (item, 1)
			selection_actions.call ([Current])
		end

	remove_document is
			-- Remove document
		require else
			has_open_document: count > 0
		do			
			open_linked_list.remove
			if open_linked_list.after and then not open_linked_list.is_empty then
				open_linked_list.finish
			end
			Precursor
			update_items			
		end

feature -- Access

	container: EV_HORIZONTAL_BOX
			-- Top level widget container

	previous_selected_index: INTEGER
			-- Index of previously selected item

	icons: EDITOR_ICONS   
			-- Editor icons   

feature -- Actions

	selection_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when selected item changes.
			
	before_selection_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed just before selected item changes.
			
	close_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when document is closed.		
			
feature {NONE} -- Initialization

	build_header_area is
			-- Build the header area
		local
			l_inner_box: EV_HORIZONTAL_BOX
			l_toolbar: EV_TOOL_BAR
		do
			create header_area
			update_height
			header_area.set_minimum_size (1, height)			
			
				-- Add widgets to our window
			create container
			container.extend (header_area)
			
				-- Add top right buttons for scrolling and closing
			create l_inner_box
			create l_toolbar		
			
			create left_scroll_button
			left_scroll_button.set_pixmap (icons.header_left_scroll_pixmap)
			left_scroll_button.select_actions.force_extend (agent scroll_left)
			left_scroll_button.disable_sensitive
			l_toolbar.extend (left_scroll_button)
			
			create right_scroll_button
			right_scroll_button.set_pixmap (icons.header_right_scroll_pixmap)
			right_scroll_button.select_actions.force_extend (agent scroll_right)
			right_scroll_button.disable_sensitive
			l_toolbar.extend (right_scroll_button)
			
			create close_button
			close_button.set_pixmap (icons.header_close_current_document_pixmap)
			close_button.select_actions.force_extend (agent close_document)
			close_button.disable_sensitive
			l_toolbar.extend (close_button)
			
			l_inner_box.extend (l_toolbar)
			container.extend (l_inner_box)
			container.disable_item_expand (l_inner_box)
			
			
					-- Set up the screen.
			create buffered_screen.make_with_size (header_area.width, header_area.height)
			buffered_screen.set_background_color (editor_preferences.normal_background_color)					
			l_toolbar.set_background_color (buffered_screen.background_color)
			
					-- Events
			header_area.expose_actions.extend (agent on_repaint)
			header_area.resize_actions.extend (agent on_size)
			header_area.focus_in_actions.extend (agent on_focus)
			header_area.pointer_button_press_actions.extend (agent on_mouse_button_down)
		end		

feature {NONE} -- Display functions

	on_focus is
			-- 
		do
			--	print ("Focus in %N")
		end		

	on_repaint (x, y, a_width, a_height: INTEGER) is
			-- Repaint the part of the panel between in the rectangle between
			-- (`x', `y') and (`x' + `a_width', `y' + `a_height').
			--| Actually, rectangle defined by (0, y) -> (editor_area.width, y + height) is redrawn.
		do
			if a_width /= 0 and a_height /= 0 then
				update_buffered_screen
				update_display				
			end
		end

	on_size (a_x, a_y: INTEGER; a_width, a_height: INTEGER) is
			-- Refresh the panel after it has been resized (and moved) to new coordinates (`a_x', `a_y') and
			-- new size (`a_width', `a_height'). 
			--| Note: This feature is called during the creation of the window
		local
			old_height: INTEGER
			w,h: INTEGER
		do
				-- Resize & redraw the buffered screen.
			if buffered_screen /= Void then -- System initialized.
				in_resize := True

				if buffered_screen.width < a_width then
					if in_resize then
						w := container.width.max (a_width)
						h := a_height.max (1)
					else
						w := container.width.max (a_width).max (buffered_screen.width)
						h := a_height.max (1).max (h)
					end
					buffered_screen.set_size (w, h)					
					update_buffered_screen
				else
					old_height := buffered_screen.height
					if in_resize then
						w := container.width.max (header_area.width)
						h := a_height.max (1)
					else
						w := container.width.max (header_area.width).max (buffered_screen.width)
						h := a_height.max (1).max (buffered_screen.height)
					end
					buffered_screen.set_size (w, h)
					if old_height < a_height then
						update_buffered_screen
					end
				end
				in_resize := False
			end
			
		end	
 	
 	update_buffered_screen is
 			-- Update buffered pixmap from `a_x'.
 		local
 			l_index: INTEGER
 		do 			
			buffered_screen.set_background_color (container.background_color)
			buffered_screen.clear_rectangle (0, 0, buffered_screen.width, buffered_screen.height)

 				-- Draw all items				
 			from
 				l_index := index
 				start 				
 			until
 				after
 			loop
 				if index = l_index then
 					item.display_selected (buffered_screen, panel)
 				else
	 				item.display (buffered_screen, panel)
	 			end
 				forth
 			end
 			go_i_th (l_index)
 		end			
 		
	update_display is
			-- Update display by drawing the buffered pixmap on `header_area'.
		do
			header_area.clear
			header_area.draw_sub_pixmap (
				0,
				0,
				buffered_screen,
				create {EV_RECTANGLE}.make (
					offset,
					0,
					header_area.width + offset,
					buffered_screen.height)
			)
			
				-- Update the buttons
			if (width - offset) > header_area.width then
				right_scroll_button.enable_sensitive				
			else
				right_scroll_button.disable_sensitive
			end
			if offset > 0 then
				left_scroll_button.enable_sensitive
			else
				left_scroll_button.disable_sensitive
			end
		end

	update_items is
			-- Update the items
		local
			l_index: INTEGER
			l_prev_item: like item
		do
				-- Update the open document items
			from 
				width := 0
				l_index := index
				start
			until
				after
			loop				
				item.set_previous (l_prev_item)
				if l_prev_item = Void then								
					item.update_width
				else
					l_prev_item.set_next (item)
				end
				width := width + item.width
				l_prev_item := item
				forth
			end
			go_i_th (l_index)
		end		

	update_height is
			-- 
		do
			height := header_font_cell.item.value.height + 10
		end		

feature {NONE} -- Widgets

	left_scroll_button: EV_TOOL_BAR_BUTTON
	
	right_scroll_button: EV_TOOL_BAR_BUTTON
	
	close_button: EV_TOOL_BAR_BUTTON

feature {NONE} -- Events

	on_mouse_button_down (x_pos, y_pos, button: INTEGER; unused1,unused2,unused3: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Mouse button was pressed.
		local
			l_index: INTEGER
			l_item: like item
			found: BOOLEAN
			l_keyboard_panel: KEYBOARD_SELECTABLE_TEXT_PANEL
		do
			if button = 1 and then panel.text_is_fully_loaded then				
				
					-- Store current index
				l_index := index
				
					-- Get the newly selected item
				from
					start
				until
					after or found
				loop
					if item.position > x_pos then						
						found := True
					else
						l_item := item
					end
					forth
				end
				index := l_index
				
				if l_index /= index_of (l_item, 1) then
						-- It is not the same item
					before_selection_actions.call ([Current])
					if item /= Void then
							-- Store item information for when we change back
						item.set_data (panel.text_displayed)
						l_keyboard_panel ?= panel
						if l_keyboard_panel/= Void then
							item.set_cursor_line (l_keyboard_panel.text_displayed.cursor.y_in_lines)
							item.set_cursor_char (l_keyboard_panel.text_displayed.cursor.x_in_characters)
						end
						item.set_first_line_displayed (panel.first_line_displayed)
					end					
					index := index_of (l_item, 1)
					previous_selected_index := l_index
					open_document (l_item)								
				end				
			end
		end		

	scroll_left is
			-- 
		do
			offset := offset - 10
			if offset < 0 then
				offset := 0
			end
			update_display
		end
		
	scroll_right is
			-- 
		do	
			offset := offset + 10
			if offset > buffered_screen.width then
				offset := buffered_screen.width
			end
			update_display
		end
		
	close_document is
			-- 
		do				
			close_actions.call ([Current])
			remove_document
			if is_empty then
				panel.clear_window
				update_buffered_screen
				update_display
			else
				open_document (open_linked_list.item)
			end			
		end
		
	on_text_loaded is
			-- Update `Current' when the text has been completely loaded.
		local
			l_keyboard_panel: KEYBOARD_SELECTABLE_TEXT_PANEL
		do
			l_keyboard_panel ?= panel
			if l_keyboard_panel /= Void and then not is_empty and then item /= Void then
				if item.first_line_displayed > 0 then
					l_keyboard_panel.set_first_line_displayed (item.first_line_displayed, False)
				end	
				if item.cursor_line > 0 then					
					l_keyboard_panel.text_displayed.cursor.set_y_in_lines (item.cursor_line)	
				end
				if item.cursor_char > 0 then
					l_keyboard_panel.text_displayed.cursor.set_x_in_characters (item.cursor_char)
				end			
			end				
		end
	
	on_text_fully_loaded is
			-- Update `Current' when the text has been completely loaded.
		local
			l_keyboard_panel: KEYBOARD_SELECTABLE_TEXT_PANEL
		do
			l_keyboard_panel ?= panel
			if l_keyboard_panel /= Void and then not is_empty and then item /= Void then				
				close_button.enable_sensitive
			end				
		end

feature {NONE} -- Implementation

	panel: TEXT_PANEL
		-- Panel
	
	height: INTEGER
		-- Height

	width: INTEGER
		-- Width
		
	header_area: EV_DRAWING_AREA
		-- Area	
	
	buffered_screen: EV_PIXMAP
		-- Buffered area

	in_resize: BOOLEAN
		-- Is Current currently being resized

	area: SPECIAL [TEXT_PANEL_HEADER_ITEM]
		-- Area

	item: TEXT_PANEL_HEADER_ITEM is
			-- Item
		do
			Result := area.item (index - 1)
		end		

	offset: INTEGER

	open_linked_list: LINKED_LIST [like item]
			-- 

	update_list_order (a_item: like item) is
			-- Update list order with `a_item' at the top.
		require
			item_valid: a_item /= Void	
			item_known: open_linked_list.has (a_item)
		do
			open_linked_list.start
			open_linked_list.search (a_item)
			open_linked_list.remove
			open_linked_list.extend (a_item)
			open_linked_list.finish
		end		

invariant
	has_panel: panel /= Void

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




end -- class TEXT_PANEL_HEADER

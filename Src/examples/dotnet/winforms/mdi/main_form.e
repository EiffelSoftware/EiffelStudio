indexing
	description: ""

class
	MAIN_FORM

--inherit 
--	WINFORMS_FORM
--		redefine
--			make,
--			on_paint,
--			dispose_boolean
--		end

create
	make

feature {NONE} -- Initialization

	make is
		indexing
			description: "Entry point."
		local
			dummy: SYSTEM_OBJECT
			mi_file, miAddDoc, miExit, miWindow: WINFORMS_MENU_ITEM
		do
			create my_window.make

			initialize_component

			-- Setup MDI stuff
			my_window.set_is_mdi_container (true)
			my_window.add_mdi_child_activate (create {EVENT_HANDLER}.make (Current, $MDIChildActivated))

			-- Add File Menu
			mi_file := main_menu.get_menu_items.add (("&File").to_cil)
			mi_file.set_merge_order (0)
			mi_file.set_merge_type (feature {WINFORMS_MENU_MERGE}.merge_items)

			-- MenuItem miAddDoc = new MenuItem("&Add Document", new EventHandler(this.FileAdd_Clicked), Shortcut.CtrlA)
			create miAddDoc.make_from_text_and_on_click_and_shortcut (("&Add Document").to_cil, create {EVENT_HANDLER}.make (Current, $FileAdd_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_a)
			miAddDoc.set_merge_order (100)

			-- MenuItem miExit = new MenuItem("E&xit", new EventHandler(this.FileExit_Clicked), Shortcut.CtrlX)
			create miExit.make_from_text_and_on_click_and_shortcut (("E&xit").to_cil, create {EVENT_HANDLER}.make (Current, $FileExit_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_X)
			miExit.set_merge_order (110)

			dummy := mi_file.get_menu_items.add_menu_item (miAddDoc)
			dummy := mi_file.get_menu_items.add (("-").to_cil)     --  Gives us a seperator
			dummy := mi_file.get_menu_items.add_menu_item (miExit)

			-- Add Window Menu
			miWindow := main_menu.get_menu_items.add (("&Window").to_cil)
			miWindow.set_merge_order (10)
			dummy := miWindow.get_menu_items.add_string_event_handler (("&Cascade").to_cil, create {EVENT_HANDLER}.make (Current, $WindowCascade_Clicked))
			dummy := miWindow.get_menu_items.add_string_event_handler (("Tile &Horizontal").to_cil, create {EVENT_HANDLER}.make (Current, $WindowTileH_Clicked))
			dummy := miWindow.get_menu_items.add_string_event_handler (("Tile &Vertical").to_cil, create {EVENT_HANDLER}.make (Current, $WindowTileV_Clicked))
			miWindow.set_mdi_list (True)  -- Adds the MDI Window List to the bottom of the menu

--			add_document -- Add an initial doc

			dummy := my_window.show_dialog
		end



feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu.

	status_bar_1: WINFORMS_STATUS_BAR
			-- System.Windows.Forms.StatusBar.

	window_count: INTEGER
			-- number of windows.



feature {NONE} -- Implementation

	initialize_component is
			--
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
		do
			create components.make
			create main_menu.make
			create status_bar_1.make
			
			my_window.set_text (("MDI Example").to_cil)
			my_window.set_menu (main_menu)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (450, 200)
			my_window.set_client_size_size (l_size)

			create main_menu.make
			my_window.set_menu (main_menu)
			
			status_bar_1.set_back_color (feature {DRAWING_SYSTEM_COLORS}.get_control)
			l_point.make_from_x_and_y (0, 180)
			status_bar_1.set_location (l_point)
			l_size.make_from_width_and_height (450, 20)
			status_bar_1.set_size (l_size)
			status_bar_1.set_tab_index (1)
			my_window.get_controls.add (status_bar_1)
		end


feature {NONE} -- Implementation

		add_document is
				-- Add a document
			local
				doc: DOCUMENT
			do
				window_count := window_count + 1 
				create doc.make_with_name ((("").to_cil).concat_string_string (("Document ").to_cil, window_count.to_string))
--				doc.set_mdi_parent (Current)
--				doc.show
			end

		FileAdd_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- File->Add Menu item handler
			do
				add_document
			end
		
		FileExit_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- File->Exit Menu item handler
			do
				my_window.close
			end

		MDIChildActivated (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- One of the MDI Child windows has been activated
			do
				if my_window.get_active_mdi_child.equals (Void) then
					status_bar_1.set_text (("").to_cil)
				else
					status_bar_1.set_text (my_window.get_active_mdi_child.get_text)
				end
			end
		
		WindowCascade_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- Window->Cascade Menu item handler
			do
				my_window.layout_mdi (feature {WINFORMS_MDI_LAYOUT}.cascade)
			end
		
		WindowTileH_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- Window->Tile Horizontally Menu item handler
			do
				my_window.layout_mdi (feature {WINFORMS_MDI_LAYOUT}.tile_horizontal)
			end
		
		WindowTileV_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
				-- Window->Tile Vertically Menu item handler
			do
				my_window.layout_mdi (feature {WINFORMS_MDI_LAYOUT}.tile_vertical)
			end

--		protected override void Dispose(bool disposing)
--				-- Clean up any resources being used.
--			do
--
--			   if (disposing) {
--					if (components != null) {
--						components.Dispose()
--					}
--			   }
--			   base.Dispose(disposing)
--			end


end -- Class MAIN_FORM



indexing
	description: ""

class
	MAIN_FORM

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		undefine
			to_string, finalize, equals, get_hash_code
		redefine
			dispose_boolean
		end

	ANY


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
			initialize_component

			-- Setup MDI stuff
			set_is_mdi_container (true)
			add_mdi_child_activate (create {EVENT_HANDLER}.make (Current, $MDI_child_activated))

			-- Add File Menu
			mi_file := main_menu.menu_items.add (("&File").to_cil)
			mi_file.set_merge_order (0)
			mi_file.set_merge_type (feature {WINFORMS_MENU_MERGE}.merge_items)

			-- MenuItem miAddDoc = new MenuItem("&Add Document", new EventHandler(this.file_add_clicked), Shortcut.CtrlA)
			create miAddDoc.make_from_text_and_on_click_and_shortcut (("&Add Document").to_cil, create {EVENT_HANDLER}.make (Current, $file_add_clicked), feature {WINFORMS_SHORTCUT}.ctrl_a)
			miAddDoc.set_merge_order (100)

			-- MenuItem miExit = new MenuItem("E&xit", new EventHandler(this.file_exit_clicked), Shortcut.CtrlX)
			create miExit.make_from_text_and_on_click_and_shortcut (("E&xit").to_cil, create {EVENT_HANDLER}.make (Current, $file_exit_clicked), feature {WINFORMS_SHORTCUT}.ctrl_X)
			miExit.set_merge_order (110)

			dummy := mi_file.menu_items.add_menu_item (miAddDoc)
			dummy := mi_file.menu_items.add (("-").to_cil)     --  Gives us a seperator
			dummy := mi_file.menu_items.add_menu_item (miExit)

			-- Add Window Menu
			miWindow := main_menu.menu_items.add (("&Window").to_cil)
			miWindow.set_merge_order (10)
			dummy := miWindow.menu_items.add_string_event_handler (("&Cascade").to_cil, create {EVENT_HANDLER}.make (Current, $window_cascade_clicked))
			dummy := miWindow.menu_items.add_string_event_handler (("Tile &Horizontal").to_cil, create {EVENT_HANDLER}.make (Current, $window_tileH_clicked))
			dummy := miWindow.menu_items.add_string_event_handler (("Tile &Vertical").to_cil, create {EVENT_HANDLER}.make (Current, $window_tileV_clicked))
			miWindow.set_mdi_list (True)  -- Adds the MDI Window List to the bottom of the menu

			feature {WINFORMS_APPLICATION}.run_form (Current)
		end



feature -- Access

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
			
			set_text (("MDI Example").to_cil)
			set_menu (main_menu)
			l_size.make_from_width_and_height (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (450, 200)
			set_client_size (l_size)

			create main_menu.make
			set_menu (main_menu)
			
			status_bar_1.set_back_color (feature {DRAWING_SYSTEM_COLORS}.control)
			l_point.make_from_x_and_y (0, 180)
			status_bar_1.set_location (l_point)
			l_size.make_from_width_and_height (450, 20)
			status_bar_1.set_size (l_size)
			status_bar_1.set_tab_index (1)
			controls.add (status_bar_1)
		end


feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
		local
			dummy: WINFORMS_DIALOG_RESULT
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := true
			retry
		end

	add_document is
			-- Add a document
		local
			doc: DOCUMENT
		do
			window_count := window_count + 1 
			create doc.make_with_name ((("").to_cil).concat_string_string (("Document ").to_cil, window_count.to_string))
			doc.set_mdi_parent (Current)
			doc.show
		end

	file_add_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Add Menu item handler
		do
			add_document
		end
	
	file_exit_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Exit Menu item handler
		do
			close
		end

	MDI_child_activated (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- One of the MDI Child windows has been activated
		do
			if active_mdi_child = Void then
				status_bar_1.set_text (("").to_cil)
			else
				status_bar_1.set_text (active_mdi_child.text)
			end
		end
	
	window_cascade_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Cascade Menu item handler
		do
			layout_mdi (feature {WINFORMS_MDI_LAYOUT}.cascade)
		end
	
	window_tileH_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Tile Horizontally Menu item handler
		do
			layout_mdi (feature {WINFORMS_MDI_LAYOUT}.tile_horizontal)
		end
	
	window_tileV_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Tile Vertically Menu item handler
		do
			layout_mdi (feature {WINFORMS_MDI_LAYOUT}.tile_vertical)
		end

end -- Class MAIN_FORM



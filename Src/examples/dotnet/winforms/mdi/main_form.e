indexing
	description: "Multi Documents sample."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	MAIN_FORM

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make is
			-- Entry point.
		local
			res: SYSTEM_OBJECT
			mi_file, mi_add_doc, mi_exit, mi_window: WINFORMS_MENU_ITEM
		do
			initialize_component

				-- Setup MDI stuff
			set_is_mdi_container (True)
			add_mdi_child_activate (create {EVENT_HANDLER}.make (Current, $on_MDI_child_activated))

				-- Add File Menu
			mi_file := main_menu.menu_items.add ("&File")
			mi_file.set_merge_order (0)
			mi_file.set_merge_type ({WINFORMS_MENU_MERGE}.merge_items)

			create mi_add_doc.make ("&Add Document",
				create {EVENT_HANDLER}.make (Current, $on_file_add_clicked),
				{WINFORMS_SHORTCUT}.ctrl_a)
			mi_add_doc.set_merge_order (100)

			create mi_exit.make ("E&xit",
				create {EVENT_HANDLER}.make (Current, $on_file_exit_clicked),
				{WINFORMS_SHORTCUT}.ctrl_x)
			mi_exit.set_merge_order (110)

			res := mi_file.menu_items.add_menu_item (mi_add_doc)
			res := mi_file.menu_items.add ("-")     --  Gives us a seperator
			res := mi_file.menu_items.add_menu_item (mi_exit)

				-- Add Window Menu
			mi_window := main_menu.menu_items.add ("&Window")
			mi_window.set_merge_order (10)
			res := mi_window.menu_items.add_string_event_handler ("&Cascade",
				create {EVENT_HANDLER}.make (Current, $on_window_cascade_clicked))
			res := mi_window.menu_items.add_string_event_handler ("Tile &Horizontal",
				create {EVENT_HANDLER}.make (Current, $on_window_tile_h_clicked))
			res := mi_window.menu_items.add_string_event_handler ("Tile &Vertical",
				create {EVENT_HANDLER}.make (Current, $on_window_tile_v_clicked))
			mi_window.set_mdi_list (True)  -- Adds the MDI Window List to the bottom of the menu

			{WINFORMS_APPLICATION}.run_form (Current)
		ensure
		
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu.

	status_bar: WINFORMS_STATUS_BAR
			-- System.Windows.Forms.StatusBar.

	window_count: INTEGER
			-- number of windows.

feature {NONE} -- Implementation

	initialize_component is
			-- Initialize all components of window.
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
		do
			create components.make
			create main_menu.make
			create status_bar.make

			set_text ("MDI Example")
			set_menu (main_menu)
			l_size.make (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make (450, 200)
			set_client_size (l_size)

			create main_menu.make
			set_menu (main_menu)

			status_bar.set_back_color ({DRAWING_SYSTEM_COLORS}.control)
			l_point.make (0, 180)
			status_bar.set_location (l_point)
			l_size.make (450, 20)
			status_bar.set_size (l_size)
			status_bar.set_tab_index (1)
			controls.add (status_bar)
		ensure
			non_void_components: components /= Void
			non_void_main_menu: main_menu /= Void
			non_void_status_bar: status_bar /= Void
		end

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- Method called when form is disposed.
		local
			retried: BOOLEAN
		do
			if not retried then
				if components /= Void then
					components.dispose	
				end
			end
			Precursor {WINFORMS_FORM}(a_disposing)
		rescue
			retried := True
			retry
		end

	add_document is
			-- Add a document.
		local
			doc: DOCUMENT
		do
			window_count := window_count + 1 
			create doc.make_with_name ("Document " + window_count.out)
			doc.set_mdi_parent (Current)
			doc.show
		end

	on_file_add_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Add Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			add_document
		end

	on_file_exit_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Exit Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			close
		end

	on_MDI_child_activated (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- One of the MDI Child windows has been activated.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			if active_mdi_child = Void then
				status_bar.set_text ("")
			else
				status_bar.set_text (active_mdi_child.text)
			end
		end

	on_window_cascade_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Cascade Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			layout_mdi ({WINFORMS_MDI_LAYOUT}.cascade)
		end

	on_window_tile_h_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Tile Horizontally Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			layout_mdi ({WINFORMS_MDI_LAYOUT}.tile_horizontal)
		end

	on_window_tile_v_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Window->Tile Vertically Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		do
			layout_mdi ({WINFORMS_MDI_LAYOUT}.tile_vertical)
		end

invariant
	non_void_components: components /= Void
	non_void_main_menu: main_menu /= Void
	non_void_status_bar: status_bar /= Void

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


end -- Class MAIN_FORM



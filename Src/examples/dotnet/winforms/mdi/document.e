indexing
	description: ""

class
	DOCUMENT

--inherit 
--	WINFORMS_FORM
--		redefine
--			make,
--			on_paint,
--			dispose_boolean
--		end

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (doc_name: SYSTEM_STRING) is
		require
			non_void_doc_name: doc_name /= Void
		local
			dummy: SYSTEM_OBJECT
			mi_file, mi_format, miLoadDoc: WINFORMS_MENU_ITEM
			l_array_menu_item: NATIVE_ARRAY [WINFORMS_MENU_ITEM]
		do
			create my_window.make

			initialize_component

			--  Initialize Fonts - use generic fonts to avoid problems across
			--  different versions of the OS
			create mono_space_font_family.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.monospace)
			create sans_serif_font_family.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.sans_serif)
			create serif_font_family.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.serif)
			current_font_family := sans_serif_font_family

			my_window.set_text (doc_name)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (current_font_family, fontSize)) --= new System.Drawing.Font(current_font_family, fontSize)
			rich_text_box.set_text (doc_name)

			-- Add File Menu
			mi_file := main_menu.menu_items.add (("&File").to_cil)
			mi_file.set_merge_type (feature {WINFORMS_MENU_MERGE}.merge_items)
			mi_file.set_merge_order (0)

			miLoadDoc := main_menu.menu_items.add_string_event_handler ((("").to_cil).concat_string_string_string (("&Load Document (").to_cil, doc_name, (")").to_cil), create {EVENT_HANDLER}.make (Current, $LoadDocument_Clicked)) --= mi_file.MenuItems.Add("&Load Document (" + doc_name + ")", new EventHandler(this.LoadDocument_Clicked))
			miLoadDoc.set_merge_order (105)

			-- Add Formatting Menu
			mi_format := main_menu.menu_items.add ((("").to_cil).concat_string_string_string (("F&ormat (").to_cil, doc_name, (")").to_cil))
			mi_format.set_merge_type (feature {WINFORMS_MENU_MERGE}.add)
			mi_format.set_merge_order (5)

			-- Font Face sub-menu
			create mmi_sans_serif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&1. ").to_cil, sans_serif_font_family.name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			mmi_sans_serif.set_checked (True) 
			mmi_sans_serif.set_default_item (True) 
			create mmi_serif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&2. ").to_cil, serif_font_family.name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			create mmi_mono_space.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&3. ").to_cil, mono_space_font_family.name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmi_sans_serif)
			l_array_menu_item.put (1, mmi_serif)
			l_array_menu_item.put (2, mmi_mono_space)
			dummy := mi_format.menu_items.add_string_menu_item_array (("Font &Face").to_cil, l_array_menu_item)


			-- Font Size sub-menu
			create mmi_small.make_from_text_and_on_click (("&Small").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			create mmi_medium.make_from_text_and_on_click (("&Medium").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			mmi_medium.set_checked (True) 
			mmi_medium.set_default_item (True) 
			create mmi_large.make_from_text_and_on_click (("&Large").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmi_small)
			l_array_menu_item.put (1, mmi_medium)
			l_array_menu_item.put (2, mmi_large)
			dummy := mi_format.menu_items.add_string_menu_item_array (("Font &Size").to_cil, l_array_menu_item)


			dummy := my_window.show_dialog
		end


feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	rich_text_box: WINFORMS_RICH_TEXT_BOX
			-- System.Windows.Forms.RichTextBox.

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu.

	fontSize: DOUBLE
			-- Font face and size.

	mmi_sans_serif, mmi_serif, mmi_mono_space, mmi_small, mmi_medium,
	mmi_large, cmi_sans_serif, cmi_serif, cmi_mono_space, cmi_small,
	cmi_medium, cmi_large, mi_main_format_font_checked, mi_main_format_size_checked,
	mi_context_format_font_checked, mi_context_format_size_checked : WINFORMS_MENU_ITEM
			-- System.Windows.Forms.MenuItem.

	current_font_family, mono_space_font_family, sans_serif_font_family, serif_font_family: DRAWING_FONT_FAMILY
			-- System.Windows.Forms.FontFamily.


feature {NONE} -- Implementation

	initialize_component is
			--
		local
			l_size: DRAWING_SIZE
			l_point: DRAWING_POINT
		do
			create components.make
			create rich_text_box.make
			create main_menu.make

			rich_text_box.set_text (("").to_cil)
			l_size.make_from_width_and_height (292, 273)
			rich_text_box.set_size (l_size)
			rich_text_box.set_tab_index (0)
			rich_text_box.set_dock (feature {WINFORMS_DOCK_STYLE}.fill)

			my_window.set_text (("").to_cil)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (392, 117)
			my_window.set_client_size (l_size)
			create main_menu.make
			my_window.set_menu (main_menu)

			my_window.controls.add (rich_text_box)		
		end


feature {NONE} -- Implementation

	font_sizes (a_size: STRING): DOUBLE is
			--  Comment out this structure to view menus.cs in the WinForms Designer.
			--  Remember not to edit the menus in the designer. It will conflict
			--  with the hand-written menu code. Remember to uncomment this
			--  structure when you are finished.
		do
			if a_size.is_equal ("Small") then
				Result := 8
			elseif a_size.is_equal ("Medium") then
				Result := 12
			elseif a_size.is_equal ("Large") then
				Result := 24
			end
		end


	LoadDocument_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Load Document Menu item handler
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (my_window.text)
		end

	FormatFont_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Font Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
		do
			mi_clicked ?= sender

			mi_main_format_font_checked.set_checked (False)
			mi_context_format_font_checked.set_checked (False)

			if mi_clicked.equals (mmi_sans_serif) or mi_clicked.equals (cmi_sans_serif) then
				mi_main_format_font_checked := mmi_sans_serif
				mi_context_format_font_checked := cmi_sans_serif
				current_font_family := sans_serif_font_family
			elseif mi_clicked.equals (mmi_serif) or mi_clicked.equals (cmi_serif) then
				mi_main_format_font_checked := mmi_serif
				mi_context_format_font_checked := cmi_serif
				current_font_family := serif_font_family
			else
				mi_main_format_font_checked := mmi_mono_space
				mi_context_format_font_checked := cmi_mono_space
				current_font_family := mono_space_font_family
			end

			mi_main_format_font_checked.set_checked (True)
			mi_context_format_font_checked.set_checked (True)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (current_font_family, fontSize))
		end


	FormatSize_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Size Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
			font_size_string: SYSTEM_STRING
		do
			mi_clicked ?= sender

			mi_main_format_size_checked.set_checked (False)
			mi_context_format_size_checked.set_checked (False)

			font_size_string := mi_clicked.text

			if font_size_string.equals (("&Small").to_cil) then
				mi_main_format_size_checked := mmi_small
				mi_context_format_size_checked := cmi_small
				fontSize := font_sizes ("Small")
			elseif font_size_string.equals (("&Large").to_cil) then
				mi_main_format_size_checked := mmi_large
				mi_context_format_size_checked := cmi_large
				fontSize := font_sizes ("Large")
			else
				mi_main_format_size_checked := mmi_medium
				mi_context_format_size_checked := cmi_medium
				fontSize := font_sizes ("Medium")
			end

			mi_main_format_size_checked.set_checked (True)
			mi_context_format_size_checked.set_checked (True)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (current_font_family, fontSize))
		end


--		protected override void Dispose(bool disposing)
--				-- Clean up any resources being used.
--			do
--		   if (disposing) {
--				if (components != null) {
--					components.Dispose()
--				}
--		   }
--		   base.Dispose(disposing)
--			end


end -- Class DOCUMENT












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
			create monoSpaceFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.monospace)
			create sansSerifFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.sans_serif)
			create serifFontFamily.make_from_generic_family (feature {DRAWING_GENERIC_FONT_FAMILIES}.serif)
			currentFontFamily := sansSerifFontFamily

			my_window.set_text (doc_name)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (currentFontFamily, fontSize)) --= new System.Drawing.Font(currentFontFamily, fontSize)
			rich_text_box.set_text (doc_name)

			-- Add File Menu
			mi_file := main_menu.get_menu_items.add (("&File").to_cil)
			mi_file.set_merge_type (feature {WINFORMS_MENU_MERGE}.merge_items)
			mi_file.set_merge_order (0)

			miLoadDoc := main_menu.get_menu_items.add_string_event_handler ((("").to_cil).concat_string_string_string (("&Load Document (").to_cil, doc_name, (")").to_cil), create {EVENT_HANDLER}.make (Current, $LoadDocument_Clicked)) --= mi_file.MenuItems.Add("&Load Document (" + doc_name + ")", new EventHandler(this.LoadDocument_Clicked))
			miLoadDoc.set_merge_order (105)

			-- Add Formatting Menu
			mi_format := main_menu.get_menu_items.add ((("").to_cil).concat_string_string_string (("F&ormat (").to_cil, doc_name, (")").to_cil))
			mi_format.set_merge_type (feature {WINFORMS_MENU_MERGE}.add)
			mi_format.set_merge_order (5)

			-- Font Face sub-menu
			create mmiSansSerif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&1. ").to_cil, sansSerifFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			mmiSansSerif.set_checked (True) 
			mmiSansSerif.set_default_item (True) 
			create mmiSerif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&2. ").to_cil, serifFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			create mmiMonoSpace.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&3. ").to_cil, monoSpaceFontFamily.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmiSansSerif)
			l_array_menu_item.put (1, mmiSerif)
			l_array_menu_item.put (2, mmiMonoSpace)
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Face").to_cil, l_array_menu_item)


			-- Font Size sub-menu
			create mmiSmall.make_from_text_and_on_click (("&Small").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			create mmiMedium.make_from_text_and_on_click (("&Medium").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))
			mmiMedium.set_checked (True) 
			mmiMedium.set_default_item (True) 
			create mmiLarge.make_from_text_and_on_click (("&Large").to_cil, create {EVENT_HANDLER}.make (Current, $FormatSize_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmiSmall)
			l_array_menu_item.put (1, mmiMedium)
			l_array_menu_item.put (2, mmiLarge)
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Size").to_cil, l_array_menu_item)


			dummy := my_window.show_dialog
		end


feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	rich_text_box: WINFORMS_RICH_TEXT_BOX
			-- System.Windows.Forms.RichTextBox

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu 

	fontSize: DOUBLE
			-- Font face and size

	mmiSansSerif, mmiSerif, mmiMonoSpace, mmiSmall, mmiMedium,
	mmiLarge, cmiSansSerif, cmiSerif, cmiMonoSpace, cmiSmall,
	cmiMedium, cmiLarge, miMainFormatFontChecked, miMainFormatSizeChecked,
	miContextFormatFontChecked, miContextFormatSizeChecked : WINFORMS_MENU_ITEM

	currentFontFamily, monoSpaceFontFamily, sansSerifFontFamily, serifFontFamily: DRAWING_FONT_FAMILY


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
			my_window.set_client_size_size (l_size)
			create main_menu.make
			my_window.set_menu (main_menu)

			my_window.get_controls.add (rich_text_box)		
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
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (my_window.get_text)
		end

	FormatFont_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Font Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
		do
			mi_clicked ?= sender

			miMainFormatFontChecked.set_checked (False)
			miContextFormatFontChecked.set_checked (False)

			if mi_clicked.equals (mmiSansSerif) or mi_clicked.equals (cmiSansSerif) then
				miMainFormatFontChecked := mmiSansSerif
				miContextFormatFontChecked := cmiSansSerif
				currentFontFamily := sansSerifFontFamily
			elseif mi_clicked.equals (mmiSerif) or mi_clicked.equals (cmiSerif) then
				miMainFormatFontChecked := mmiSerif
				miContextFormatFontChecked := cmiSerif
				currentFontFamily := serifFontFamily
			else
				miMainFormatFontChecked := mmiMonoSpace
				miContextFormatFontChecked := cmiMonoSpace
				currentFontFamily := monoSpaceFontFamily
			end

			miMainFormatFontChecked.set_checked (True)
			miContextFormatFontChecked.set_checked (True)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (currentFontFamily, fontSize))
		end


	FormatSize_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Size Menu item handler
		local
			mi_clicked: WINFORMS_MENU_ITEM
			font_size_string: SYSTEM_STRING
		do
			mi_clicked ?= sender

			miMainFormatSizeChecked.set_checked (False)
			miContextFormatSizeChecked.set_checked (False)

			font_size_string := mi_clicked.get_text

			if font_size_string.equals (("&Small").to_cil) then
				miMainFormatSizeChecked := mmiSmall
				miContextFormatSizeChecked := cmiSmall
				fontSize := font_sizes ("Small")
			elseif font_size_string.equals (("&Large").to_cil) then
				miMainFormatSizeChecked := mmiLarge
				miContextFormatSizeChecked := cmiLarge
				fontSize := font_sizes ("Large")
			else
				miMainFormatSizeChecked := mmiMedium
				miContextFormatSizeChecked := cmiMedium
				fontSize := font_sizes ("Medium")
			end

			miMainFormatSizeChecked.set_checked (True)
			miContextFormatSizeChecked.set_checked (True)

			rich_text_box.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (currentFontFamily, fontSize))
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












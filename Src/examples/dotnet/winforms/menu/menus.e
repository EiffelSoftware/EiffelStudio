indexing
	description: ""

class
	MENU

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
			mi_file, mi_format: WINFORMS_MENU_ITEM
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

			-- Add File Menu
			mi_file := main_menu.get_menu_items.add (("&File").to_cil)
			dummy := mi_file.get_menu_items.add_menu_item (create {WINFORMS_MENU_ITEM}.make_from_text_and_on_click_and_shortcut (("&Open...").to_cil, create {EVENT_HANDLER}.make (Current, $FileOpen_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_O))
			dummy := mi_file.get_menu_items.add (("-").to_cil)     --  Gives us a seperator
			dummy := mi_file.get_menu_items.add_menu_item (create {WINFORMS_MENU_ITEM}.make_from_text_and_on_click_and_shortcut (("E&xit").to_cil, create {EVENT_HANDLER}.make (Current, $FileExit_Clicked), feature {WINFORMS_SHORTCUT}.ctrl_X))

			-- Add Format Menu
			mi_format := main_menu.get_menu_items.add (("F&ormat").to_cil)

			-- Font Face sub-menu
			create mmi_sans_serif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&1. ").to_cil, sans_serif_font_family.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			mmi_sans_serif.set_checked (True) 
			mmi_sans_serif.set_default_item (True) 
			create mmi_serif.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&2. ").to_cil, serif_font_family.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))
			create mmi_mono_space.make_from_text_and_on_click ((("").to_cil).concat_string_string (("&3. ").to_cil, mono_space_font_family.get_name), create {EVENT_HANDLER}.make (Current, $FormatFont_Clicked))

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mmi_sans_serif)
			l_array_menu_item.put (1, mmi_serif)
			l_array_menu_item.put (2, mmi_mono_space)
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Face").to_cil, l_array_menu_item)

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
			dummy := mi_format.get_menu_items.add_string_menu_item_array (("Font &Size").to_cil, l_array_menu_item)

			-- Add Format to label context menu
			-- Note have to add a clone because menus can't belong to 2 parents
			dummy := label_1_context_menu.get_menu_items.add_menu_item (mi_format.clone_menu)

			--  Set up the context menu items - we use these to check and uncheck items
			cmi_sans_serif := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (0)
			cmi_serif := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (1)
			cmi_mono_space := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (0).get_menu_items.get_item (2)
			cmi_small := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (0)
			cmi_medium := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (1)
			cmi_large := label_1_context_menu.get_menu_items.get_item (0).get_menu_items.get_item (1).get_menu_items.get_item (2)

			-- We use these to track which menu items are checked
			-- This is made more complex because we have both a menu and a context menu
			mi_main_format_font_checked := mmi_sans_serif
			mi_main_format_size_checked := mmi_medium
			mi_context_format_font_checked := cmi_sans_serif
			mi_context_format_size_checked := cmi_medium

			dummy := my_window.show_dialog
		end


feature -- Access

	my_window: WINFORMS_FORM
			-- Main window.

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	label_1: WINFORMS_LABEL
			-- System.Windows.Forms.Label.

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu.

	label_1_context_menu: WINFORMS_CONTEXT_MENU
			-- System.Windows.Forms.ContextMenu.

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
			create main_menu.make
			create label_1.make
			create label_1_context_menu.make

			my_window.set_text (("Menus 'R Us").to_cil)
			l_size.make_from_width_and_height (5, 13)
			my_window.set_auto_scale_base_size (l_size)
			l_size.make_from_width_and_height (392, 117)
			my_window.set_client_size_size (l_size)
			create main_menu.make
			my_window.set_menu (main_menu)

			label_1.set_back_color (feature {DRAWING_COLOR}.get_light_steel_blue)
			l_point.make_from_x_and_y (16, 24)
			label_1.set_location (l_point)
			label_1.set_tab_index (0)
			--label_1.set_anchor = (System.Windows.Forms.AnchorStyles) 13
			l_size.make_from_width_and_height (360, 50)
			label_1.set_size (l_size)
			label_1.set_text (("Right Click on me - I have a context menu!").to_cil)
			label_1.set_context_menu (label_1_context_menu)
			
			my_window.get_controls.add (label_1)
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

	FileExit_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Exit Menu item handler
		do
			my_window.close
		end

	FileOpen_Clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Open Menu item handler
		local
			dummy: WINFORMS_DIALOG_RESULT
		do
			dummy := feature {WINFORMS_MESSAGE_BOX}.show (("And why would this open a file?").to_cil)
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

			label_1.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (current_font_family, fontSize))
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

			font_size_string := mi_clicked.get_text

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

			label_1.set_font (create {DRAWING_FONT}.make_from_family_and_em_size (current_font_family, fontSize))
		end



end -- Class MENU



indexing
	description: "MDI Document"

class
	DOCUMENT

inherit 
	WINFORMS_FORM
		rename
			make as make_form
		redefine
			dispose_boolean
		end

	ANY

create
	make_with_name

feature {NONE} -- Initialization

	make_with_name (doc_name: SYSTEM_STRING) is
			--| Call `initialize_component'.
			--| Set parameters of form.
			-- Initialization routine.
		require
			non_void_doc_name: doc_name /= Void
		local
			mi_file, mi_format, mi_doc: WINFORMS_MENU_ITEM
			l_array_menu_item: NATIVE_ARRAY [WINFORMS_MENU_ITEM]
			l_text: STRING
			res: SYSTEM_OBJECT
		do
			initialize_component

				--  Initialize Fonts - use generic fonts to avoid problems across
				--  different versions of the OS
			create mono_space_font_family.make ({DRAWING_GENERIC_FONT_FAMILIES}.monospace)
			create sans_serif_font_family.make ({DRAWING_GENERIC_FONT_FAMILIES}.sans_serif)
			create serif_font_family.make ({DRAWING_GENERIC_FONT_FAMILIES}.serif)
			current_font_family := sans_serif_font_family

			set_text (doc_name)

			check
				non_void_rich_text_box: rich_text_box /= Void
			end
			rich_text_box.set_font (create {DRAWING_FONT}.make (current_font_family, font_size))
			rich_text_box.set_text (doc_name)

				-- Add File Menu
			mi_file := main_menu.menu_items.add ("&File")
			mi_file.set_merge_type ({WINFORMS_MENU_MERGE}.merge_items)
			mi_file.set_merge_order (0)

			l_text := "&Load Document ("
			l_text.append (doc_name)
			l_text.append (")")
			mi_doc := main_menu.menu_items.add (l_text, create {EVENT_HANDLER}.make (Current, $on_load_document_clicked))
			mi_doc.set_merge_order (105)

				-- Add Formatting Menu
			l_text := "F&ormat ("
			l_text.append (doc_name)
			l_text.append (")")
			mi_format := main_menu.menu_items.add (l_text)
			mi_format.set_merge_type ({WINFORMS_MENU_MERGE}.add)
			mi_format.set_merge_order (5)

				-- Font Face sub-menu
			l_text := "&1. "
			l_text.append (sans_serif_font_family.name)
			create mi_sans_serif.make (l_text, create {EVENT_HANDLER}.make (Current, $on_format_font_clicked))
			l_text := "&2. "
			l_text.append (serif_font_family.name)
			create mi_serif.make (l_text, create {EVENT_HANDLER}.make (Current, $on_format_font_clicked))
			l_text := "&3. "
			l_text.append (mono_space_font_family.name)
			create mi_mono_space.make (l_text, create {EVENT_HANDLER}.make (Current, $on_format_font_clicked))
			mi_sans_serif.set_checked (True)
			mi_format_font_checked := mi_sans_serif
			mi_sans_serif.set_default_item (True) 

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mi_sans_serif)
			l_array_menu_item.put (1, mi_serif)
			l_array_menu_item.put (2, mi_mono_space)
			res := mi_format.menu_items.add ("Font &Face", l_array_menu_item)

				-- Font Size sub-menu
			create mi_small.make ("&Small", create {EVENT_HANDLER}.make (Current, $on_format_size_clicked))
			create mi_medium.make ("&Medium", create {EVENT_HANDLER}.make (Current, $on_format_size_clicked))
			create mi_large.make ("&Large", create {EVENT_HANDLER}.make (Current, $on_format_size_clicked))
			mi_medium.set_checked (True)
			mi_format_size_checked := mi_medium
			mi_medium.set_default_item (True)

			create l_array_menu_item.make (3)
			l_array_menu_item.put (0, mi_small)
			l_array_menu_item.put (1, mi_medium)
			l_array_menu_item.put (2, mi_large)
			res := mi_format.menu_items.add ("Font &Size", l_array_menu_item)

			show
		ensure
			non_void_mono_space_font_family: mono_space_font_family /= Void
			non_void_sans_serif_font_family: sans_serif_font_family /= Void
			non_void_serif_font_family: serif_font_family /= Void
			non_void_rich_text_box: rich_text_box /= Void
		end

feature -- Access

	components: SYSTEM_DLL_SYSTEM_CONTAINER
			-- System.ComponentModel.Container.

	rich_text_box: WINFORMS_RICH_TEXT_BOX
			-- System.Windows.Forms.RichTextBox.

	main_menu: WINFORMS_MAIN_MENU
			-- System.Windows.Forms.MainMenu.

	font_size: DOUBLE
			-- Font face and size.

	mi_format_font_checked,
	mi_format_size_checked,
	mi_small,
	mi_medium,
	mi_large,
	mi_sans_serif,
	mi_serif,
	mi_mono_space : WINFORMS_MENU_ITEM
			-- System.Windows.Forms.MenuItem.
			
	current_font_family,
	mono_space_font_family,
	sans_serif_font_family,
	serif_font_family: DRAWING_FONT_FAMILY
			-- System.Windows.Forms.FontFamily.

feature {NONE} -- Implementation

	initialize_component is
			-- Initialize all components of form.
		local
			l_size: DRAWING_SIZE
		do
			create components.make
			create rich_text_box.make
			create main_menu.make

			rich_text_box.set_text ("")
			l_size.make (292, 273)
			rich_text_box.set_size (l_size)
			rich_text_box.set_tab_index (0)
			rich_text_box.set_dock ({WINFORMS_DOCK_STYLE}.fill)

			set_text ("")
			l_size.make (5, 13)
			set_auto_scale_base_size (l_size)
			l_size.make (392, 117)
			set_client_size (l_size)
			create main_menu.make
			set_menu (main_menu)

			-- Set default font size to Medium.
			font_size := font_sizes ("Medium")
			
			controls.add (rich_text_box)		
		ensure
			non_void_components: components /= Void
			non_void_main_menu: main_menu /= Void
			non_void_rich_text_box: rich_text_box /= Void
		end

feature {NONE} -- Implementation

	dispose_boolean (a_disposing: BOOLEAN) is
			-- method called when form is disposed.
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
			retried := true
			retry
		end

	font_sizes (a_size: STRING): DOUBLE is
			-- Return size correspondind to `a_size'.
		require
			non_void_a_size: a_size /= Void
			not_empty_a_size: not a_size.is_empty
			valid_size: a_size.is_equal ("Small") or a_size.is_equal ("Medium") or a_size.is_equal ("Large")
		do
			if a_size.is_equal ("Small") then
				Result := 8
			elseif a_size.is_equal ("Medium") then
				Result := 12
			elseif a_size.is_equal ("Large") then
				Result := 24
			end
		end

	on_load_document_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- File->Load Document Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local
			res: WINFORMS_DIALOG_RESULT
		do
			res := {WINFORMS_MESSAGE_BOX}.show (text)
		end

	on_format_font_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Font Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local
			mi_clicked: WINFORMS_MENU_ITEM
		do
			mi_clicked ?= sender

			mi_clicked.set_checked (True)
			mi_format_font_checked.set_checked (False)
			mi_format_font_checked := mi_clicked

			if mi_clicked.equals (mi_sans_serif) then
				current_font_family := sans_serif_font_family
			elseif mi_clicked.equals (mi_serif) then
				current_font_family := serif_font_family
			else
				current_font_family := mono_space_font_family
			end

			rich_text_box.set_font (create {DRAWING_FONT}.make (current_font_family, font_size))
		end

	on_format_size_clicked (sender: SYSTEM_OBJECT args: EVENT_ARGS) is
			-- Format->Size Menu item handler.
		require
			non_void_sender: sender /= Void
			non_void_args: args /= Void
		local
			mi_clicked: WINFORMS_MENU_ITEM
			font_size_string: SYSTEM_STRING
		do
			mi_clicked ?= sender

			mi_clicked.set_checked (True)
			mi_format_size_checked.set_checked (False)
			mi_format_size_checked := mi_clicked

			font_size_string := mi_clicked.text
			if ("&Small").is_equal (font_size_string) then
				font_size := font_sizes ("Small")
			elseif ("&Large").is_equal (font_size_string) then
				font_size := font_sizes ("Large")
			else
				font_size := font_sizes ("Medium")
			end

			rich_text_box.set_font (create {DRAWING_FONT}.make (current_font_family, font_size))
		end

invariant
	non_void_components: components /= Void
	non_void_main_menu: main_menu /= Void
	non_void_rich_text_box: rich_text_box /= Void
	non_void_mono_space_font_family: mono_space_font_family /= Void
	non_void_sans_serif_font_family: sans_serif_font_family /= Void
	non_void_serif_font_family: serif_font_family /= Void
	non_void_rich_text_box: rich_text_box /= Void

end -- Class DOCUMENT












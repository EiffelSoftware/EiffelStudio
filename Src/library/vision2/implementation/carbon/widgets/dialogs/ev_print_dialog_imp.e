
indexing
	description: "Eiffel Vision print dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I
		redefine
			interface,
			print_context
		end

	EV_STANDARD_DIALOG_IMP
		undefine
			internal_accept
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window with a parent.
		do
			base_make (an_interface)
			set_c_object ($current) -- c_object must be set (contract)
		end

	printer_rdo, file_rdo, all_rdo, range_rdo,
	selection_rdo, portrait_rdo, landscape_rdo: EV_RADIO_BUTTON
	printer_txt, file_txt: EV_TEXT_FIELD
	from_spn, to_spn, copies_spn: EV_SPIN_BUTTON
	pixmap: EV_PIXMAP
	def_pix_imp: EV_STOCK_PIXMAPS_IMP
	collate_chk: EV_CHECK_BUTTON
	print_btn, cancel_btn: EV_BUTTON

	initialize is
				-- Setup window and action sequences.
		local
			printer_frame, range_frame, copies_frame, orientation_frame, page_type_frame: EV_FRAME
			main_dialog_container, printer_vbox1, printer_vbox2,
			range_vbox, copies_vbox: EV_VERTICAL_BOX
			printer_hbox, frame_container, range_hbox, copies_hbox1,
			copies_hbox2, orientation_hbox, button_hbox, page_type_hbox: EV_HORIZONTAL_BOX
			print_btn_imp, cancel_btn_imp: EV_BUTTON_IMP
			hbox: POINTER
			container_imp: EV_CONTAINER_IMP
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_title ("Print")
			set_is_initialized (False)
--			hbox := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
--			{EV_GTK_EXTERNALS}.gtk_widget_show (hbox)
--			{EV_GTK_EXTERNALS}.gtk_container_add (client_area_from_c_object (c_object), hbox)
			create main_dialog_container
			main_dialog_container.set_padding (5)
			main_dialog_container.set_border_width (5)

			-- Build the 'Select Printer' frame
			create printer_hbox
			printer_hbox.set_border_width (5)
			create printer_vbox1
			create printer_rdo.make_with_text ("Printer")
			printer_vbox1.extend (printer_rdo)
			printer_rdo.select_actions.force_extend (agent set_output_to_printer)
			create file_rdo.make_with_text ("File")
			printer_vbox1.extend (file_rdo)
			printer_hbox.extend (printer_vbox1)
			file_rdo.select_actions.force_extend (agent set_output_to_file)
			create printer_vbox2
			create printer_txt.make_with_text ("a printer")
			printer_vbox2.extend (printer_txt)
			create file_txt.make_with_text ("a file")
			file_txt.disable_sensitive
			printer_vbox2.extend (file_txt)
			printer_hbox.extend (printer_vbox2)
			create printer_frame.make_with_text ("Select Printer")
			printer_frame.extend (printer_hbox)
			main_dialog_container.extend (printer_frame)

			-- Build the 'Page Range' frame and 'Copies' frame
			create range_vbox
			range_vbox.set_border_width (5)
			create all_rdo.make_with_text ("All pages")
			range_vbox.extend (all_rdo)
			all_rdo.select_actions.force_extend (agent range_spin_buttons_disable_sensitive)
			create range_hbox
			create range_rdo.make_with_text ("Range")
			range_hbox.extend (range_rdo)
			range_rdo.select_actions.force_extend (agent range_spin_buttons_enable_sensitive)
			range_hbox.extend (create {EV_LABEL}.make_with_text ("from "))
			create from_spn.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 1))
			from_spn.change_actions.force_extend (agent from_spin_button_value_change)
			range_hbox.extend (from_spn)
			range_hbox.extend (create {EV_LABEL}.make_with_text ("to "))
			create to_spn.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 1))
			to_spn.change_actions.force_extend (agent to_spin_button_value_change)
			range_hbox.extend (to_spn)
			range_vbox.extend (range_hbox)
			create selection_rdo.make_with_text ("Selection")
			range_vbox.extend (selection_rdo)
			selection_rdo.select_actions.force_extend (agent range_spin_buttons_disable_sensitive)
			range_vbox.merge_radio_button_groups (range_hbox)
			range_spin_buttons_disable_sensitive
			create range_frame.make_with_text ("Page Range")
			range_frame.extend (range_vbox)
			create frame_container
			frame_container.set_padding (5)
			frame_container.extend (range_frame)
			create copies_vbox
			copies_vbox.set_border_width (5)
			create copies_hbox1
			copies_hbox1.extend (create {EV_LABEL}.make_with_text ("Number of copies "))
			create copies_spn.make_with_value_range (create {INTEGER_INTERVAL}.make (1, 9999))
			copies_spn.set_minimum_width (52)
			copies_hbox1.extend (copies_spn)
			copies_vbox.extend (copies_hbox1)
			create copies_hbox2
			create def_pix_imp
			create pixmap.make_with_size (def_pix_imp.Collate_pixmap.width, def_pix_imp.Collate_pixmap.height)
			copies_hbox2.extend (pixmap)
			pixmap.draw_pixmap (0, 0, def_pix_imp.No_collate_pixmap)
			create collate_chk.make_with_text ("Collate")
			collate_chk.select_actions.force_extend (agent toggle_collate_pages)
			copies_hbox2.extend (collate_chk)
			copies_vbox.extend (copies_hbox2)
			create copies_frame.make_with_text ("Copies")
			copies_frame.extend (copies_vbox)
			frame_container.extend (copies_frame)
			main_dialog_container.extend (frame_container)

			-- Build the 'Orientation' frame
			create orientation_hbox
			orientation_hbox.extend (def_pix_imp.Portrait_pixmap)
			create portrait_rdo.make_with_text ("Portrait")
			orientation_hbox.extend (portrait_rdo)
			orientation_hbox.extend (def_pix_imp.Landscape_pixmap)
			create landscape_rdo.make_with_text ("Landscape")
			orientation_hbox.extend (landscape_rdo)
			create orientation_frame.make_with_text ("Orientation")
			orientation_frame.extend (orientation_hbox)
			main_dialog_container.extend (orientation_frame)

			-- Build the 'Page_type' frame.
			create page_type_frame.make_with_text ("Page Type")
			create page_type_hbox
			page_type_hbox.set_border_width (4)
			create page_type_combo.make_with_strings (<<Letter, Legal, Executive, Ledger, A4, A5, B5, C5>>)
			page_type_combo.set_minimum_width (100)
			page_type_hbox.extend (page_type_combo)
			page_type_hbox.disable_item_expand (page_type_combo)
			page_type_combo.disable_edit
			page_type_frame.extend (page_type_hbox)
			main_dialog_container.extend (page_type_frame)


			-- Add separator and buttons
			main_dialog_container.extend (create {EV_HORIZONTAL_SEPARATOR})
			create button_hbox
			button_hbox.set_padding (5)
			button_hbox.extend (create {EV_CELL})
			create print_btn.make_with_text ("Print")
			print_btn.set_minimum_width (100)
			button_hbox.extend (print_btn)
			create cancel_btn.make_with_text ("Cancel")
			cancel_btn.set_minimum_width (100)
			button_hbox.extend (cancel_btn)
			button_hbox.disable_item_expand (print_btn)
			button_hbox.disable_item_expand (cancel_btn)
			main_dialog_container.extend (button_hbox)

			container_imp ?= main_dialog_container.implementation
--			{EV_GTK_EXTERNALS}.gtk_container_add (hbox, container_imp.c_object)

			cancel_btn.select_actions.extend (agent on_cancel)
			print_btn.select_actions.extend (agent on_ok)
			print_btn_imp ?= print_btn.implementation
			print_btn_imp.enable_can_default
			cancel_btn_imp ?= cancel_btn.implementation
			cancel_btn_imp.enable_can_default
--			{EV_GTK_EXTERNALS}.gtk_widget_grab_default (print_btn_imp.visual_widget)
			enable_closeable
			minimum_from_page := 1
			maximum_to_page := 1
			forbid_resize
			set_is_initialized (True)
		end


	set_output_to_printer is
			-- enable/disable appropriate text fields
		do
			file_txt.disable_sensitive
			printer_txt.enable_sensitive
		end

	set_output_to_file is
			-- enable/disable appropriate text fields
		do
			printer_txt.disable_sensitive
			file_txt.enable_sensitive
		end

	range_spin_buttons_enable_sensitive is
			-- Enable spin buttons for range selection
		do
			from_spn.enable_sensitive
			to_spn.enable_sensitive
		end

	from_spin_button_value_change is
			-- Reset max and min values of 'to' button when input changes
		do
			if from_spn.value > to_spn.value then
				to_spn.set_value (from_spn.value)
			end
		end

	to_spin_button_value_change is
			-- Reset max and min values of 'from' button when input changes
		do
			if to_spn.value < from_spn.value then
				from_spn.set_value (to_spn.value)
			end
		end

	range_spin_buttons_disable_sensitive is
			-- Disable spin buttons for range selection
		do
			from_spn.disable_sensitive
			to_spn.disable_sensitive
		end

	toggle_collate_pages is
			-- toggle collate status pixmap
		do
			if collate_chk.is_selected then
				pixmap.draw_pixmap (0, 0, def_pix_imp.Collate_pixmap)
			else
				pixmap.draw_pixmap (0, 0, def_pix_imp.No_collate_pixmap)
			end
			pixmap.flush
		end

feature -- Access

	print_context: EV_PRINT_CONTEXT is
			-- Return a print context from the dialog
		local
			pspc: EV_POSTSCRIPT_PAGE_CONSTANTS
			page_constant: INTEGER
		do
			Result := Precursor {EV_PRINT_DIALOG_I}

				-- Set the vertical and horizontal resolutions.
			create pspc
			page_constant := pspc.Letter

			if page_type_combo.text.is_equal (Letter) then
				page_constant := pspc.Letter
			elseif page_type_combo.text.is_equal (Legal) then
				page_constant := pspc.Legal
			elseif page_type_combo.text.is_equal (Executive) then
				page_constant := pspc.Executive
			elseif page_type_combo.text.is_equal (Ledger) then
				page_constant := pspc.Ledger
			elseif page_type_combo.text.is_equal (A4) then
				page_constant := pspc.A4
			elseif page_type_combo.text.is_equal (A5) then
				page_constant := pspc.A5
			elseif page_type_combo.text.is_equal (B5) then
				page_constant := pspc.B5
			elseif page_type_combo.text.is_equal (C5) then
				page_constant := pspc.C5envelope
			end

			Result.set_horizontal_resolution (pspc.page_width (page_constant, landscape_checked) - (2 * pspc.Default_left_margin))
			Result.set_vertical_resolution (pspc.page_height (page_constant, landscape_checked) - (2 * pspc.Default_bottom_margin))
		end

	from_page: INTEGER is
			-- Value for the starting page edit control
		do
			Result := from_spn.value
		end

	to_page: INTEGER is
			-- Value for the ending page edit control
		do
			Result := to_spn.value
		end

	copies: INTEGER is
			-- Number of copies for the Copies edit control
		do
			Result := copies_spn.value
		end

	output_file_name: STRING_32 is
			-- String representation of the path to output
			-- the printed area to.
		do
			Result := file_txt.text
		end

	printer_name: STRING_32 is
			-- String representation of the printer to output
			-- the printed area to.
		do
			Result := printer_txt.text
		end

feature -- Status report

	all_pages_selected: BOOLEAN is
			-- Is the "All pages" radio button selected?
		do
			Result := all_rdo.is_selected
		end

	page_numbers_selected: BOOLEAN is
			-- Is the "Page" radio button selected?
		do
			Result := range_rdo.is_selected
		end

	selection_selected: BOOLEAN is
			 -- Is the "Selection" radio button selected?
		do
			Result := selection_rdo.is_selected
		end

	page_numbers_enabled: BOOLEAN is
			-- Is the "Range" radio button enabled?
		do
			Result := range_rdo.is_sensitive
		end

	selection_enabled: BOOLEAN is
			-- Is the "Selection" radio button selected?
		do
			Result := selection_rdo.is_sensitive
		end

	collate_checked: BOOLEAN is
			-- Is the "Collate" check box checked?
		do
			Result := collate_chk.is_selected
		end

	print_to_file_enabled: BOOLEAN is
			-- Is the "File" radio button enabled?
		do
			Result := file_rdo.is_sensitive
		end

	print_to_file_shown: BOOLEAN is
			-- Is the "File" radio button visible?
		do
			Result := file_rdo.is_show_requested
		end

	print_to_file_checked: BOOLEAN is
			-- Is the "File" radio button checked?
		do
			Result := file_rdo.is_selected
		end

	landscape_checked: BOOLEAN is
			-- Is the "Landscape" radio button checked?
		do
			Result := landscape_rdo.is_selected
 		end

feature -- Status setting

	select_all_pages is
			-- Select the "All pages" radio button.
			-- Selected by default.
		do
			all_rdo.enable_select
		end

	select_page_numbers is
			-- Select the "Page numbers" radio button.
			-- By default, the "All pages" button is selected.
		do
			range_rdo.enable_select
		end

 	select_selection is
  			-- Select the "Selection" radio button.
			-- By default, the "All pages" button is selected.
		do
			selection_rdo.enable_select
		end

	enable_page_numbers is
			-- Enable the "Range" radio button.
		do
			range_rdo.enable_sensitive
		end

	disable_page_numbers is
			-- Disable the "Range" radio button.
		do
			range_rdo.disable_sensitive
		end

	enable_selection is
			-- Enable the "Selection" radio button.
		do
			selection_rdo.enable_sensitive
		end

	disable_selection is
			-- Disable the "Selection" radio button.
		do
			selection_rdo.disable_sensitive
		end

	check_collate is
                        -- Check the "Collate" check box.
		do
			collate_chk.enable_select
		end

	uncheck_collate is
			-- Uncheck the "Collate" check box.
		do
			collate_chk.enable_select
		end

	enable_print_to_file is
			-- Enable the "File" radio button.
		do
			file_rdo.enable_sensitive
			file_txt.enable_sensitive
		end

	disable_print_to_file is
			-- Disable the "File" radio button.
		do
			file_rdo.disable_sensitive
			file_txt.disable_sensitive
		end

	show_print_to_file is
			-- Show the "File" radio button.
		do
			file_rdo.show
			file_txt.show
		end

	hide_print_to_file is
			-- Hide the "File" radio button.
		do
			file_rdo.hide
			file_txt.hide
		end

	check_print_to_file is
			-- Check the "File" check box.
			-- By default, the "Printer" button is selected.
		do
			file_rdo.enable_select
		end

        uncheck_print_to_file is
			-- Uncheck the "File" check box.
			-- By default, the "Printer" button is selected.
		do
			printer_rdo.enable_select
		end

feature -- Element change

	set_from_page (value: INTEGER) is
			 -- Make `value' the new `from_page' number.
		do
			from_spn.set_value (value)
  		end

	set_to_page (value: INTEGER) is
			-- Make `value' the new `to_page' number.
		do
			to_spn.set_value (value)
		end

	set_copies (value: INTEGER) is
			-- Make `value' the new `copies' number.
		do
			copies_spn.set_value (value)
		end

	set_maximum_to_page (value: INTEGER) is
			-- Make `value' the new maximum `to_page' value.
		do
			from_spn.value_range.adapt (minimum_from_page |..| value)
			to_spn.value_range.adapt (minimum_from_page |..| value)
			maximum_to_page := value
		end

	set_minimum_from_page (value: INTEGER) is
			-- Make `value' the new minimum `from_page' value.
		do
			from_spn.value_range.adapt (value |..| maximum_to_page)
			to_spn.value_range.adapt (value |..| maximum_to_page)
			minimum_from_page := value
		end

feature {NONE} -- Implementation

	page_type_combo: EV_COMBO_BOX

	Letter: STRING is "Letter"
	Legal: STRING is "Legal"
	Executive: STRING is "Executive"
	Ledger: STRING is "Ledger"
	A4: STRING is "A4"
	A5: STRING is "A5"
	B5: STRING is "B5"
	C5: STRING is "C5"

	interface: EV_PRINT_DIALOG;

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




end -- class EV_PRINT_DIALOG_IMP


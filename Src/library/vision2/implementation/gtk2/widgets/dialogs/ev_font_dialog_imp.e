indexing
	description: "EiffelVision font selection dialog, implementation."
	status: "See notice at end of class"
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FONT_DIALOG_IMP

inherit
	EV_FONT_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make


feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect `interface' and initialize `c_object'.
		local
			a_cs: EV_GTK_C_STRING
		do
			base_make (an_interface)
			a_cs := "Font Selection Dialog"
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_font_selection_dialog_new (
						a_cs.item
					))
		end

	initialize is
			-- Initialize the dialog.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			real_signal_connect (
				gtk_font_selection_dialog_struct_ok_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).font_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				gtk_font_selection_dialog_struct_cancel_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).font_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			is_initialized := True
		end

feature -- Access

	font: EV_FONT is
			-- Current selected font.
		local
			font_imp: EV_FONT_IMP
			a_cs: EV_GTK_C_STRING
			a_utf8_ptr: POINTER
			font_desc: STRING
			font_names: ARRAYED_LIST [STRING]
			exit_loop: BOOLEAN
			split_values: LIST [STRING]
			selected_font_name: STRING
		do
			--| FIXME IEK Refactor this with default font code in EV_APPLICATION_IMP
			create Result
			font_imp ?= Result.implementation
			
			a_utf8_ptr := feature {EV_GTK_EXTERNALS}.gtk_font_selection_dialog_get_font_name (c_object)
			create a_cs.make_from_pointer (a_utf8_ptr)
			font_desc := a_cs.string.as_lower
			font_names := App_implementation.font_names_on_system
			
			from
				font_names.start
			until
				exit_loop or else font_names.after
			loop
				if font_desc.substring_index (font_names.item.as_lower, 1) = 1 then
					selected_font_name := font_names.item
					exit_loop := True
				end
				font_names.forth
			end
			
			font_imp.set_face_name (selected_font_name.twin)
			font_imp.preferred_families.extend (selected_font_name.twin)

			split_values := font_desc.split (' ')
			split_values.compare_objects
			font_imp.set_height_in_points (split_values.last.to_integer)
			
			if split_values.has ("italic") or else split_values.has ("oblique") then
				font_imp.set_shape (feature {EV_FONT_CONSTANTS}.shape_italic)
			else
				font_imp.set_shape (feature {EV_FONT_CONSTANTS}.shape_regular)
			end
			
			if split_values.has ("bold") then
				font_imp.set_weight (feature {EV_FONT_CONSTANTS}.weight_bold)
			elseif split_values.has ("light") then
				font_imp.set_weight (feature {EV_FONT_CONSTANTS}.weight_thin)
			elseif split_values.has ("superbold") then
				font_imp.set_weight (feature {EV_FONT_CONSTANTS}.weight_black)
			else
				font_imp.set_weight (feature {EV_FONT_CONSTANTS}.weight_regular)
			end		
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Select `a_font'.
		local
			a_success_flag: BOOLEAN
			font_imp: EV_FONT_IMP
			a_cs: EV_GTK_C_STRING
			a_font_des_str: POINTER
		do
			font_imp ?= a_font.implementation
			a_font_des_str := feature {EV_GTK_DEPENDENT_EXTERNALS}.pango_font_description_to_string (font_imp.font_description)
			if a_font_des_str /= default_pointer then
				create a_cs.make_from_pointer (a_font_des_str)
				feature {EV_GTK_EXTERNALS}.g_free (a_font_des_str)
			else
				create a_cs.make (font_imp.name + " " + font_imp.height_in_points.out)
			end
			a_success_flag := feature {EV_GTK_EXTERNALS}.gtk_font_selection_dialog_set_font_name (
							c_object,
							a_cs.item
						)
			check font_found: a_success_flag end
		end

feature {NONE} -- Implementation

	gtk_font_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_font_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_FONT_DIALOG	

end -- class EV_FONT_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


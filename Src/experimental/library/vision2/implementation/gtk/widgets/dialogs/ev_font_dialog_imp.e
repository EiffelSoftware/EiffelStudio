note
	description: "EiffelVision font selection dialog, implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			make
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Connect `interface' and initialize `c_object'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize the dialog.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := "Font Selection Dialog"
			set_c_object ({GTK}.gtk_font_selection_dialog_new (
						a_cs.item
					))
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
			set_is_initialized (True)
		end

feature -- Access

	font: EV_FONT
			-- Current selected font.
		local
			font_imp: detachable EV_FONT_IMP
			a_cs: EV_GTK_C_STRING
			a_utf8_ptr: POINTER
			font_desc: STRING_32
			font_names: ARRAYED_LIST [STRING_32]
			exit_loop: BOOLEAN
			split_values: LIST [STRING_32]
			selected_font_name: detachable STRING_32
			l_font_item: STRING_32
		do
			--| FIXME IEK Refactor this with default font code in EV_APPLICATION_IMP
			create Result
			font_imp ?= Result.implementation
			check font_imp /= Void then end

			a_utf8_ptr := {GTK}.gtk_font_selection_dialog_get_font_name (c_object)
			create a_cs.share_from_pointer (a_utf8_ptr)
			font_desc := a_cs.string.as_lower
			font_names := App_implementation.font_names_on_system

			from
				font_names.start
			until
				exit_loop or else font_names.after
			loop
				l_font_item := font_names.item
				if font_desc.substring_index (l_font_item.as_lower, 1) = 1 then
					if selected_font_name = Void or else font_names.item.count > selected_font_name.count then
						selected_font_name := l_font_item
					end
					exit_loop := selected_font_name.count = font_desc.count
						-- If the match is perfect then we exit, otherwise we keep looping for the best match.
				end
				font_names.forth
			end

			check selected_font_name /= Void then end
			font_imp.set_face_name (selected_font_name.twin)
			font_imp.preferred_families.extend (selected_font_name.twin)

			split_values := font_desc.split (' ')
			split_values.compare_objects
			font_imp.set_height_in_points (split_values.last.to_integer)

			if split_values.has ({STRING_32} "italic") or else split_values.has ({STRING_32} "oblique") then
				font_imp.set_shape ({EV_FONT_CONSTANTS}.shape_italic)
			else
				font_imp.set_shape ({EV_FONT_CONSTANTS}.shape_regular)
			end

			if split_values.has ({STRING_32} "bold") then
				font_imp.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			elseif split_values.has ({STRING_32} "light") then
				font_imp.set_weight ({EV_FONT_CONSTANTS}.weight_thin)
			elseif split_values.has ({STRING_32} "superbold") then
				font_imp.set_weight ({EV_FONT_CONSTANTS}.weight_black)
			else
				font_imp.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			end
		end

feature -- Element change

	set_font (a_font: EV_FONT)
			-- Select `a_font'.
		local
			a_success_flag: BOOLEAN
			font_imp: detachable EV_FONT_IMP
			a_cs: EV_GTK_C_STRING
			a_font_des_str: POINTER
		do
			font_imp ?= a_font.implementation
			check font_imp /= Void then end
			a_font_des_str := {GTK2}.pango_font_description_to_string (font_imp.font_description)
			if a_font_des_str /= default_pointer then
				create a_cs.make_from_pointer (a_font_des_str)
			else
				a_cs := font_imp.name + " " + font_imp.height_in_points.out
			end
			a_success_flag := {GTK}.gtk_font_selection_dialog_set_font_name (
							c_object,
							a_cs.item
						)
			check font_found: a_success_flag end
		end

feature {NONE} -- Implementation

	gtk_font_selection_dialog_struct_ok_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"ok_button"
		end

	gtk_font_selection_dialog_struct_cancel_button (a_c_struct: POINTER): POINTER
		external
			"C [struct <ev_gtk.h>] (GtkFontSelectionDialog): EIF_POINTER"
		alias
			"cancel_button"
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FONT_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_FONT_DIALOG_IMP

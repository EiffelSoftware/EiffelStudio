note
	description: "EiffelVision color selection dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
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

	old_make (an_interface: like interface)
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Connect action sequences to button signals.
		local
			a_cs: EV_GTK_C_STRING
		do
				-- Create the gtk object.
			a_cs := "Color selection dialog"
			set_c_object (
				{GTK}.gtk_color_chooser_dialog_new (
					a_cs.item, default_pointer
				)
			)
			{GTK2}.gtk_color_chooser_set_use_alpha (c_object, False)
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)
			enable_closeable
			set_is_initialized (True)
		end

feature -- Access

	color: EV_COLOR
			-- Currently selected color.
		local
			l_rgba_struct: POINTER
		do
			if user_clicked_ok then
				l_rgba_struct := {GTK}.c_gdk_rgba_struct_allocate
				{GTK2}.gtk_color_chooser_get_rgba (c_object, l_rgba_struct)
				create Result.make_with_rgb (
					{GTK}.gdk_rgba_struct_red (l_rgba_struct).truncated_to_real,
					{GTK}.gdk_rgba_struct_green (l_rgba_struct).truncated_to_real,
					{GTK}.gdk_rgba_struct_blue (l_rgba_struct).truncated_to_real
				)
				l_rgba_struct.memory_free
			elseif attached internal_set_color as l_internal_set_color then
				Result := l_internal_set_color.twin
			else
					-- Return default color.
				create Result
			end
		end

feature -- Element change

	set_color (a_color: EV_COLOR)
			-- Set `color' to `a_color'.
		local
			l_rgba_struct: POINTER
		do
			internal_set_color := a_color.twin
			l_rgba_struct := {GTK}.c_gdk_rgba_struct_allocate
			{GTK}.set_gdk_rgba_struct_red (l_rgba_struct, a_color.red_16_bit)
			{GTK}.set_gdk_rgba_struct_green (l_rgba_struct, a_color.green_16_bit)
			{GTK}.set_gdk_rgba_struct_blue (l_rgba_struct, a_color.blue_16_bit)
			{GTK2}.gtk_color_chooser_set_rgba (c_object, l_rgba_struct)
			l_rgba_struct.memory_free
		end

feature {NONE} -- Implementation

	internal_set_color: detachable EV_COLOR
		-- Color explicitly set with `set_color'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COLOR_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_COLOR_DIALOG_IMP

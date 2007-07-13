indexing
	description: "EV_SHADOW_DIALOG Windows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "dialog, dialogue, popup, window, shadow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SHADOW_DIALOG_IMP

inherit
	EV_WINDOW_IMP
		rename
			make as make_not_use_1
		undefine
			set_title,
			destroy,
			show_relative_to_window,
			is_displayed,
			show,
			compute_minimum_height,
			compute_minimum_size,
			on_destroy,
			on_size,
			default_style,
			on_show,
			set_x_position,
			process_message,
			has_title_bar,
			set_y_position,
			execute_resize_actions,
			title,
			class_name,
			set_position,
			minimize,
			maximize,
			class_style,
			default_ex_style
		select
			interface
		end

	EV_UNTITLED_DIALOG_IMP
		rename
			make as make_not_use_2,
			interface as interface_not_use
		redefine
			class_style,
			default_ex_style,
			new_class_name
		select
			minimize,
			maximize,
			make_not_use_2
		end
create
	make,
	make_with_real_dialog

feature {NONE} -- Initlization

	make (an_interface: EV_WINDOW) is
			-- Creation method
		do
			internal_class_name := new_class_name + "_AS_DIALOG"
			internal_icon_name := ""
			base_make (an_interface)
			make_top ("EV_SHADOW_DIALOG")
			create accel_list.make (10)
			apply_center_dialog := True
		end

feature {NONE} -- Implementation

	class_style: INTEGER is
			-- Redefine
		local
			l_win: WEL_WINDOWS_VERSION
		do
			Result := Precursor {EV_UNTITLED_DIALOG_IMP}
			create l_win
			if l_win.is_windows_xp_compatible then
				Result := Result | cs_dropshadow
			end
		end

	new_class_name: STRING_32 is
			-- Redefine
		do
			make_id
			Result := "EV_SHADOW_DIALOG_IMP"
		end

	default_ex_style: INTEGER_32 is
			-- Redefine
		do
			Result := Precursor {EV_UNTITLED_DIALOG_IMP}
			-- Ensure we hide title in task bar
			Result := Result | Ws_ex_toolwindow
		end

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



end

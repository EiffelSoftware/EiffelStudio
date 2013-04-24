note
	description: "button in a menu"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MENU_B_IMP

inherit

	MENU_B_I

	BUTTON_IMP
		redefine
			realized,
			set_text,
			text,
			width,
			height,
			unrealize,
			set_insensitive
		end
create
	make

feature {NONE} -- Initialization

	make (a_menu_b: MENU_B; man: BOOLEAN; oui_parent: MENU)
		local
			mp: MENU_PULL
		do
			create private_attributes
			text := a_menu_b.identifier
			parent ?= oui_parent.implementation
			mp ?= oui_parent
			attach_menu (mp)
			a_menu_b.set_font_imp (Current)
			managed := man
		end

feature -- Access

	associated_menu: MENU_PULL

	text: STRING

	width: INTEGER
		local
			system_font: WEL_SYSTEM_FONT
		do
			create system_font.make
			Result := (text.count + 1) * system_font.log_font.width
		end

	height: INTEGER
		local
			system_font: WEL_SYSTEM_FONT
		do
			create system_font.make
			Result := system_font.log_font.height
		end

feature -- Status setting

	set_text (new_text: STRING)
		do
			text := new_text
		end

	set_insensitive (flag: BOOLEAN)
			-- Set sensitivity of Current to reflect `flag'.
		do
			Precursor {BUTTON_IMP} (flag)
			if flag then
				associated_menu.set_insensitive
			else
				associated_menu.set_sensitive
			end
		end

feature -- Element change

	wel_set_text (a_text: STRING)
		do
		end;

	wel_disabled: BOOLEAN
		do
		end;

	realize
		do
			realized := True
		end

	unrealize
		do
			realized := false
		end

	wel_enable
			-- Enable current button.
		do
		end;

	wel_disable
			-- Disable current button.
		do
		end;


	wel_destroy
		do
		end

	realized: BOOLEAN

feature {NONE} -- Inapplicable

	default_style: INTEGER
		do
		end

	class_name: STRING
		do
		end

	process_notification (notification_code: INTEGER)
		do
		end

	attach_menu (a_menu: MENU_PULL)
		do
			associated_menu := a_menu
		end

	wel_hide, wel_set_focus, enable, disable, invalidate,
	wel_release_capture, wel_set_capture, wel_show
		do
		end

	wel_set_menu (wel_menu: WEL_MENU)
		do
		end

	wel_parent: WEL_COMPOSITE_WINDOW

	client_rect: WEL_RECT

	wel_shown, exists, enabled: BOOLEAN

	wel_children: LINKED_LIST [WEL_WINDOW]

	wel_set_width, wel_set_height, wel_set_x, wel_set_y (i:INTEGER) do end

	absolute_x, absolute_y, wel_width, wel_height, wel_x, wel_y: INTEGER

	wel_text: STRING_32

	resize, wel_move (new_width, new_height: INTEGER)
		do
		end

	set_z_order (flags: POINTER)
		do
		end

	wel_item: POINTER

	disable_default_processing
		do
		end

	wel_font: WEL_FONT

	wel_set_font (f:WEL_FONT)
		do
		end
note
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


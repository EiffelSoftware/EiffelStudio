indexing
    status: "See notice at end of class";
    date: "$Date$";
    revision: "$Revision$"

class
	MENU_PULL_WINDOWS

inherit
	PULLDOWN_WINDOWS
		redefine
			realize_current
		end

	MENU_PULL_I

	SIZEABLE_WINDOWS

creation
	make

feature -- Initialization

	make (a_pulldown: MENU_PULL; man: BOOLEAN; oui_parent: MENU) is
			-- Create a menu_pull.
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			check
				valid_parent: parent /= Void
			end
			managed := man
			text := a_pulldown.identifier
			!! menu_button.make (text, oui_parent)
			menu_button.attach_menu (a_pulldown)
		end

	realize_current is
			-- Realize current widget.
		local
			mp: MENU_WINDOWS
		do
			mp ?= parent
			if mp /= Void and then mp.realized then
				mp.add_a_child (Current)
				associated_shell.wel_draw_menu
			end
			realized := True
		end

	create is
			-- Create the menu.
		do
			wel_make
		end

feature -- Element change

	insert_button (b: BUTTON_WINDOWS; b_id: INTEGER) is
			-- Insert a button in the menu.
		require
			button_not_void: b /= Void
		do
			insert_string (b.text, index_of (b) - unmanaged_count (b) - 1, b_id)
		end

	set_text (t: STRING) is
			-- Set `text' to `t'
		do
			text := t
			menu_button.set_text (t)
		end

	manage_separator (s: SEPARATOR_WINDOWS) is
			-- manage separator 's'.
		do
			-- To be implemented XXX
		end

feature {NONE} -- Implementation

	unmanaged_count (w: WIDGET_WINDOWS): INTEGER is
			-- Number of unmanaged widgets in the list before `w'.
		require
			widget_not_void: w /= Void
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
		do
			c := children_list
			from
				c.start
				c.search (w)
			until
				c.after
			loop
				if not c.item.managed then
					Result := Result + 1
				end
				c.forth
			end
		end

	index_of (w: WIDGET_WINDOWS): INTEGER is
			-- The index of the button `b' in the `button_list'.
		require
			widget_not_void: w /= Void
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
		do
			c := children_list
			c.start
			c.search (w)
			Result := c.count - c.index + 1
		end

	set_default_size is
			-- Useless here
		do
		end

	text: STRING 

end -- class MENU_PULL_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

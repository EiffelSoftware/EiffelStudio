indexing
	description: "Menus with a windows implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	MENU_WINDOWS

inherit
	WEL_MENU
		rename
			item as wel_item,
			make as wel_make,
			main_args as menu_main_args,
			popup_menu as wel_submenu
		export
			{MENU_WINDOWS} destroy_item
		end;

	MANAGER_WINDOWS
		rename
			unrealize as composite_unrealize
		redefine
			set_managed,
			realized
		end

	MANAGER_WINDOWS
		redefine
			set_managed,
			unrealize,
			realized
		select
			unrealize
		end

feature {NONE} -- Initialization

	realize_current is
			-- Realize current widget.
		do
			associated_root ?= parent
			realized := True
		end

feature -- Access

	associated_root: ROOT_MENU_WINDOWS
			-- The root of the menu

feature -- Status report

	checked_widget (widget: TOGGLE_B_WINDOWS): BOOLEAN is
		do
			Result := widget.state
		end

	disabled: BOOLEAN is
			-- Is current menu disabled?
		do
		end

	realized: BOOLEAN
			-- Is current menu realized

feature -- Status setting

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		local
			m: MENU_WINDOWS
		do
			if realized then
				if parent /= Void and parent.realized and then parent.exists then
					if not managed and then flag then
						managed := flag
						m ?= parent
						m.manage_item (Current)
					elseif managed and then not flag then
						managed := flag
						m ?= parent
						m.unmanage_item (Current)
					end
				end
				managed := flag
			else
				managed := flag
				realize
			end
		end

	check_widget (widget: TOGGLE_B_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				check_item (id)
			end
		end

	uncheck_widget (widget: TOGGLE_B_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				uncheck_item (id)
			end
		end

	enable_widget (widget: WIDGET_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				enable_item (id)
			end
		end

	disable_widget (widget: WIDGET_WINDOWS) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				disable_item (id)
			end
		end

	put_children_in_menu is
			-- Put the children back in the menu when
			-- item is managed.
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
		do
			c := children_list
			from
				c.start
			until
				c.after
			loop
				add_a_child (c.item)
				c.forth
			end
		end

	add_a_child (widget: WIDGET_WINDOWS) is
			-- Add `widget' to the menu.
		require
			menu_realized: realized
		local
			button: BUTTON_WINDOWS
			toggle_b: TOGGLE_B_WINDOWS
			separator: SEPARATOR_WINDOWS
			pulldown: MENU_PULL_WINDOWS
			menu_b: MENU_BUTTON_WINDOWS
		do
			button ?= widget
			if button /= Void then
				menu_b ?= widget
				if menu_b = Void or menu_b.associated_menu = Void then
					if button.managed then
						if id_children.has (button) then
							associated_root.remove (id_children.item (button))
							id_children.remove (button)
						end
						associated_root.add (button)
						button.set_hash_code
						id_children.put (associated_root.value, button)
						append_string (button.text, associated_root.value)
					end
					toggle_b ?= widget
					if toggle_b /= Void and then toggle_b.managed then
						if toggle_b.state then
							check_item (associated_root.value)
						else
							uncheck_item (associated_root.value)
						end
					end
				end
			else
				separator ?= widget
				if separator /= Void and then separator.managed then
					append_separator
				else
					pulldown ?= widget
					if pulldown /= Void then
						pulldown.create
						if pulldown.managed then
							append_popup (pulldown, pulldown.menu_button.text)
						end
					else
						io.error.putstring ("Unknown type in menu ")
						io.error.putstring (widget.generator)
						io.error.new_line
					end
				end
			end
		end

feature -- Element change

	manage_item (w: WIDGET_WINDOWS) is
			-- Manage a item in the menu.
		local
			ba: BAR_WINDOWS
			mp: MENU_PULL_WINDOWS
			m: MENU_WINDOWS
			b: BUTTON_WINDOWS
			s: SEPARATOR_WINDOWS
		do
			b ?= w
			if b /= Void then
				mp ?= b.parent
				check
					parent_not_void: mp /= Void
				end
				associated_root.add (b)
				mp.insert_button (b, associated_root.value)
				b.set_hash_code
				id_children.put (associated_root.value, b)
			else
				s ?= w
				if s /= Void then
					mp ?= s.parent
					check
						parent_not_void: mp /= Void
					end
					-- ++ -- mp.manage_separator (s) -- ++ -- XXX To be Implemented
				else
					mp ?= w
					if mp /= Void then
						mp.create
						mp.put_children_in_menu
						m ?= w.parent
						m.insert_popup (mp, index_of (mp) -
								unmanaged_count (mp) - 1, mp.menu_button.text)
					end
				end
			end
			if associated_shell.has_menu then
				associated_shell.wel_draw_menu
			end
		end

	unmanage_item (w: WIDGET_WINDOWS) is
			-- Unmanage a item in the menu
		local
			ba: BAR_WINDOWS
			s: SEPARATOR_WINDOWS
			b: BUTTON_WINDOWS
			mp: MENU_PULL_WINDOWS
		do
			b ?= w
			if b /= Void then
				mp ?= b.parent
				check
					parent_not_void: mp /= Void
				end
				if b.parent.managed then
					delete_item (id_children.item (b))
				end
				associated_root.remove (id_children.item (b))
				id_children.remove (b)
			else
				s ?= w
				if s /= Void then
					-- Delete separator from menu XXX
				else
					ba ?= w.parent
					if ba /= Void then
						ba.remove_popup (w)
					else
						if w.parent.managed then
							cwin_delete_menu (wel_item, index_of (w) - unmanaged_count (w), Mf_byposition)
						end
					end
				end
			end
			if associated_shell.has_menu then
				associated_shell.wel_draw_menu
			end
		end

feature -- Removal

	unrealize is
			-- Unrealize current widget.
		do
			composite_unrealize
			realized := False
		end

feature {NONE} -- Implementation

	unmanaged_count (w: WIDGET_WINDOWS): INTEGER is
			-- Number of unmanaged widgets before `w'.
			--| Excluding MENU_BUTTON_WINDOWS because they
			--| come with MENU_PULL_WINDOWS
		require
			widget_not_void: w /= Void
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
			mb: MENU_BUTTON_WINDOWS
		do
			c := children_list
			from
				c.start
				c.search (w)
			until
				c.after
			loop
				mb ?= c.item
				if mb = Void then
					if not c.item.managed then
						Result := Result + 1
					end
				end
				c.forth
			end
		end

	index_of (w: WIDGET_WINDOWS): INTEGER is
			-- The index of the popup `w' in the `button_list'.
			--| Excluding MENU_BUTTON_WINDOWS because they
			--| come with MENU_PULL_WINDOWS
		require
			widget_not_void: w /= Void
			widget_in_list: children_list.has (w)
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
			mb: MENU_BUTTON_WINDOWS
			widget_found: BOOLEAN
		do
			from
				c := children_list
				c.finish
			until
				widget_found or else c.before
			loop
				if c.item = w then
					widget_found := True
				end
				mb ?= c.item
				if mb = Void then
					Result := Result + 1
				end
				c.back
			end
		end
			
	associated_shell: WM_SHELL_WINDOWS is
		local
			p : COMPOSITE_WINDOWS
		do
			from
				p := parent
				Result ?= p
			until
				Result /= Void or p = Void
			loop
				p := p.parent
				Result ?= p
			end
		ensure
			Result_exists: Result /= Void
		end

	id_children: HASH_TABLE [INTEGER, WIDGET_WINDOWS] is
			-- id in menu for a child
		once
			!! Result.make (5)
		ensure
			result_not_void: Result /= Void
		end

	id_of_child (w: WIDGET_WINDOWS): INTEGER is
			-- id of child `w'
		do
			if id_children /= Void then
				Result := id_children.item (w)
			end
		end

feature -- Inapplicable

	default_style: INTEGER is
		do
		end

	class_name: STRING is
		do
		end

	set_title (s: STRING) is
		do
			title := s
		end

	title: STRING

	remove_title is
		do
		end

	wel_hide, 
	wel_set_focus, 
	wel_destroy, 
	enable, 
	disable, 
	invalidate, 
	wel_release_capture, 
	wel_set_capture, 
	wel_show  is
		do
		end

	wel_set_text (s: STRING) is 
		do 
		end

	wel_set_menu (a_menu: WEL_MENU) is
		do
		end

	wel_parent: WEL_COMPOSITE_WINDOW is 
		do 
		end

	client_rect: WEL_RECT is 
		do 
		end

	wel_shown, 
	enabled: BOOLEAN is 
		do 
		end

	wel_children: LINKED_LIST [WEL_WINDOW]

	wel_set_width, 
	wel_set_height, 
	wel_set_x, 
	wel_set_y (i:INTEGER) is 
		do 
		end

	absolute_x, 
	absolute_y, 
	wel_width, 
	wel_height, 
	wel_x, 
	wel_y: INTEGER is 
		do 
		end

	wel_text: STRING is 
		do 
		end

	set_z_order (flags: INTEGER) is
		do
		end

	resize, 
	wel_move (new_width, new_height: INTEGER) is
		do
		end

	disable_default_processing is
		do
		end

end -- class MENU_WINDOWS

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

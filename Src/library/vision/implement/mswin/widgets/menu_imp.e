indexing
	description: "Menus with a windows implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$" 

class
	MENU_IMP

inherit
	WEL_MENU
		rename
			item as wel_item,
			make as wel_make,
			main_args as menu_main_args,
			popup_menu as wel_submenu
		export
			{MENU_IMP} destroy_item
		end;

	MANAGER_IMP
		redefine
			set_managed,
			unrealize,
			realized,
			realize_children,
			set_insensitive
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

	checked_widget (widget: TOGGLE_B_IMP): BOOLEAN is
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
			m: MENU_IMP
			opw: OPT_PULL_IMP
		do
			if realized then
				if parent /= Void and parent.realized and then parent.exists then
					managed := flag
					m ?= parent
					opw ?= parent
						-- The `parent' can be a descendant of `MENU_IMP', but
						-- also a `OPT_PULL_IMP', and there is no inheritance
						-- relationship when these lines are written. So we use the
						-- following workaround.
					if m /= Void then
						if not managed and then flag then
							m.manage_item (Current)
						elseif managed and then not flag then
							m.unmanage_item (Current)
						end
					elseif opw /= Void then
						if not managed and then flag then
							opw.manage_item (Current)
						elseif managed and then not flag then
							opw.unmanage_item (Current)
						end
					end
				end
				managed := flag
			else
				managed := flag
				realize
			end
		end

	set_insensitive (flag: BOOLEAN) is
			-- Set current widget in insensitive mode if `flag'. This means
			-- that any events with an event type of KeyPress,
			-- KeyRelease, ButtonPress, ButtonRelease, MotionNotify,
			-- EnterNotify, LeaveNotify, FocusIn or FocusOut will
			-- not be dispatched to current widget and to all its children.
			-- Set it to sensitive mode otherwise.
		local
			m: MENU_IMP
		do
			if exists then
				if parent /= Void and then parent.exists then
					m ?= parent
					m.set_insensitive_widget (Current, flag)
					m.invalidate
				end
			end
			private_attributes.set_insensitive (flag)
		end

	check_widget (widget: TOGGLE_B_IMP) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				check_item (id)
			end
		end

	uncheck_widget (widget: TOGGLE_B_IMP) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				uncheck_item (id)
			end
		end

	enable_widget (widget: WIDGET_IMP) is
		local
			id: INTEGER
		do
			id := id_of_child (widget)
			if id /= 0 then 
				enable_item (id)
			end
		end

	disable_widget (widget: WIDGET_IMP) is
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
			c: ARRAYED_LIST [WIDGET_IMP]
		do
			c := children_list
			from
				c.finish
			until
				c.before
			loop
				add_a_child (c.item)
				c.back
			end
		end

	add_a_child (widget: WIDGET_IMP) is
			-- Add `widget' to the menu.
		require
			menu_realized: realized
		local
			push_b: PUSH_B_IMP
			button: BUTTON_IMP
			toggle_b: TOGGLE_B_IMP
			separator: SEPARATOR_IMP
			pulldown: MENU_PULL_IMP
			menu_b: MENU_B_IMP
			menu_id: INTEGER
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
						push_b ?= button
						if push_b /= Void then
							if push_b.has_accelerator then
								menu_id := new_menu_id (10000 + push_b.private_text.hash_code \\ 50000)
								push_b.new_accelerator_id (menu_id)
								associated_root.add_with_id (button, menu_id)
							else
								associated_root.add (button)
								menu_id := associated_root.value
							end
						else
							associated_root.add (button)
							menu_id := associated_root.value
						end
						button.set_hash_code
						id_children.put (menu_id, button)
						append_string (button.text, menu_id)
					end
					toggle_b ?= widget
					if toggle_b /= Void and then toggle_b.managed then
						if toggle_b.state then
							check_item (associated_root.value)
						else
							uncheck_item (associated_root.value)
						end
						if toggle_b.has_accelerator then
							toggle_b.new_accelerator_id (associated_root.value)
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
						pulldown.create_menu
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

	set_insensitive_widget (w: WIDGET_IMP; flag: BOOLEAN) is
			-- Set a widget insensitive in the menu.
		do
			if flag then
				disable_position (index_of (w) - unmanaged_count(w) - 1)
			else
				enable_position (index_of (w) - unmanaged_count(w) - 1)
			end
		end

	manage_item (w: WIDGET_IMP) is
			-- Manage a item in the menu.
		local
			mp: MENU_PULL_IMP
			m: MENU_IMP
			b: BUTTON_IMP
			push_b: PUSH_B_IMP
			toggle_b: TOGGLE_B_IMP
			s: SEPARATOR_IMP
			menu_id: INTEGER
		do
			b ?= w
			if b /= Void then
				mp ?= b.parent
				check
					parent_not_void: mp /= Void
				end
				push_b ?= b
				if push_b /= Void then
					if push_b.has_accelerator then
						menu_id := new_menu_id (10000 + push_b.private_text.hash_code \\ 50000)
						push_b.new_accelerator_id (menu_id)
						associated_root.add_with_id (b, menu_id)
					else
						associated_root.add (b)
						menu_id := associated_root.value
					end
				else
					associated_root.add (b)
					menu_id := associated_root.value
					toggle_b ?= b
					if toggle_b /= Void then
						if toggle_b.has_accelerator then
							toggle_b.new_accelerator_id (menu_id)
						end
					end
				end
				mp.insert_button (b, menu_id)
				b.set_hash_code
				id_children.put (menu_id, b)
			else
				s ?= w
				if s /= Void then
					mp ?= s.parent
					check
						parent_not_void: mp /= Void
					end
					mp.insert_separator (index_of (s) - unmanaged_count (s) - 1)
				else
					mp ?= w
					if mp /= Void then
						mp.create_menu
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

	unmanage_item (w: WIDGET_IMP) is
			-- Unmanage a item in the menu
		local
			ba: BAR_IMP
			s: SEPARATOR_IMP
			b: BUTTON_IMP
			tb: TOGGLE_B_IMP
			pb: PUSH_B_IMP
			mp: MENU_PULL_IMP
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
				if associated_root /= Void then
					associated_root.remove (id_children.item (b))
				end
				id_children.remove (b)
				pb ?= b
				if pb /= Void then
					if pb.has_accelerator then
						pb.new_accelerator_id (-1)
					end
				else
					tb ?= b
					if tb /= Void then
						if tb.has_accelerator then
							tb.new_accelerator_id (-1)
						end
					end
				end
			else
				s ?= w
				if s /= Void then
					if w.parent.managed then
						delete_position (index_of (w) - unmanaged_count (w))
					end
				else
					ba ?= w.parent
					if ba /= Void then
						ba.remove_popup (w)
					else
						if w.parent.managed then
							delete_position (index_of (w) - unmanaged_count (w))
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
			Precursor
			realized := False
		end

feature {NONE} -- Implementation

	realize_children is
			-- Realize the children of Current.
		local
			local_children: ARRAYED_LIST [WIDGET_IMP]
		do
			local_children := children_list
			from
				local_children.finish
			variant
				local_children.index
			until
				local_children.before
			loop
				local_children.item.realize
				local_children.back
			end
		end

	unmanaged_count (w: WIDGET_IMP): INTEGER is
			-- Number of unmanaged widgets before `w'.
			--| Excluding MENU_BUTTON_IMPbecause they
			--| come with MENU_PULL_IMP
		require
			widget_not_void: w /= Void
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			mb: MENU_B_IMP
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

	index_of (w: WIDGET_IMP): INTEGER is
			-- The index of the popup `w' in the `button_list'.
			--| Excluding MENU_B_IMP because they
			--| come with MENU_PULL_IMP
		require
			widget_not_void: w /= Void
			widget_in_list: children_list.has (w)
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			mb: MENU_B_IMP
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
			
	associated_shell: WM_SHELL_IMP is
		local
			p : COMPOSITE_IMP
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

	id_children: HASH_TABLE [INTEGER, WIDGET_IMP] is
			-- id in menu for a child
		once
			!! Result.make (5)
		ensure
			result_not_void: Result /= Void
		end

	id_of_child (w: WIDGET_IMP): INTEGER is
			-- id of child `w'
		do
			if id_children /= Void then
				Result := id_children.item (w)
			end
		end

	new_menu_id (new_id: INTEGER): INTEGER is
			-- Starting from `new_id' find closest non used id.
			-- By default returns `new_id' if no already used.
		do
			if item_exists (new_id) then
				Result := new_menu_id (new_id + 1)
			else
				Result := new_id
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

	set_z_order (flags: POINTER) is
		do
		end

	resize, 
	wel_move (new_width, new_height: INTEGER) is
		do
		end

	disable_default_processing is
		do
		end

end -- class MENU_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


indexing 
	description: "This class represent a MS WINDOWS Window with children";
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
deferred class
	COMPOSITE_WINDOWS
  
inherit
	W_MAN_GEN

	WIDGET_WINDOWS
		redefine
			realize, 
			show,
			unrealize
		end

	COMPOSITE_I

feature -- Access

	popup_menu: POPUP_WINDOWS
			-- Menu of current composite

feature -- Status report

	children_count: INTEGER is
			-- Return the number of children
		do
			if exists then
				Result := wel_children.count
			end
		end

feature -- Status setting

	propagate_event is
			-- Propagate the events.
		do
		end

	set_no_event_propagation is
			-- Do not propagate the events.
		do
		end

feature -- Element change

	child_has_resized is
			-- Respond to a resize of a child.
		do
		end

	realize is
			-- Realize current widget and children.
		do
			if not realized then
				realize_current
				realize_children
				shown := true
			end
		end

	realize_current is
			-- Realize current composite without the children.
		require
			valid_parent: (parent /= Void) implies (parent.exists)
		deferred
		end

	show is
			-- Show composite.
		do
			if exists and then ((parent /= Void and then parent.wel_shown) or (parent = Void)) then 
				wel_show
				show_children
			end
			if parent = Void or else parent.shown then
				shown := True
			end
		end

	show_children is
			-- Show the children of current composite.
		local
			local_children: ARRAYED_LIST [WIDGET_WINDOWS]
			ww : WIDGET_WINDOWS
		do
			local_children := children_list
			from
				local_children.start
			variant
				local_children.count - local_children.index
			until
				local_children.off
			loop
				ww := local_children.item
				if ww.shown and not ww.wel_shown then
					ww.wel_show
				end
				local_children.forth
			end
		end

	realize_children is
			-- Realize the children of current composite.
		local
			local_children: ARRAYED_LIST [WIDGET_WINDOWS]
		do
			local_children := children_list
			from
				local_children.start
			variant
				local_children.count - local_children.index
			until
				local_children.after
			loop
				local_children.item.realize
				local_children.forth
			end
		end

	unrealize is
			-- Unrealize current composite and its children.
		local
			ww: WIDGET_WINDOWS
			wp, wi: WIDGET
			unrealize_list: LIST [WIDGET_WINDOWS]
		do
			unrealize_list := children_list
			from
				unrealize_list.start
			until
				unrealize_list.after
			loop
				if unrealize_list.item.realized then
					unrealize_list.item.unrealize
				end
				unrealize_list.forth
			end
			if exists then
				wel_destroy
			end
				-- This will destroy all children as well
		end

feature {WIDGET_WINDOWS} -- Implementation

	children: ARRAY [WIDGET_WINDOWS] is
			-- Array of children
		do
			Result := children_list
		end


	children_list: ARRAYED_LIST [WIDGET_WINDOWS] is
			-- List of children
		local
			widget_area: SPECIAL [WIDGET]
			position, wc: INTEGER;
			local_widget: WIDGET;
			wd, current_depth: INTEGER;
			finished: BOOLEAN;
			w_implementation: WIDGET_WINDOWS
			local_widget_oui: WIDGET
		do
			!! Result.make (10);
			widget_area := widget_manager.area
			wc := widget_manager.count;
			local_widget_oui := widget_oui
			from
				position := 0
			until
				position = wc or else widget_area.item (position).implementation = Current
			loop
				position := position + 1
			end
			current_depth := local_widget_oui.depth;
			from
				position := position + 1;
			until
				position = wc or else finished
			loop
				local_widget := widget_area.item (position);
				wd := local_widget.depth;
				if wd = current_depth + 1 then
					w_implementation ?= local_widget.implementation
					check
						valid_implementation: w_implementation /= Void
					end
					Result.extend (w_implementation)
				elseif wd <= current_depth then
					finished := True
				end;
				position := position + 1
			end
		ensure
			result_not_void: Result /= Void
		end

feature -- Implementation

	wel_children: LINKED_LIST [WEL_WINDOW] is
			-- List of implementation children
		deferred
		end

	wel_set_menu (a_menu: WEL_MENU) is
			-- Set `menu' with `a_menu'.
		deferred
		end

	associate_menu (a_menu: POPUP_WINDOWS) is
			-- Set the menu
		require
			a_menu_exists: a_menu /= Void
		do
			popup_menu := a_menu
		ensure then
			menu_set: popup_menu = a_menu
		end;

	remove_menu is
		do
			popup_menu := Void
		end

feature -- Behaviour

	on_draw_item (control_id: INTEGER; draw_item: WEL_DRAW_ITEM_STRUCT) is
			-- Wm_drawitem message.
			-- A owner-draw control identified by `control_id' has
			-- been changed and must be drawn. `draw_item' contains
			-- information about the item to be drawn and the type
			-- of drawing required.
		local
			odbw: OWNER_DRAW_BUTTON_WINDOWS
		do
			odbw ?= draw_item.window_item
			if odbw /= Void then
				odbw.on_draw (draw_item)
			end
		end

	on_menu_command (id_menu: INTEGER) is
			-- Respond to a menu command message.
		do
			popup_menu.execute (id_menu)
		end

feature {NONE} -- Implementation

	set_enclosing_size is
			-- Set the enclozing size.
		local
			c: ARRAYED_LIST [WIDGET_WINDOWS]
			i, maxxw, maxyh, tmp, w, h: INTEGER
			current_item: WIDGET_WINDOWS			
		do
			from 
				c := children_list
				c.start
			until
				c.after
			loop
				current_item := c.item
				if current_item /= Void and then current_item.managed then
					tmp := current_item.x + current_item.width
					if tmp > maxxw then
						maxxw := tmp
					end
					tmp := current_item.y + current_item.height
					if tmp > maxyh  then
						maxyh := tmp
					end
				end
				c.forth
			end
			w := private_attributes.width
			h := private_attributes.height
			if w < maxxw and then h < maxyh then 
				set_size (maxxw, maxyh)
			else
				if w < maxxw then set_width (maxxw) end
				if h < maxyh then set_height (maxyh) end
			end
		end

feature {NONE} -- Inaplicable

	circulate_down is
			-- Circulate the children down.
		do
		end

	circulate_up is
			-- Circulate the children up.
		do
		end

	restack_children (a_stackable_array: ARRAY [STACKABLE]) is
			-- Restack the children
		do
		end

	set_default_position (flag: BOOLEAN) is
			-- Set default position to `flag'
		do
		end

	is_stackable : BOOLEAN is
			-- Is current widget stackable?
		do
		end

end -- class COMPOSITE_WINDOWS 
 
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


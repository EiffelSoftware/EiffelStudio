indexing 
	status: "See notice at end of class."; 
	date: "$Date$";
	revision: "$Revision$"
 
class
	OVERRIDE_S_IMP
 
inherit 

	SHELL_IMP
		rename
			destroy as shell_destroy
		redefine
			child_has_resized,
			class_name,
			default_style,
			minimal_height,
			minimal_width,
			realized,
			realize_current,
			set_enclosing_size,
			unrealize,
			realize
		end

	SHELL_IMP
		redefine
			child_has_resized,
			class_name,
			default_style,
			destroy,
			minimal_height,
			minimal_width,
			realize_current,
			realized,
			set_enclosing_size,
			unrealize,
			realize
		select
			destroy
		end

	OVERRIDE_S_I

	GRABABLE_WINDOWS

create
	make

feature -- Initialization

	make (an_override_s: OVERRIDE_S; oui_parent: COMPOSITE) is
			-- Create the widget
		do
			create private_attributes
			parent ?= oui_parent.implementation
			shell_width := 2 * window_border_height
			shell_height := 2 * window_border_width
		end

	realize is
			-- Realize current widget and children.
		do
			if not realized then
				realize_current
				realize_children
			end
		end

	realize_current is
			-- Realize current widget.
		do
			make_top_with_coordinates ("", x, y, width + shell_width, height + shell_height)
			realized := True
		end

feature -- Status report

	is_popped_up: BOOLEAN is
			-- Is this widget popped up?
		do
			Result := exists and then shown
		end

	realized: BOOLEAN 
			-- Is this widget realized?

feature -- Status setting

	child_has_resized is
			-- Notification from child of size change
		do
			set_enclosing_size
		end

	destroy (wid_list: LINKED_LIST [WIDGET])is
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			shell_destroy (wid_list)
		end

	popup is
			-- Popup widget
		do
			if not exists then
				realize
			end
			wel_show
			shown := True
			if is_exclusive_grab then
				set_windows_insensitive
			end
			set_enclosing_size
		end

	popdown is
			-- Popdown widget
		do
			if insensitive_list /= Void then
				set_windows_sensitive
			end
			if exists then 
				wel_hide
				shown := False
			end
		end

	set_enclosing_size is
			-- Set the enclozing size.
		local
			c: ARRAYED_LIST [WIDGET_IMP]
			maxxw, maxyh, tmp: INTEGER
			current_item: WIDGET_IMP
		do
			if not fixed_size_flag then
				fixed_size_flag := True
				from 
					c := children_list
				c.start
				until
					c.after
				loop
					current_item := c.item
					if current_item /= Void then
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
				set_size (maxxw, maxyh)
				fixed_size_flag := False
			end
		end

	unrealize is 
		do
			realized := false
		end

	default_style: INTEGER is
			-- Default style
		once
			Result := Ws_border + Ws_popup -- Ws_visible + 
		end

	minimal_height, minimal_width: INTEGER is
		do
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionOverrideShell"
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




end -- OVERRIDE_S_IMP


note
	description: "Eiffel Vision viewport. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT_IMP

inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CELL_IMP
		redefine
			interface,
			make,
			replace,
			compute_minimum_width,
			compute_minimum_height,
			compute_minimum_size,
			ev_apply_new_size
		end

	OBJECTIVE_C
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Initialize.
		do
			base_make (an_interface)
			create scroll_view.new
			replace_content_view
			scroll_view.set_has_horizontal_scroller (False)
			scroll_view.set_has_vertical_scroller (False)
			scroll_view.set_draws_background (False)

			cocoa_item := scroll_view
		end

	replace_content_view
		local
			l_superclass: POINTER
			l_name: POINTER
			l_class: POINTER
			l_types: POINTER
			l_sel: POINTER
			l_imp: POINTER
			f: FUNCTION [like Current, TUPLE[], BOOLEAN]
			l_new_clip_view: NS_CLIP_VIEW
		do
			l_class := objc_get_class ((create {C_STRING}.make ("MyClipView")).item)
			if l_class = {NS_OBJECT}.nil then
				-- If MyClipView doesn't exist yet create it as a new child class of NSClipView and override isFlipped
				l_superclass := objc_get_class ((create {C_STRING}.make ("NSClipView")).item)
				l_name := (create {C_STRING}.make ("MyClipView")).item
				l_class := objc_allocate_class_pair (l_superclass, l_name, 0)

				l_types := (create {C_STRING}.make ("b@:")).item
				l_sel := sel_register_name ((create {C_STRING}.make ("isFlipped")).item)
				f := (agent is_flipped)
				l_imp := class_get_method_implementation(objc_get_class ((create {C_STRING}.make ("CustomView")).item), l_sel)
				class_add_method (l_class, l_sel, l_imp, l_types)

				objc_register_class_pair (l_class)
			end
			create l_new_clip_view.make_shared (class_create_instance (l_class, 0))
			l_new_clip_view.init
			scroll_view.set_content_view (l_new_clip_view)
		end

	is_flipped (a_target: POINTER; a_sel: POINTER): BOOLEAN
		do
			io.put_string ("123")
			Result := True
		end

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
--		do
--			Result := scroll_view.bounds.origin.x
--		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
--		do
--			Result := scroll_view.bounds.origin.y
--		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			v_imp: like item_imp
		do
			if item_imp /= void then
				on_removed_item (item_imp)
			end
			if v /= Void then
				v_imp ?= v.implementation
				v_imp.set_parent_imp (current)
				scroll_view.set_document_view (v_imp.cocoa_view)
				v_imp.ev_apply_new_size (0, 0, v_imp.width, v_imp.height, True)
				on_new_item (v_imp)
			end
			item := v
			ev_apply_new_size (x_position, y_position, width, height, False)
		end

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			scroll_view.content_view.scroll_to_point (create {NS_POINT}.make_point (a_x, y_offset))
			x_offset := a_x
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
			scroll_view.content_view.scroll_to_point (create {NS_POINT}.make_point (x_offset, a_y))
			y_offset := a_y
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			item_imp.parent_ask_resize (a_width, a_height)
		end

feature -- Layout

	compute_minimum_width, compute_minimum_height, compute_minimum_size
			-- Recompute both minimum_width and minimum_height of `Current'.
			-- Does nothing since it does not have a sense to compute it,
			-- it is only what the user set it to.
		do
			internal_set_minimum_size (minimum_width, minimum_height)
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			if attached item_imp then
				scroll_view.set_document_view (item_imp.cocoa_view)
				item_imp.ev_apply_new_size (0, 0, item_imp.width, item_imp.height, True)
			end
--			if a_width > 0 then -- Hack because I want to get EV_GAUGE working. TODO How/where/when should the resize actions be called?
--				on_size (a_width, a_height)
--			end
		end

	on_size (a_width, a_height: INTEGER)
		do
			if resize_actions_internal /= Void then
				resize_actions_internal.call ([screen_x, screen_y, a_width, a_height])
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

	scroll_view: NS_SCROLL_VIEW;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_VIEWPORT_IMP


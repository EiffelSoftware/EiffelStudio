note
	description:
		"EiffelVision Split Area. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			initialize
		end

	NS_SPLIT_VIEW_DELEGATE
		rename
			make as create_split_view_delegate,
			item as delegate_item
		redefine
			split_view_did_resize_subviews
		end

feature -- Access

	initialize
		do
			Precursor
			create_split_view_delegate
			split_view.set_delegate (current)
			first_expandable := True
			second_expandable := True
		end

	split_view_did_resize_subviews
		do
			split_view.adjust_subviews
		end

	set_first (v: like item)
			-- Make `an_item' `first'.
		local
			l_imp: EV_WIDGET_IMP
		do
			l_imp ?= v.implementation
			check l_imp_not_void: l_imp /= Void end
			first := v
			on_new_item (l_imp)
			disable_item_expand (first)
			cocoa_view.add_subview (l_imp.cocoa_view)

			if second_visible then
				set_split_position (minimum_split_position)
			else
				set_split_position (maximum_split_position)
			end
			notify_change (Nc_minsize, Current)
		end

	set_second (v: like item)
			-- Make `an_item' `second'.
		local
			l_imp: EV_WIDGET_IMP
		do
			v.implementation.on_parented
			l_imp ?= v.implementation
			check l_imp_not_void: l_imp /= Void end
			on_new_item (l_imp)
			second := v
			cocoa_view.add_subview (l_imp.cocoa_view)

			notify_change (Nc_minsize, Current)
			if first_visible then
				set_split_position (height - splitter_width - second.minimum_height.min
					(height - minimum_split_position - splitter_width))
			else
				set_split_position (0)
			end
				--| Notify change is called twice, as we need
				--| the sizing calculations performed once before
				--| we call set_split_position, so we can use `height'
				--| and be sure it is correct. Then we call notify change
				--| again after the split position has been set,
				--| to reflect these changes.
			notify_change (Nc_minsize, Current)
		end

	prune (an_item: like item)
			-- Remove `an_item' if present from `Current'.
		local
			an_item_imp: EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				an_item_imp ?= an_item.implementation
				an_item_imp.set_parent_imp (Void)
				check an_item_imp_not_void: an_item_imp /= Void end
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
				an_item_imp.cocoa_view.remove_from_superview
				notify_change (Nc_minsize, Current)
			end
		end

	enable_item_expand (an_item: like item)
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: like item)
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	split_position: INTEGER
			-- Position from the left/top of the splitter from `Current'.
		do
			Result := internal_split_position
		end

	set_split_position (a_split_position: INTEGER)
			-- Set the position of the splitter.
		do
			internal_split_position := a_split_position
			layout_widgets (True)
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
			layout_widgets (False)
		end

	layout_widgets (originator: BOOLEAN)
		deferred
		end

feature -- Widget relationships

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			widget_imp: EV_WIDGET_IMP
		do
			top_level_window_imp := a_window
			if first /= Void then
				widget_imp ?= first.implementation
				check
					widget_implementation_not_void: widget_imp /= Void
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
			if second /= Void then
				widget_imp ?= second.implementation
				check
					widget_implementation_not_void: widget_imp /= Void
				end
				widget_imp.set_top_level_window_imp (a_window)
			end
		end

feature {NONE} -- Implementation

	first_imp: EV_WIDGET_IMP
			-- `Result' is implementation of first.
		do
			if first /= Void then
				Result ?= first.implementation
				check
					implementation_of_first_not_void: Result /= Void
				end
			end
		end

	second_imp: EV_WIDGET_IMP
			-- `Result' is implementation of second.
		do
			if second /= Void then
				Result ?= second.implementation
				check
					implementation_of_second_not_void: Result /= Void
				end
			end
		end

	splitter_width: INTEGER
		do
			Result := split_view.divider_thickness.truncated_to_integer
		end

	internal_split_position: INTEGER
		-- Position of the splitter in pixels.
		-- For a vertical split area, the position is the top of the splitter.
		-- For a horizontal split area, the position is the left
		-- of the splitter.

	set_item_resize (an_item: like item; a_resizable: BOOLEAN)
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		do
			if an_item = first then
				first_expandable := a_resizable
			else
				second_expandable := a_resizable
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPLIT_AREA;

	split_view: NS_SPLIT_VIEW
		do
			Result ?= cocoa_item
		ensure
			split_view_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SPLIT_AREA_IMP


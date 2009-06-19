note
	description:
		"Eiffel Vision fixed. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface,
			insert_i_th,
			make,
			notify_change
		end

	EV_NS_VIEW
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			cocoa_item := create {NS_VIEW}.make_flipped
			Precursor
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; a_x, a_y: INTEGER)
			-- Set `a_widget.x_position' to `a_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			w_imp : EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			w_imp.ev_move (a_x, a_y)
			notify_change (Nc_minsize, w_imp)
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp : EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			w_imp.parent_ask_resize (a_width, a_height)
			notify_change (Nc_minsize, w_imp)
		end

feature {EV_ANY_I} -- Implementation

	compute_minimum_width
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width: INTEGER
			cur: INTEGER
		do
			if not is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				internal_set_minimum_width (new_min_width)
			end
		end

	compute_minimum_height
			-- Compute both to avoid duplicate code.
		local
			v_imp: EV_WIDGET_IMP
			new_min_height: INTEGER
			cur: INTEGER
		do
			if not is_user_min_height_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				internal_set_minimum_height (new_min_height)
			end
		end

	compute_minimum_size
			-- Recompute the minimum size of the object.
		local
			v_imp: EV_WIDGET_IMP
			new_min_width, new_min_height: INTEGER
			cur: INTEGER
		do
			if not is_user_min_height_set or else not is_user_min_width_set then
				cur := ev_children.index
				from
					ev_children.start
				until
					ev_children.after
				loop
					v_imp := ev_children.item
					new_min_width := new_min_width.max (v_imp.x_position + v_imp.width)
					new_min_height := new_min_height.max (v_imp.y_position + v_imp.height)
					ev_children.forth
				end
				ev_children.go_i_th (cur)
				internal_set_minimum_size (new_min_width, new_min_height)
			end
		end

	ev_apply_new_size (a_x_position, a_y_position, a_width, a_height: INTEGER_32; repaint: BOOLEAN)
		do
			ev_move_and_resize (a_x_position, a_y_position, a_width, a_height, repaint)
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			Precursor ( v, i )
			set_item_position ( v, 0, 0 )
--			if is_user_min_height_set or else is_user_min_width_set then
--				set_item_size (v, v.minimum_width, v.minimum_height)
--			end
			set_item_size ( v, v.minimum_width, v.minimum_height )
			if attached {EV_WIDGET_IMP}v.implementation as l_item_imp then -- TODO: Need to call this so children get resized properly. Should not need to call this if on_size is implemented properly.
				l_item_imp.ev_apply_new_size (0, 0, v.minimum_width, v.minimum_height, True)
			end
		end

	notify_change (type: INTEGER; child: EV_SIZEABLE_IMP)
			-- Notify the current widget that the change identify by
			-- type have been done. For types, see `internal_changes'
			-- in class EV_SIZEABLE_IMP. If the container is shown,
			-- we integrate the changes immediatly, otherwise, we postpone
			-- them.
			-- Use the constants defined in EV_SIZEABLE_IMP
		do
			if not is_user_min_height_set or else not is_user_min_width_set then
				Precursor {EV_WIDGET_LIST_IMP} (type, child)
			else
				child.parent_ask_resize (child.width, child.height)
			end
		end

feature -- Implementation

	interface: detachable EV_FIXED note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FIXED


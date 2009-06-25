note
	description: "Eiffel Vision widget list. Cocoa implementation."
	authors: "Daniel Furrer"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WIDGET_LIST_IMP

inherit
	EV_WIDGET_LIST_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			initialize,
			make
		end

	EV_DYNAMIC_LIST_IMP [detachable EV_WIDGET, EV_WIDGET_IMP]
		redefine
			interface,
			initialize,
			insert_i_th,
			remove_i_th
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'
		do
			initialize
		end

	initialize
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {EV_DYNAMIC_LIST_IMP}
		end

feature -- Widget relationships

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		local
			list: ARRAYED_LIST [EV_WIDGET_IMP]
		do
			top_level_window_imp := a_window
			if not ev_children.is_empty then
				list := ev_children
				from
					list.start
				until
					list.after
				loop
					list.item.set_top_level_window_imp (a_window)
					list.forth
				end
			end
		end

feature {NONE} -- Implementation

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp: detachable EV_WIDGET_IMP
		do
			v.implementation.on_parented
			v_imp ?= v.implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			ev_children.go_i_th (i)
			ev_children.put_left (v_imp)
			v_imp.set_parent_imp (Current)
			new_item_actions.call ([v])
			notify_change (Nc_minsize, Current)
			cocoa_view.add_subview (v_imp.cocoa_view)
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v: detachable EV_WIDGET
			v_imp: detachable EV_WIDGET_IMP
		do
			v := i_th (i)
			check v /= Void end
			v_imp ?= v.implementation
			check v_imp_not_void: v_imp /= Void	end
			remove_item_actions.call ([v_imp.attached_interface])
			ev_children.go_i_th (i)
			ev_children.remove
			notify_change (Nc_minsize, Current)
			-- Unlink the widget from its parent and
			-- signal it.
			v_imp.set_parent_imp (Void)
			v_imp.on_orphaned

			v_imp.cocoa_view.remove_from_superview
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_WIDGET_LIST note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_WIDGET_LIST_IMP

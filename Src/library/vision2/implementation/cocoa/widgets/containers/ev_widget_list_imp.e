note
	description: "Eiffel Vision widget list. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			initialize
		end

	EV_DYNAMIC_LIST_IMP [EV_WIDGET, EV_WIDGET_IMP]
		redefine
			interface,
			initialize,
			insert_i_th,
			remove_i_th
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'
		do
			Precursor {EV_CONTAINER_IMP}
			Precursor {EV_DYNAMIC_LIST_IMP}
		end

feature -- Widget relationships

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
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

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			v_imp : EV_WIDGET_IMP
		do
			Precursor {EV_DYNAMIC_LIST_IMP} (v, i)

			v_imp ?= v.implementation
			v_imp.on_parented
			on_new_item (v_imp)

			cocoa_view.add_subview (v_imp.cocoa_view)
		end

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		local
			v_imp: EV_WIDGET_IMP
		do
			v_imp ?= i_th (i).implementation
			v_imp.on_orphaned
			on_removed_item (v_imp)

			v_imp.cocoa_view.remove_from_superview

			Precursor {EV_DYNAMIC_LIST_IMP} (i)
		end

feature {NONE} -- Implementation

	interface: EV_WIDGET_LIST;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_WIDGET_LIST_IMP


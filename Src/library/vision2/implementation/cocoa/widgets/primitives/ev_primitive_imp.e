note
	description: "EiffelVision primitive, Cocoa implementation."
	author:	"Daniel Furrer"
	keywords: "primitive, base, widget"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PRIMITIVE_IMP

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		redefine
			interface
		end

	EV_SIZEABLE_PRIMITIVE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			initialize
			set_default_minimum_size
			enable_tabable_from
		end

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

feature -- Element change

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_parent (par: EV_CONTAINER)
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: detachable EV_CONTAINER_IMP
		do
			if attached par then
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void then
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
			end
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
		end

feature -- Minimum size

	set_default_minimum_size
			-- Initialize the size of `Current'.
			-- Redefined by many widgets.
		do
			internal_set_minimum_size (0, 0)
		end

feature -- Status report

	is_tabable_to: BOOLEAN
			-- Is Current able to be tabbed to?

	is_tabable_from: BOOLEAN
			-- Is Current able to be tabbed from?

	enable_tabable_to
			-- Make `is_tabable_to' `True'.
		do
			is_tabable_to := True
		end

	disable_tabable_to
			-- Make `is_tabable_to' `False'.
		do
			is_tabable_to := False
		end

	enable_tabable_from
			-- Make `is_tabable_from' `True'.
		do
			is_tabable_from := True
		end

	disable_tabable_from
			-- Make `is_tabable_from' `False'.
		do
			is_tabable_from := False
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PRIMITIVE note option: stable attribute end;

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_PRIMITIVE_IMP

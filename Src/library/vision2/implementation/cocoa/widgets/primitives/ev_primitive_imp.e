note
	description:
		"EiffelVision primitive, Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			interface,
			initialize
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		do
			Precursor {EV_WIDGET_IMP}
			set_default_minimum_size
			-- initialize_tabable
		end

	interface: EV_PRIMITIVE;

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Redefined by descendents.
		end

feature -- Element change

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

	set_parent (par: EV_CONTAINER)
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: EV_CONTAINER_IMP
		do
			if par /= Void then
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
			end
		end

	set_top_level_window_imp (a_window: EV_WINDOW_IMP)
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

	internal_set_minimum_size (a_minimum_width, a_minimum_height: INTEGER)
			-- Make `mw' the new minimum_width and `mh' the new
			-- minimum_height of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			w_cd, h_cd: BOOLEAN
			p_imp: like parent_imp
		do
			w_cd := minimum_width /= a_minimum_width
			h_cd := minimum_height /= a_minimum_height
			if not is_user_min_height_set then
				internal_minimum_height := a_minimum_height
			end
			if not is_user_min_width_set then
				internal_minimum_width := a_minimum_width
			end
			p_imp := parent_imp
			if p_imp /= Void then
				if w_cd and h_cd then
					p_imp.notify_change (Nc_minsize, Current)
				elseif w_cd then
					p_imp.notify_change (Nc_minwidth, Current)
				elseif h_cd then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

	internal_set_minimum_height (a_minimum_height: INTEGER)
			-- Make `a_minimum_height' the new `minimum_height' of `Current'.
			-- Should check if the user didn't set the minimum width
			-- before setting a new value.
		local
			p_imp: like parent_imp
		do
			if minimum_height /= a_minimum_height then
				if not is_user_min_height_set then
					internal_minimum_height := a_minimum_height
				end
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minheight, Current)
				end
			end
		end

	internal_set_minimum_width (a_minimum_width: INTEGER)
			-- Abstracted implementation for minimum size setting.
		local
			p_imp: like parent_imp
		do
			if minimum_width /= a_minimum_width then
				if not is_user_min_width_set then
					internal_minimum_width := a_minimum_width
				end
				p_imp := parent_imp
				if p_imp /= Void then
					p_imp.notify_change (Nc_minwidth, Current)
				end
			end
		end

feature -- Status report

	is_tabable_to: BOOLEAN
			-- Is Current able to be tabbed to?
		do
			Result := true
		end

	is_tabable_from: BOOLEAN
			-- Is Current able to be tabbed from?

	enable_tabable_to
			-- Make `is_tabable_to' `True'.
		do
		end

	disable_tabable_to
			-- Make `is_tabable_to' `False'.
		do
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

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_PRIMITIVE_IMP

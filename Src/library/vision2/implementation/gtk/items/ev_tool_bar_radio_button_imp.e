indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_RADIO_BUTTON_IMP

inherit
	EV_TOOL_BAR_RADIO_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			parent_imp,
			make,
			interface,
			initialize,
			create_select_actions
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Make a radio button with a default of selected.
		do
			base_make (an_interface)
			set_c_object (C.gtk_toggle_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
			avoid_reselection := True
				-- Needed to prevent calling of action sequence.
			enable_select
			avoid_reselection := False
		end

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Redefined to prevent unwanted signal connection.
		do
			create Result
		end

	initialize is
			-- Initialize default settings for radio item.
		do
			Precursor
			connect_signals
			align_text_left
		end

feature -- Status setting

	enable_select is
			-- Select `Current' in its grouping.
		do
			C.gtk_toggle_button_set_active (c_object, True)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is `Current' selected.
		do
			Result := C.gtk_toggle_button_get_active (c_object)
		end

feature {NONE} -- Implementation

	parent_imp: EV_TOOL_BAR_IMP is
		do
			Result ?= Precursor
		end

	connect_signals is
			-- Connect on_activate to toggled signal.
		do
			signal_connect ("toggled", ~on_activate, Void)
		end
		
	on_activate is
			-- The button has been activated by the user (pushed).
		local
			a_peers: like peers
			radio_imp: like Current
		do
			if is_selected and then not avoid_reselection then
				a_peers := peers
				from
					a_peers.start
				until
					a_peers.after
				loop
					radio_imp ?= a_peers.item.implementation
					if radio_imp.is_selected and radio_imp /= Current then
						radio_imp.disable_select
					end
					a_peers.forth
				end
				if select_actions_internal /= Void then
					select_actions_internal.call ([])
				end
			end

			if not avoid_reselection then
				avoid_reselection := True
				C.gtk_toggle_button_set_active (c_object, True)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end				
		end

feature {EV_ANY_I} -- Implementation

	disable_select is
			-- Unselect the radio button.
		do
			if is_selected then
				avoid_reselection := True
				C.gtk_toggle_button_set_active (c_object, False)
				-- Calls on_activate callback immediately
				avoid_reselection := False
			end
		end

	avoid_reselection: BOOLEAN

	radio_group: POINTER is
		do
			if parent_imp /= Void then
				Result := parent_imp.radio_group
			end
		end

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


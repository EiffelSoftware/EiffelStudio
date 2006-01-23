indexing
	description: "EiffelVision tool-bar radio button, mswindows implementation."
	legal: "See notice at end of class."
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
			interface,
			initialize
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Post creation initialization.
		do
			Precursor
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN

	enable_select is
			-- Select `Current'.
		do
			update_radio_states
			if parent_imp /= Void then
					parent_imp.check_button (id)
			end
		end

	disable_select is
			-- Deselect `Current'
		do
			is_selected := False
			if parent_imp /= Void then
				parent_imp.uncheck_button (id)
			end
		end

feature -- Implementation

	update_radio_states is
			-- Unselect all members of `radio_group' except `Current',
			-- and assign True to `is_selected'.
		local
			cur: CURSOR
		do
			if radio_group /= Void then
				cur := radio_group.cursor
				from
					radio_group.start
				until
					radio_group.off
				loop
					if radio_group.item /= Current then
						radio_group.item.disable_select
					end
					radio_group.forth
				end
				radio_group.go_to (cur)
			end
			is_selected := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON;

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




end -- class EV_TOOL_BAR_RADIO_BUTTON_IMP


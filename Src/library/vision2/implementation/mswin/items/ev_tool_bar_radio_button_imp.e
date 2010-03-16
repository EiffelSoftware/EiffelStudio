note
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
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Post creation initialization.
		do
			Precursor
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN

	enable_select
			-- Select `Current'.
		do
			update_radio_states
			if attached parent_imp as l_parent_imp then
				l_parent_imp.check_button (id)
			end
		end

	disable_select
			-- Deselect `Current'
		do
			is_selected := False
			if attached parent_imp as l_parent_imp then
				l_parent_imp.uncheck_button (id)
			end
		end

feature -- Implementation

	update_radio_states
			-- Unselect all members of `radio_group' except `Current',
			-- and assign True to `is_selected'.
		local
			cur: CURSOR
			l_radio_group: like radio_group
		do
			l_radio_group := radio_group
			if l_radio_group /= Void then
				cur := l_radio_group.cursor
				from
					l_radio_group.start
				until
					l_radio_group.off
				loop
					if l_radio_group.item /= Current then
						l_radio_group.item.disable_select
					end
					l_radio_group.forth
				end
				l_radio_group.go_to (cur)
			end
			is_selected := True
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_RADIO_BUTTON note option: stable attribute end;

note
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

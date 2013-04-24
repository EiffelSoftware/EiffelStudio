note
	description: "EiffelVision toogle tool bar, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_TOGGLE_BUTTON_IMP

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON_I
		redefine
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		redefine
			interface
		end

create
	make

feature -- Status setting

	enable_select
			-- Select `Current'.
		do
			is_selected := True
			if attached parent_imp as l_parent_imp then
				l_parent_imp.check_button (id)
			end
			if select_actions_internal /= Void then
				select_actions.call (Void)
			end
		end

	disable_select
			-- Deselect `Current'
		do
			is_selected := False
			if attached parent_imp as l_parent_imp then
				l_parent_imp.uncheck_button (id)
			end
			if select_actions_internal /= Void then
				select_actions.call (Void)
			end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current selected'?

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TOOL_BAR_TOGGLE_BUTTON note option: stable attribute end

feature {EV_TOOL_BAR_IMP} -- Status setting

	update_selected (new_is_selected: BOOLEAN)
			-- Update the state of the selection according to
			-- Windows report.
		do
			is_selected := new_is_selected
		end

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

end -- class EV_TOOL_BAR_TOGGLE_BUTTON_IMP

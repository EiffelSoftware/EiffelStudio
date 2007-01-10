indexing
	description: "[
					Toolbar toggle button with the ability to synchronize its status with its related preference.
				]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PREFERENCED_TOOL_BAR_TOGGLE_BUTTON

inherit
	EV_TOOL_BAR_TOGGLE_BUTTON

	EB_RECYCLABLE
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature{NONE} -- Initialization

	make (a_pixmap: EV_PIXMAP; a_tooltip: STRING_GENERAL; a_preference: BOOLEAN_PREFERENCE; a_change_action: like change_action) is
			-- Initialize Current.
			-- `a_pixmap' is to be displayed in this toggle button, `a_tooltip' is the tooltip to be displayed.
			-- `a_preference' is the preference associated with Current and `a_change_action' is the action to be performed when selection status
			-- of Current changes
		require
			a_pixmap_attached: a_pixmap /= Void
			a_tooltip_attached: a_tooltip /= Void
			a_preference_attached: a_preference /= Void
			a_change_action_attached: a_change_action /= Void
		do
			change_action := a_change_action
			preference := a_preference
			on_change_from_outside_agent := agent on_change_from_outside
			preference.change_actions.extend (on_change_from_outside_agent)
			default_create
			set_pixmap (a_pixmap)
			set_tooltip (a_tooltip)
			if preference.value then
				enable_select
			else
				disable_select
			end
			select_actions.extend (agent on_change)
		end

feature -- Access

	change_action: PROCEDURE [ANY, TUPLE]
			-- Action to be performed when selection status of current changes

	preference: BOOLEAN_PREFERENCE
			-- Boolean preference associated with Current
			-- Current is reponsible for synchronizing with `preference'

feature {NONE} -- Implementation

	internal_recycle is
			-- To be called when the button has became useless.
		do
			preference.change_actions.prune_all (on_change_from_outside_agent)
		end

	on_change_from_outside is
			-- Action to be performed when `preference' changes
		local
			l_selected: BOOLEAN
		do
			l_selected := preference.value
			if l_selected /= is_selected then
				if l_selected then
					enable_select
				else
					disable_select
				end
			end
		end

	on_change is
			-- Action to be performed when selection status of Current changes
		do
			preference.set_value (is_selected)
			change_action.call ([])
		end

	on_change_from_outside_agent: PROCEDURE [ANY, TUPLE]
			-- Agent for `on_change_from_outside'

invariant
	change_action_attached: change_action /= Void
	preference_attached: preference /= Void
	on_change_from_outside_agent_attached: on_change_from_outside_agent /= Void

end

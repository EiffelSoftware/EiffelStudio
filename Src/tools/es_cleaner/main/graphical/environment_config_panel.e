note
	description: "[
		A widget to encapsulate environment configuration options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ENVIRONMENT_CONFIG_PANEL

inherit
	ENVIRONMENT_CONFIG_PANEL_IMP
		export
			{EV_ANY} all
		end

	SITE [PACKAGE]
		undefine
			default_create,
			copy,
			is_equal
		end

	I_ENVIRONMENT_CONFIG

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create property_change_action
		end

feature -- Status report

	process_environement_preferences: BOOLEAN
			-- Indiciates if the environment preferences should be processed
		do
			Result := chk_preference.is_selected
		end

	process_environement_editing_layout: BOOLEAN
			-- Indiciates if the environment editing layout should be processed
		do
			Result := chk_editing_layout.is_selected
		end

	process_environement_debug_layout: BOOLEAN
			-- Indiciates if the environment debug layout should be processed
		do
			Result := chk_debug_layout.is_selected
		end

feature -- Actions

	property_change_action: ACTION_SEQUENCE [TUPLE]
			-- Actions to call when user makes a change to the UI causing a setting property to
			-- be modified. This gives clients a chance to reflect dependent UI base on the settings

feature {NONE} -- Implementation

	on_environment_preference_changed
			-- Called by `select_actions' of `chk_preference'.
		do
			property_change_action.call ([])
		end

	on_environment_layout_changed
			-- Called by `select_actions' of `chk_editing_layout'.
		do
			property_change_action.call ([])
		end

	on_environment_debug_changed
			-- Called by `select_actions' of `chk_debug_layout'.
		do
			property_change_action.call ([])
		end

invariant
	property_change_action_attached: property_change_action /= Void

end

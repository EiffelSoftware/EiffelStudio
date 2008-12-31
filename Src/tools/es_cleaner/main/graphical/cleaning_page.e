note
	description: "[
		A notebook tab page widget for cleaning related functions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	CLEANING_PAGE

inherit
	CLEANING_PAGE_IMP

	SITE [PACKAGE]
		undefine
			copy,
			default_create,
			is_equal
		redefine
			siteable_entities
		end

	I_CLEANING_CONFIG

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create property_change_action
			clean_environment_panel.property_change_action.extend (agent property_change_action.call ([]))
			clean_project_panel.property_change_action.extend (agent property_change_action.call ([]))

				-- Add actions
			property_change_action.extend (agent enable_cleaning_widgets)

				-- Initialize UI
			enable_cleaning_widgets
		end

feature -- Access

	project_location: STRING
			-- Location of the Eiffel project to clean.
		do
			Result := clean_project_panel.project_location
		end

feature {NONE} -- Access

	siteable_entities: !ARRAYED_LIST [!SITE [PACKAGE]]
			-- List of siteable entities to automatically site when `Current' is sited
		do
			Result := Precursor {SITE}
			Result.extend (clean_environment_panel.as_attached)
			Result.extend (clean_project_panel.as_attached)
		end

feature -- Status report

	process_environement_preferences: BOOLEAN
			-- Indiciates if the environment preferences should be processed
		do
			Result := clean_environment_panel.process_environement_preferences
		end

	process_environement_editing_layout: BOOLEAN
			-- Indiciates if the environment editing layout should be processed
		do
			Result := clean_environment_panel.process_environement_editing_layout
		end

	process_environement_debug_layout: BOOLEAN
			-- Indiciates if the environment debug layout should be processed
		do
			Result := clean_environment_panel.process_environement_debug_layout
		end

	process_project: BOOLEAN
			-- Indiciates if an Eiffel project should be processed
		do
			Result := clean_project_panel.process_project
		end

	process_project_preferences: BOOLEAN
			-- Indiciates if the project preferences should be processed
		do
			Result := clean_project_panel.process_project_preferences
		end

	process_project_layout: BOOLEAN
			-- Indiciates if the project layout should be processed
		do
			Result := clean_project_panel.process_project_layout
		end

	process_project_session: BOOLEAN
			-- Indiciates if the project session should be processed
		do
			Result := clean_project_panel.process_project_session
		end

feature -- Actions

	property_change_action: ACTION_SEQUENCE [TUPLE]
			-- Actions to call when user makes a change to the UI causing a setting property to
			-- be modified. This gives clients a chance to reflect dependent UI base on the settings

feature {NONE} -- UI state setting

	enable_cleaning_widgets
			-- Enabled cleaning widgets base on configuration state
		do
			if can_environment_processing_occur then
				btn_clean_environment.enable_sensitive
			else
				btn_clean_environment.disable_sensitive
			end
			if can_project_processing_occur then
				btn_clean_project.enable_sensitive
			else
				btn_clean_project.disable_sensitive
			end
		end

feature {NONE} -- Implementation

	on_clean_environment_clicked
			-- Called by `select_actions' of `btn_clean_environment'.
		do
			if site /= Void then
				site.clean_environment (Current)
			end
		end

	on_clean_project_clicked
			-- Called by `select_actions' of `btn_clean_project'.
		do
			if site /= Void then
				site.clean_project (Current)
			end
		end

invariant
	property_change_action_attached: property_change_action /= Void

end

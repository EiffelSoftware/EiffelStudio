indexing
	description: "[
		A notebook tab page widget for backup and restoration related functions.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	RESTORATION_PAGE

inherit
	RESTORATION_PAGE_IMP

	SITE [PACKAGE]
		undefine
			copy,
			default_create,
			is_equal
		redefine
			set_site,
			siteable_entities
		end

	I_BACKUP_CONFIG

feature {NONE} -- Initialization

	set_site (a_site: like site)
			-- Sites `site' with `a_site'.
		do
			Precursor {SITE} (a_site)

				-- Add actions
			if a_site /= Void then
				a_site.workbench_mode_change_actions.extend (agent on_mode_changed)

					-- Initialize UI
				enable_backup_widgets
			end
		end

feature {NONE} -- Initialization

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create property_change_action
			restore_environment_panel.property_change_action.extend (agent property_change_action.call ([]))

				-- Add actions
			property_change_action.extend (agent enable_backup_widgets)
		end

feature {NONE} -- Access

	siteable_entities: !ARRAYED_LIST [!SITE [PACKAGE]] is
			-- List of siteable entities to automatically site when `Current' is sited
		do
			Result := Precursor {SITE}
			Result.extend (restore_environment_panel.as_attached)
		end

feature -- Status report

	process_environement_preferences: BOOLEAN is
			-- Indiciates if the environment preferences should be processed
		do
			Result := restore_environment_panel.process_environement_preferences
		end

	process_environement_editing_layout: BOOLEAN is
			-- Indiciates if the environment editing layout should be processed
		do
			Result := restore_environment_panel.process_environement_editing_layout
		end

	process_environement_debug_layout: BOOLEAN is
			-- Indiciates if the environment debug layout should be processed
		do
			Result := restore_environment_panel.process_environement_debug_layout
		end

feature -- Actions

	property_change_action: ACTION_SEQUENCE [TUPLE]
			-- Actions to call when user makes a change to the UI causing a setting property to
			-- be modified. This gives clients a chance to reflect dependent UI base on the settings

feature {NONE} -- UI state setting

	enable_backup_widgets is
			-- Enabled cleaning widgets base on configuration state
		local
			l_enable: BOOLEAN
			l_manager: I_BACKUP_MANAGER
		do
			l_enable := can_any_processing_occur
			if l_enable then
				btn_backup.enable_sensitive
			else
				btn_backup.disable_sensitive
			end

			l_manager := site.backup_manager
			if l_enable then
				l_enable := l_manager.is_restore_data_available
			end
			if l_enable then
				btn_restore.enable_sensitive
			else
				btn_restore.disable_sensitive
			end
		end

feature {NONE} -- Implementation

	on_backup_clicked is
			-- Called by `select_actions' of `btn_backup'.
		do
			site.backup_configs (Current)
			enable_backup_widgets
		end

	on_restore_clicked is
			-- Called by `select_actions' of `btn_restore'.
		do
			site.restore_configs (Current)
		end

	on_mode_changed (a_workbench: BOOLEAN) is
			-- Called when user changed mode
		do
			enable_backup_widgets
		end

invariant
	property_change_action_attached: property_change_action /= Void

end

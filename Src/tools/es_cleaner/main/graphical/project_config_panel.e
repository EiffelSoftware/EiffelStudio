note
	description: "[
		A widget to encapsulate project configuration options.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	PROJECT_CONFIG_PANEL

inherit
	PROJECT_CONFIG_PANEL_IMP
		export
			{EV_ANY} all
		end

	TOP_LEVEL_WINDOW_PROVIDER
		export
			{NONE} all
		end

	SITE [PACKAGE]
		undefine
			default_create,
			copy,
			is_equal
		end

	I_PROJECT_CONFIG

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			create property_change_action
			refresh_panel
		end

feature -- Access

	project_location: STRING
			-- Location of the Eiffel project to clean.
		do
			Result := txt_project_path.text
		end

feature -- Status report

	process_project: BOOLEAN
			-- Indiciates if an Eiffel project should be processed
		do
			Result := chk_project.is_selected and has_valid_project_location
		end

	process_project_preferences: BOOLEAN
			-- Indiciates if the project preferences should be processed
		do
			Result := chk_project_preferences.is_selected
		end

	process_project_layout: BOOLEAN
			-- Indiciates if the project layout should be processed
		do
			Result := chk_project_layout.is_selected
		end

	process_project_session: BOOLEAN
			-- Indiciates if the project session should be processed
		do
			Result := chk_project_session.is_selected
		end

feature {NONE} -- Status report

	has_valid_project_location: BOOLEAN
			-- Determines if the specified project location is valid
		local
			l_text: STRING
			l_file: RAW_FILE
		do
			Result := txt_project_path.is_sensitive
			if Result then
				l_text := txt_project_path.text
				Result := l_text /= Void and then not l_text.is_empty
				if Result then
					create l_file.make (l_text)
					Result := l_file.exists and then not l_file.is_directory and not l_file.is_device
				end
			end
		end

feature {NONE} -- Basic operations

	browse_for_project_location: STRING
			-- Shows a file browse dialog so the user can locate an ECF
		require
			sited: site /= Void
		local
			l_fod: EV_FILE_OPEN_DIALOG
		do
			create l_fod.make_with_title ("Select an Eiffel Configuration File...")
			l_fod.filters.extend (["*.ecf", "Eiffel Configuration Files (*.ecf)"])
			l_fod.show_modal_to_window (top_level_window)
			Result := l_fod.file_name
			if Result /= Void and then Result.is_empty then
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: Result /= Void implies (create {RAW_FILE}.make (Result)).exists
		end

feature -- Actions

	property_change_action: ACTION_SEQUENCE [TUPLE]
			-- Actions to call when user makes a change to the UI causing a setting property to
			-- be modified. This gives clients a chance to reflect dependent UI base on the settings

feature {NONE} -- UI state setting

	refresh_panel
			-- Refreshes panel based on current ui element state
		do
			enable_widgets
			set_project_path_text_color
		end

	enable_widgets
			-- Enables the project widgets based on current state
		local
			l_project: BOOLEAN
			l_configs: BOOLEAN
		do
			l_project := chk_project.is_selected

			if l_project then
				grp_project.enable_sensitive
				txt_project_path.enable_sensitive
				btn_browse_project.enable_sensitive
				l_configs := has_valid_project_location
			else
				grp_project.disable_sensitive
				txt_project_path.disable_sensitive
				btn_browse_project.disable_sensitive
			end
			if l_configs then
				chk_project_layout.enable_sensitive
				chk_project_preferences.enable_sensitive
				chk_project_session.enable_sensitive
			else
				chk_project_layout.disable_sensitive
				chk_project_preferences.disable_sensitive
				chk_project_session.disable_sensitive
			end
		end

	set_project_path_text_color
			-- Sets the project path text color based on the project location
		do
			if not txt_project_path.is_sensitive or else has_valid_project_location then
				txt_project_path.set_default_colors
			else
				txt_project_path.set_foreground_color (text_foreground_invalid_color)
				txt_project_path.set_background_color (text_background_invalid_color)
			end
		end

feature {NONE} -- Implementation

	on_project_changed
			-- Called by `select_actions' of `chk_project'.
		do
			refresh_panel
			property_change_action.call ([])
		end

	on_project_path_text_changed
			-- Called by `change_actions' of `txt_project_path'.
		do
			refresh_panel
			property_change_action.call ([])
		end

	on_project_browse_clicked
			-- Called by `select_actions' of `btn_browse_project'.
		local
			l_text: STRING
		do
			l_text := browse_for_project_location
			if l_text /= Void then
				txt_project_path.set_text (l_text)
			end
		end

	on_project_layout_changed
			-- Called by `select_actions' of `chk_project_layout'.
		do
			property_change_action.call ([])
		end

	on_project_preferences_changed
			-- Called by `select_actions' of `chk_project_preferences'.
		do
			property_change_action.call ([])
		end

	on_project_session_changed
			-- Called by `select_actions' of `chk_project_session'.
		do
			property_change_action.call ([])
		end

invariant
	property_change_action_attached: property_change_action /= Void

end

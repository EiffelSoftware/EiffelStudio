indexing
	description: "Launch the exportation mechanism"
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_CMD

inherit
	EB_MENUABLE_COMMAND
	
	SHARED_EIFFEL_PROJECT
	
	EB_SHARED_INTERFACE_TOOLS

creation
	make

feature -- Initialization

	make is
			-- Initialize `Current'.
		do
			enable_sensitive
		end

feature -- Access

	menu_name: STRING is
			-- Name as it appears in the menu (with '&' symbol).
		do
			Result := Interface_names.m_Export_XMI
		end

feature -- Execution

	execute is
			-- Start XMI export wizard.
		do
			create wizard
			wizard.finish_button.select_actions.extend (~generate)
			wizard.start
		end

feature {NONE} -- Implementation

	generate is
			-- Generate XMI with options in `wizard'.
		require
			wizard_not_void: wizard /= Void
		local
			xe: XMI_EXPORT
			dial: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				create xe.make
				xe.set_directory (wizard.directory)
				xe.set_universe (wizard.documentation_universe)
				xe.generate (Degree_output)
			end
		rescue
			create dial.make_with_text ("'" + wizard.directory.name + "' is not a valid directory and/or cannot be created%NPlease choose a valid and writable directory.")
			dial.show_modal_to_window (window_manager.last_focused_development_window.window)
			retried := True
			retry
		end

	wizard: EB_EXPORT_WIZARD
			-- XMI export option dialog.

end -- class EXPORT_CMD

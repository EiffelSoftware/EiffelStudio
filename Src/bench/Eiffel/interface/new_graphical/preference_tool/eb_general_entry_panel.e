indexing

	description:
		"Data panel used for capturing general parameters."
	date: "$Date$"
	revision: "$Revision$"

class EB_GENERAL_ENTRY_PANEL

inherit
	NEW_EB_CONSTANTS
		rename
			General_resources as parameters
		export
			{NONE} all
		end
	EB_ENTRY_PANEL
		redefine
			make
		end
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER; a_tool: like tool) is
		do
			Precursor (par, a_tool)

			Create acrobat_reader.make_with_resource (Current, parameters.acrobat_reader)
			Create text_mode.make_with_resource (Current, parameters.text_mode)
			if Platform_constants.is_windows then
				Create tab_step.make_with_resource (Current, parameters.tab_step)
			end
			Create editor.make_with_resource (Current, parameters.editor)
			Create filter_path.make_with_resource (Current, parameters.filter_path)
			Create profile_path.make_with_resource (Current, parameters.profile_path)
			Create tmp_path.make_with_resource (Current, parameters.tmp_path)
			Create shell_command.make_with_resource (Current, parameters.shell_command)
			Create filter_name.make_with_resource (Current, parameters.filter_name)
			Create filter_command.make_with_resource (Current, parameters.filter_command)
			if not Platform_constants.is_windows then
				Create print_shell_command.make_with_resource (Current, parameters.print_shell_command)
			else
				Create browsing_facilities.make_with_resource (Current, parameters.browsing_facilities)
			end

			resources.extend (acrobat_reader)
			resources.extend (text_mode)
			if Platform_constants.is_windows then
				resources.extend (tab_step)
			end
			resources.extend (editor)
			resources.extend (filter_path)
			resources.extend (profile_path)
			resources.extend (tmp_path)
			resources.extend (shell_command)
			resources.extend (filter_name)
			resources.extend (filter_command)
			if not Platform_constants.is_windows then
				resources.extend (print_shell_command)
			else
				resources.extend (browsing_facilities)
			end
		end

feature -- Access

	name: STRING is "General preferences"
			-- Current's name

	symbol: PIXMAP is
		once
			Result := Pixmaps.bm_General
		end

feature {NONE} -- Implementation

	tab_step: EB_INTEGER_RESOURCE_DISPLAY
	acrobat_reader, editor, filter_path, profile_path, tmp_path: EB_STRING_RESOURCE_DISPLAY
	shell_command: EB_STRING_RESOURCE_DISPLAY
	print_shell_command: EB_STRING_RESOURCE_DISPLAY
	filter_name: EB_STRING_RESOURCE_DISPLAY
	filter_command: EB_STRING_RESOURCE_DISPLAY
	browsing_facilities: EB_BOOLEAN_RESOURCE_DISPLAY
	text_mode: EB_STRING_RESOURCE_DISPLAY

end -- class EB_GENERAL_ENTRY_PANEL

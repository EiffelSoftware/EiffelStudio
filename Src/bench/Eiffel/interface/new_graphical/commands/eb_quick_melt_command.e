indexing
	description	: "Command to recompile the Eiffel code without performing any degree 6.%
					%It (re)compiles classes that were edited in EiffelStudio."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_QUICK_MELT_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			name, menu_name, description, pixmap,
			perform_compilation,
			make
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end
 
create
	make

feature {NONE} --Initialization

	make is
			-- Initialize `Current'.
		do
			Precursor {EB_MELT_PROJECT_COMMAND}
			accelerator := create {EV_ACCELERATOR}.make_with_key_combination (
				create {EV_KEY}.make_with_code (key_constants.key_f7), False, False, True
			)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Implementation

	perform_compilation is
			-- The actual compilation process.
		do
			license_display
			workbench.recompile_no_degree_6
		end

feature {NONE} -- Attributes

	name: STRING is "Quick_compile"
			-- Name of precompile command.

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Quick_compile
		end

	description: STRING is
			-- String displayed as a tooltip and in the toolbar customization dialog.
		do
			Result := Interface_names.e_Quick_compile
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmaps representing the command (one for the
			-- (export status {NONE})
		do
			Result := pixmaps.icon_quick_compile
		end

end -- class EB_PRECOMPILE_PROJECT_CMD

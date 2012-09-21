﻿note
	description	: "Command to precompile the Eiffel code."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PRECOMPILE_PROJECT_COMMAND

inherit
	EB_MELT_PROJECT_COMMAND
		redefine
			launch_c_compilation,
			confirm_and_compile,
			name, menu_name,
			perform_compilation,
			is_precompiling,
			make, tooltext,
			pixmap,
			pixel_buffer
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make

feature {NONE} --Initialization

	make
			-- Initialize `Current'.
		do
			Precursor {EB_MELT_PROJECT_COMMAND}
			set_referred_shortcut (Void)
			accelerator := Void
		end

feature {NONE} -- Implementation

	confirm_and_compile
			-- Ask for confirmation, and compile thereafter.
		local
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
		do
			start_c_compilation := True
			if is_dotnet_project then
				create l_confirm.make_standard (warning_messages.w_finalize_precompile, interface_names.l_discard_finalize_precompile_dialog, create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_finalize_precompile_preference, True))
				l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent confirm_finalization_and_compile (True))
				l_confirm.set_button_action (l_confirm.dialog_buttons.no_button, agent confirm_finalization_and_compile (False))
				l_confirm.show_on_active_window
			else
				confirm_finalization_and_compile (False)
			end
		end

	confirm_finalization_and_compile (fin_comp: BOOLEAN)
			-- Ask for confirmation to finalize and discard assertions and compile	
		do
			finalize_precompile := fin_comp
			compile
		end

	launch_c_compilation
			-- Launch the C compilation in the background.
		local
			l_formatter: like c_compiler_formatter
		do
			if start_c_compilation then
				if attached compiler_output as l_output then
					l_output.lock
				end
				l_formatter := c_compiler_formatter

				l_formatter.add_string ("Eiffel System Recompiled")
				l_formatter.add_new_line

				l_formatter.add_string ("Launching Background C Compilation...")
				l_formatter.add_new_line
				if attached compiler_output as l_output then
					l_output.unlock
				end
					-- Display message.
				Eiffel_project.call_finish_freezing (True)

				if finalize_precompile then
					Eiffel_project.call_finish_freezing (False)
				end
			end
		end

	perform_compilation
			-- The actual compilation process.
		do
			if finalize_precompile then
				Eiffel_project.finalize_precompile (False)
			else
				Eiffel_project.precompile (False)
			end
		end

feature {NONE} -- Attributes

	tooltext: STRING_GENERAL
			-- Text for the toolbar button.
		do
			Result := Interface_names.b_Precompile
		end

	name: STRING = "Precompile"
			-- Name of precompile command.

	menu_name: STRING_GENERAL
			-- Name used in menu entry
		once
			Result := Interface_names.m_Precompile_new
		end

	is_precompiling: BOOLEAN = True
			-- We are doing a precompilation here.

	finalize_precompile: BOOLEAN
			-- should precompile be finalized also?

feature {NONE} -- Implementation

	is_dotnet_project: BOOLEAN
			-- is current loaded ace a .net project
		do
			Result := lace.target.setting_boolean ("msil_generation")
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_melt_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_melt_icon_buffer
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EB_PRECOMPILE_PROJECT_CMD

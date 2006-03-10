indexing
	description: "Core of the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_KERNEL

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

	ISED_X_SLAVE
		export
			{NONE} all
		end

	ARGUMENTS
		rename
			command_line as arguments_line
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_FORMAT_INFO
		export
			{NONE} all
		end

	SHARED_LICENSE
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

	EB_SHARED_FLAGS

create
	make

feature {NONE} -- Initialization

	make is
			-- Create and map the first window: the system window.
		local
			compiler: ES
			eifgen_init: INIT_SERVERS
			new_resources: TTY_RESOURCES
			pref_strs: PREFERENCE_CONSTANTS
			l_app: EV_APPLICATION
			fn: FILE_NAME
			preference_access: PREFERENCES
			l_is_gui: BOOLEAN
			--| uncomment the following line when profiling
			--prof_setting: PROFILING_SETTING
		do
			--| uncomment the following lines when profiling
			--create prof_setting.make
			--prof_setting.stop_profiling

				-- Check that environment variables
				-- are properly set.
			check_environment_variable

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create eifgen_init.make

				--| Initialization of global resources.		
			create pref_strs
				-- Initialize pixmaps
			pref_strs.Pixmaps_extension_cell.put ("png")
			create fn.make_from_string (Bitmaps_path)
			fn.extend ("png")
			pref_strs.Pixmaps_path_cell.put (fn)

			l_is_gui := argument_count > 0 and then
				(argument (1).is_equal ("-bench") or else argument (1).is_equal ("-from_bench"))

			set_gui (l_is_gui)
			if l_is_gui then
					-- Create EV_APPLICATION object even if running in batch mode as it is required
					-- for preference initialization
				create l_app
			end

				-- Initialization of compiler resources.
			create preference_access.make_with_defaults_and_location (
				<<general_preferences, platform_preferences>>, eiffel_preferences)
			initialize_preferences (preference_access, l_is_gui)

			create new_resources.initialize
			if not new_resources.error_occurred then
				Eiffel_project.set_batch_mode (not l_is_gui)
				if l_is_gui then

						-- Initialize debugger communication
					if argument (1).is_equal ("-bench") then
							-- True is for binary
						init_connection (False)
					end

						-- Formatting includes breakpoints
					set_is_with_breakable

					create graphic_compiler.make (l_app)

						-- Launch graphical compiler
					l_app.launch
				else
					if
						(argument_count > 1 and then
						argument (1).is_equal ("-precompile") and then
						argument (2).is_equal ("-ace"))
					then
							-- Start the compilation in batch mode from the bench executable.
						create compiler.make
					else
						license.check_activation
						if license.is_licensed or license.can_run then
							create compiler.make
						end
					end
				end
				eifgen_init.dispose
			end

			--| uncomment the following line when profiling
			--prof_setting.start_profiling
		end

feature {NONE} -- Implementation

	graphic_compiler: ES_GRAPHIC
			-- Object needed to interact with Vision2 initialization

	create_handler is do end
			-- Still needed to ensure compatibility with old compiler.

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_KERNEL

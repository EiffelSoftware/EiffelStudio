note
	description: "Input handler"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INPUT_HANDLER

inherit
	HELPER

feature -- Query

	arguments: ARGUMENT_PARSER
			-- Command line arguments.
		deferred
		ensure
			arguments_set: Result /= Void
		end

	is_ecb: BOOLEAN
		do
			Result := arguments.is_ecb
		end

	is_experiment: BOOLEAN
			-- Use experimental library?
		do
			Result := arguments.is_experiment
		end

	is_compatible: BOOLEAN
			-- Use experimental library?
		do
			Result := arguments.is_compatible
		end

	is_log_verbose: BOOLEAN
			-- Log verbose status information?
		do
			Result := arguments.is_log_verbose
		end

	is_clean: BOOLEAN
			-- Clean before compilation?
		do
			Result := arguments.is_clean
		end

	is_c_compile: BOOLEAN
			-- C compile the project?
		do
			Result := arguments.is_c_compile
		end

	is_melt: BOOLEAN
			-- Melt the project?
		do
			Result := arguments.is_melt
		end

	is_freeze: BOOLEAN
			-- Freeze the project?
		do
			Result := arguments.is_freeze
		end

	is_finalize: BOOLEAN
			-- Finalize the project?
		do
			Result := arguments.is_finalize
		end

	is_test: BOOLEAN
			-- Is testing?
		do
			Result := arguments.is_test
		end

	has_keep: BOOLEAN
			-- Keep EIFGENs after compilation?
			--| By default: compilation data is removed after related compilation(s)
			--| if we melt+freeze+finalize then
			--| the data are removed only after the last compilation made on the same target
		do
			Result := arguments.has_keep
		end

	has_keep_all: BOOLEAN
			-- Keep EIFGENs after any compilation?
		do
			Result := arguments.has_keep_all
		end

	has_keep_failed: BOOLEAN
			-- Keep EIFGENs after Failed compilation?
		do
			Result := arguments.has_keep_failed
		end

	has_keep_passed: BOOLEAN
			-- Keep EIFGENs after Passed compilation?
		do
			Result := arguments.has_keep_passed
		end

	list_failures: BOOLEAN
			-- Finalize the project?
		do
			Result := arguments.list_failures
		end

	skip_dotnet: BOOLEAN
			-- Skip dotnet?
		do
			Result := arguments.skip_dotnet
		end

	ec_options: READABLE_STRING_GENERAL
			-- 'ec' compiler option for any action
		do
			Result := arguments.ec_options
		end

	melt_ec_options: READABLE_STRING_GENERAL
			-- 'ec' compiler option when melting
		do
			Result := arguments.melt_ec_options
		end

	freeze_ec_options: READABLE_STRING_GENERAL
			-- 'ec' compiler option when freezing
		once
			Result := arguments.freeze_ec_options
		end

	finalize_ec_options: READABLE_STRING_GENERAL
			-- 'ec' compiler option when finalizing
		once
			Result := arguments.finalize_ec_options
		end

	logs_dir: PATH
			-- Logs dir
		do
			Result := arguments.logs_dir
		end

	compilation_dir: detachable PATH
			-- Location where the projects are compiled.
		do
			Result := arguments.compilation_dir
		end

	target_ignored (a_target: separate CONF_TARGET): BOOLEAN
			-- Target named `a_name' ignored?
		local
			l_file: STRING_32
			l_name: STRING_32
			l_ignored_targets: STRING_TABLE [BOOLEAN]
		do
			create l_file.make_from_separate (system_file_name (target_system (a_target)))
			create l_name.make_from_separate (target_name (a_target))

			if attached ignores as l_ignores then
				l_ignored_targets := l_ignores.item (l_file)
			end

			if l_ignored_targets /= Void and then l_ignored_targets.has (l_name) then
				Result := True
			end
		end

	ignores: STRING_TABLE [STRING_TABLE [BOOLEAN]]
			-- Ignored files/targets.
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end

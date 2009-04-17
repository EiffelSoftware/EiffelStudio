note
	description: "[
		Objects containing settings, states or shared functionality used during an AutoTest session.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_SESSION

inherit
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_system: like eiffel_system; a_conf: TEST_GENERATOR_CONF_I)
			-- Initialize `Current'.
			--
			-- `a_system': Eiffel system to be used in this session.
			-- `a_conf': Configuration for this session
		do
			eiffel_system := a_system
			create error_handler.make (eiffel_system)
			create options.make_with_configuration (a_conf, error_handler)
			create result_repository_builder.make (eiffel_system)
		ensure
			eiffel_system_set: eiffel_system = a_system
		end

feature -- Access: environment

	eiffel_system: SYSTEM_I
			-- Eiffel system containing compiled project information

	error_handler: AUT_ERROR_HANDLER
			-- AutoTest error handler

	options: AUTO_TEST_COMMAND_LINE_PARSER
			-- AutoTest options provided by user

	output_dirname: STRING
			-- Directory name where all output (except generated test cases) should be written to.
		local
			l_cache: like cached_output_dirname
		do
			l_cache := cached_output_dirname
			if l_cache = Void then
				l_cache := options.output_dirname
				if l_cache = Void then
					l_cache := file_system.pathname (eiffel_system.eiffel_project.project_directory.testing_results_path, "auto_test")
				end
				cached_output_dirname := l_cache
			end
			Result := l_cache
		end

feature -- Access: testing

	interpreter_generator: AUT_INTERPRETER_GENERATOR
			-- Generator for creating interpreter proxy instances
		do
			if attached cached_interpreter_generator as l_itp_gen then
				Result := l_itp_gen
			else
				create Result.make (Current)
				cached_interpreter_generator := Result
			end
		end

	result_repository_builder: AUT_RESULT_REPOSITORY_BUILDER
			-- Shared repository builder
			--
			-- Note: currently there is only one repository per session

feature {NONE} -- Access: cache

	cached_interpreter_generator: detachable like interpreter_generator
			-- Cache for `interpreter_generator'

	cached_output_dirname: detachable like output_dirname
			-- Cache for `output_dirname'

invariant
	error_handler_uses_eiffel_system: error_handler.system = eiffel_system

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

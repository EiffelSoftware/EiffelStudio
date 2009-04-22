note
	description: "[
		Modifies a configuration file.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONFIGURATION_MODIFIER

inherit
	CONF_ACCESS

feature -- Access

	last_error: detachable STRING
			-- Last error generated from a conversion process.

feature -- Status report

	has_error: BOOLEAN
			-- Indicates if an error occurred.
		do
			Result := last_error /= Void
		end

feature {NONE} -- Helpers

	file_helpers: FILE_HELPERS
			-- Access to file helper utilities.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- Basic operations

	frozen convert_from_stream (a_contents: READABLE_STRING_8): detachable STRING
			-- Converts a configuration stream.
			--
			-- `a_contents': The contents of a configuration file to convert.
			-- `Result': A converted system or Void if there was an error.
			--           Check `has_error' and `last_error' if the Result is Void.
		require
			a_contents_attached: a_contents /= Void
			not_a_contents_is_empty: not a_contents.is_empty
		local
			l_parser: XM_EIFFEL_PARSER
			l_resolver: XM_NAMESPACE_RESOLVER
			l_callbacks: CONF_LOAD_PARSE_CALLBACKS
			l_system: detachable CONF_SYSTEM
			l_printer: CONF_PRINT_VISITOR
			retried: BOOLEAN
		do
			if not retried then
					-- Set up the parser.
				create l_callbacks.make_with_factory (create {CONF_PARSE_FACTORY})
				create l_resolver.set_next (l_callbacks)
				create l_parser.make
				l_parser.set_callbacks (l_resolver)

					-- Parse configuration contents.
				l_parser.parse_from_string (a_contents.as_string_8)
				if not l_callbacks.is_error then
					l_system := l_callbacks.last_system
					check l_system_attached: l_system /= Void end
					convert_system (l_system)

					create l_printer.make
					l_printer.process_system (l_system)
					if l_printer.is_error then
						last_error := "Rebuilding the configuration file was performed with errors!"
					else
						Result := l_printer.text
					end
				else
					last_error := "The configuration contains syntax errors!"
				end
			elseif l_callbacks /= Void and then attached l_callbacks.last_error as l_error then
				last_error := l_error.message
			else
				last_error := "Unable to parse the configuration file!"
			end
		ensure
			has_error: Result = Void implies has_error
		rescue
			retried := True
			retry
		end

	convert_system (a_system: CONF_SYSTEM)
			-- Converts a configuration system.
			--
			-- `a_system': The system to convert.
		require
			a_system_attached: a_system /= Void
		local
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
		do
				-- First configuration the void-safe options.
			l_targets := a_system.targets
			if l_targets /= Void then
				from l_targets.start until l_targets.after loop
					if (attached l_targets.item_for_iteration as l_target) then
						if l_target.extends = Void then
								-- Root target, so set the options
							convert_void_safe_options (l_target.changeable_internal_options)
						end
						convert_void_safe_target (l_target)
					end
					l_targets.forth
				end
			end
		end

feature {NONE} -- Basic operations

	convert_void_safe_options (a_options: CONF_OPTION)
			-- Converts a configuration option to Void-Safe.
			--
			-- `a_options': The options to convert to Void-Safe
		require
			a_options_attached: a_options /= Void
		deferred
		end

	convert_void_safe_target (a_target: CONF_TARGET)
			-- Converts a target to Void-Safe.
			--
			-- `a_target': The target to convert to Void-Safe
		require
			a_target_attached: a_target /= Void
		local
			l_libraries: HASH_TABLE [CONF_LIBRARY, STRING]
		do
			l_libraries := a_target.libraries
			from l_libraries.start until l_libraries.after loop
				if attached l_libraries.item_for_iteration as l_library then
					convert_void_safe_library (l_library)
				end
				l_libraries.forth
			end

			if attached a_target.precompile as l_precompile then
				convert_void_safe_library (l_precompile)
			end
		end

	convert_void_safe_library (a_library: CONF_LIBRARY)
			-- Converts a library to Void-Safe.
			--
			-- `a_library': The library to convert to Void-Safe
		require
			a_library_attached: a_library /= Void
		deferred
		end

invariant
	not_last_error_is_empty: has_error implies ((attached last_error as l_error) and then not l_error.is_empty)

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end

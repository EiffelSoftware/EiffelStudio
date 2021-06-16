note
	description: "[
		Performs license text modifications on a class.
		
		The current implementation supports the $YEAR symbol in loaded license files.
		License files are located at $ISE_EIFFEL/studio/templates/licenses/*.tpl, and user license
		files at $ISE_USER_FILES/studio/templates/licenses/*.tpl. The * represents the license name.
		
		License files must contain the indexing/note clause text and nothing more. They will be validated
		using a parse and invalid licenses will not be merged into the associated class. Check the logger
		tool for failed merged or other errors related to the loading on license template files.
	
		The license name is extracted using the following methods, in order of priority:
		  - From the source text under an indexing term 'licence_id'.
		        note
		            licence_id: "my_license"
		  - From the class' configuration target variables, using 'license_id' or 'LICENSE_ID'
		  - Or the default 'default', when the above are not found.
		
		In the case of a license_id resulting in the license name 'my_license' the following
		will be attempted to be loaded, in order or priority:		
		  - $ISE_USER_FILES/studio/templates/licenses/my_license.tpl
		  - $ISE_EIFFEL/studio/templates/licenses/my_license.tpl
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_LICENSER

inherit
	ANY

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Helpers

	frozen logger: SERVICE_CONSUMER [LOGGER_S]
			-- Access to the logger service.
		once
			create Result
		ensure
			result_attached: attached Result
		end

	frozen wizard_enginer: SERVICE_CONSUMER [WIZARD_ENGINE_S]
			-- Access to the wizard engine service.
		once
			create Result
		ensure
			result_attached: attached Result
		end

feature -- Basic operatons

	relicense (a_class: CLASS_I)
			-- Initialize a class licenser for a given class.
			--
			-- `a_class': The class to license.
		require
			a_class_attached: attached a_class
		local
			l_mod: ES_CLASS_LICENSE_MODIFIER
			l_name: detachable STRING_32
			l_fn: detachable PATH
			l_parent: detachable PATH
			l_path: STRING_32
			l_index: INTEGER
			l_license: detachable like load_license
			l_libraries: LIST [CONF_LIBRARY]
			l_library: CONF_LIBRARY
			l_uuid: UUID
			l_parameters: STRING_TABLE [ANY]
			l_use_old_syntax: BOOLEAN
			l_load_default: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				create l_mod.make (a_class)
				l_mod.prepare
				if l_mod.is_prepared and then l_mod.is_ast_available then
					l_use_old_syntax := a_class.options.syntax.index = {CONF_OPTION}.syntax_index_obsolete

						-- Parsed successfully.
					l_name := l_mod.license_name
					if attached l_name then
							-- Try to load the license
						l_license := load_named_license (l_name, l_use_old_syntax)
					else
							-- Try to use a license file from an ECF because there was not license referene name in the class.
						if a_class.target.system /~ a_class.universe.conf_system then
								-- Libraries do not have variables so we need to load the configuration and fetch the variables.
							l_uuid := a_class.target.system.uuid
							if attached l_uuid then
									-- Fetch the library reference and load the configuration.
								l_libraries := a_class.universe.library_of_uuid (l_uuid, True)
								if not l_libraries.is_empty then
										-- Create the path to the license file.
									l_library := l_libraries.first
									create l_path.make_from_string (l_library.path)
								end
							end
						else
							check system_defined: a_class.workbench.system_defined end
							create l_path.make_from_string (a_class.workbench.eiffel_ace.file_name)
						end

						l_load_default := True
						if l_path /= Void then
							l_index := l_path.last_index_of ('.', l_path.count)
							if l_index > 1 then
									-- Try to load the license
								l_path.keep_head (l_index - 1)

									-- ecf filename - ".ecf" + ".lic"
								create l_fn.make_from_string (l_path)
								l_fn := l_fn.appended_with_extension (license_extension)
								if (create {RAW_FILE}.make_with_path (l_fn)).exists then
									l_license := load_license (l_fn, l_use_old_syntax)
									l_load_default := False
								else
									l_parent := l_fn.parent
									if l_parent = Void then
										create l_parent.make_current
									end
										-- ecf filename - "-safe.ecf" + ".lic"
									if
										attached l_fn.entry as l_fn_entry and then
										l_fn_entry.name.ends_with_general ("-safe.lic")
									then
										l_path := l_fn_entry.name
										l_path.remove_tail (("-safe.lic").count)
										l_fn := l_parent.extended (l_path).appended_with_extension (license_extension)
										if (create {RAW_FILE}.make_with_path (l_fn)).exists then
											l_license := load_license (l_fn, l_use_old_syntax)
											l_load_default := False
										end
									end
									if l_license = Void then
											-- ecf parent folder name "license.lic"
										l_fn := l_parent.extended (default_license_filename).appended_with_extension (license_extension)
										if (create {RAW_FILE}.make_with_path (l_fn)).exists then
											l_license := load_license (l_fn, l_use_old_syntax)
											l_load_default := False
										else
												-- ecf parent folder name "licence.lic"
											l_fn := l_parent.extended (alternative_default_license_filename).appended_with_extension (license_extension)
											if (create {RAW_FILE}.make_with_path (l_fn)).exists then
												l_license := load_license (l_fn, l_use_old_syntax)
												l_load_default := False
											end
										end
									end
								end
							end
						end

						if l_load_default then
							check l_license_detached: not attached l_license end

								-- No license was loaded, try the default
							l_license := load_named_license (create {STRING_32}.make_from_string ("default"), l_use_old_syntax)
						end
					end

					if attached l_license then
						if not l_license.is_empty then
							if not l_mod.is_valid_license (l_license) then
									-- Render the invalid license template.
								l_license := locale_formatter.translation (invalid_license_license)
								if attached wizard_enginer.service as wizard_enginer_service then
									create l_parameters.make (1)
									if l_use_old_syntax then
										l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword, note_keyword_symbol)
									else
										l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword, note_keyword_symbol)
									end
									l_license := wizard_enginer_service.render_template (l_license, l_parameters)
								else
									l_license := Void
								end
							end

							if attached l_license and then l_mod.is_valid_license (l_license) then
								l_mod.set_license (l_license)
								if l_mod.is_dirty then
									l_mod.commit
								end
							else
								check False end
							end
						end
					end
				else
						-- The class contains sytax errors
					if attached logger.service as logger_service then
							-- Log error.
						logger_service.put_message_format_with_severity (
							"Unable to apply license because class {1} contains syntax errors.",
							[a_class.name],
							{ENVIRONMENT_CATEGORIES}.editor,
							{PRIORITY_LEVELS}.high)
					end
				end
			else
					-- There was an exception
				if attached logger.service as logger_service then
						-- Log error.
					logger_service.put_message_format_with_severity (
						"Unable to apply license to class {1} because of an internal exception.",
						[a_class.name],
						{ENVIRONMENT_CATEGORIES}.editor,
						{PRIORITY_LEVELS}.high)
				end
			end
		rescue
			retried := True
			retry
		end


	relicense_text (a_class_text: READABLE_STRING_GENERAL; a_class: CLASS_I): STRING_32
			-- Initialize a class licenser for a given class with the given class text.
			--
			-- `a_class_text`: a class text to relicense.
			-- `a_class': The class to license.

		require
			a_class_attached: attached a_class
		local
			l_mod: ES_CLASS_LICENSE_MODIFIER
			l_name: detachable STRING_32
			l_fn: detachable PATH
			l_parent: detachable PATH
			l_path: STRING_32
			l_index: INTEGER
			l_license: detachable like load_license
			l_libraries: LIST [CONF_LIBRARY]
			l_library: CONF_LIBRARY
			l_uuid: UUID
			l_parameters: STRING_TABLE [ANY]
			l_use_old_syntax: BOOLEAN
			l_load_default: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				Result := a_class_text
				create l_mod.make_with_text (a_class_text, a_class)
				l_mod.prepare
				if l_mod.is_prepared and then l_mod.is_ast_available then
					l_use_old_syntax := a_class.options.syntax.index = {CONF_OPTION}.syntax_index_obsolete

						-- Parsed successfully.
					l_name := l_mod.license_name
					if attached l_name then
							-- Try to load the license
						l_license := load_named_license (l_name, l_use_old_syntax)
					else
							-- Try to use a license file from an ECF because there was not license referene name in the class.
						if a_class.target.system /~ a_class.universe.conf_system then
								-- Libraries do not have variables so we need to load the configuration and fetch the variables.
							l_uuid := a_class.target.system.uuid
							if attached l_uuid then
									-- Fetch the library reference and load the configuration.
								l_libraries := a_class.universe.library_of_uuid (l_uuid, True)
								if not l_libraries.is_empty then
										-- Create the path to the license file.
									l_library := l_libraries.first
									create l_path.make_from_string (l_library.path)
								end
							end
						else
							check system_defined: a_class.workbench.system_defined end
							create l_path.make_from_string (a_class.workbench.eiffel_ace.file_name)
						end

						l_load_default := True
						if l_path /= Void then
							l_index := l_path.last_index_of ('.', l_path.count)
							if l_index > 1 then
									-- Try to load the license
								l_path.keep_head (l_index - 1)

									-- ecf filename - ".ecf" + ".lic"
								create l_fn.make_from_string (l_path)
								l_fn := l_fn.appended_with_extension (license_extension)
								if (create {RAW_FILE}.make_with_path (l_fn)).exists then
									l_license := load_license (l_fn, l_use_old_syntax)
									l_load_default := False
								else
									l_parent := l_fn.parent
									if l_parent = Void then
										create l_parent.make_current
									end
										-- ecf filename - "-safe.ecf" + ".lic"
									if
										attached l_fn.entry as l_fn_entry and then
										l_fn_entry.name.ends_with_general ("-safe.lic")
									then
										l_path := l_fn_entry.name
										l_path.remove_tail (("-safe.lic").count)
										l_fn := l_parent.extended (l_path).appended_with_extension (license_extension)
										if (create {RAW_FILE}.make_with_path (l_fn)).exists then
											l_license := load_license (l_fn, l_use_old_syntax)
											l_load_default := False
										end
									end
									if l_license = Void then
											-- ecf parent folder name "license.lic"
										l_fn := l_parent.extended (default_license_filename).appended_with_extension (license_extension)
										if (create {RAW_FILE}.make_with_path (l_fn)).exists then
											l_license := load_license (l_fn, l_use_old_syntax)
											l_load_default := False
										else
												-- ecf parent folder name "licence.lic"
											l_fn := l_parent.extended (alternative_default_license_filename).appended_with_extension (license_extension)
											if (create {RAW_FILE}.make_with_path (l_fn)).exists then
												l_license := load_license (l_fn, l_use_old_syntax)
												l_load_default := False
											end
										end
									end
								end
							end
						end

						if l_load_default then
							check l_license_detached: not attached l_license end

								-- No license was loaded, try the default
							l_license := load_named_license (create {STRING_32}.make_from_string ("default"), l_use_old_syntax)
						end
					end

					if attached l_license then
						if not l_license.is_empty then
							if not l_mod.is_valid_license (l_license) then
									-- Render the invalid license template.
								l_license := locale_formatter.translation (invalid_license_license)
								if attached wizard_enginer.service as wizard_enginer_service then
									create l_parameters.make (1)
									if l_use_old_syntax then
										l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword, note_keyword_symbol)
									else
										l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword, note_keyword_symbol)
									end
									l_license := wizard_enginer_service.render_template (l_license, l_parameters)
								else
									l_license := Void
								end
							end

							if attached l_license and then l_mod.is_valid_license (l_license) then
								l_mod.set_license (l_license)
								if l_mod.is_dirty then
									Result := l_mod.text
								end
							else
								check False end
							end
						end
					end
				else
						-- The class contains sytax errors
					if attached logger.service as logger_service then
							-- Log error.
						logger_service.put_message_format_with_severity (
							"Unable to apply license because class {1} contains syntax errors.",
							[a_class.name],
							{ENVIRONMENT_CATEGORIES}.editor,
							{PRIORITY_LEVELS}.high)
					end
				end
			else
					-- There was an exception
				if attached logger.service as logger_service then
						-- Log error.
					logger_service.put_message_format_with_severity (
						"Unable to apply license to class {1} because of an internal exception.",
						[a_class.name],
						{ENVIRONMENT_CATEGORIES}.editor,
						{PRIORITY_LEVELS}.high)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic operation

	load_license (a_file_name: PATH; a_use_old_syntax: BOOLEAN): detachable STRING_32
			-- Attempt to load a license file
			--
			-- `a_file_name': The file name of the license file to load.
			-- `a_use_old_syntax': True to use older syntax, False to use the standard.
			-- `Result': The license text or Void if the license file did not exist or was incompatible
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_name: detachable STRING_32
			l_parameters: STRING_TABLE [ANY]
			l_index: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				if (create {RAW_FILE}.make_with_path (a_file_name)).exists then
					if attached wizard_enginer.service as wizard_enginer_service then
							-- Set up wizard parameters
						create l_parameters.make (2)
						l_parameters.force ((create {DATE}.make_now).year, year_symbol)
						if a_use_old_syntax then
							l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.indexing_keyword, note_keyword_symbol)
						else
							l_parameters.force ({EIFFEL_KEYWORD_CONSTANTS}.note_keyword, note_keyword_symbol)
						end

							-- Render template
						Result := wizard_enginer_service.render_template_from_file (a_file_name, l_parameters)
						if Result /= Void then
							Result.right_adjust
							Result.left_adjust
							if Result.is_empty then
									-- Wipe out, because empty licenses are not valid.
								Result := Void
							else
									-- Grab the first line
								l_name := Result
								l_index := l_name.index_of ('%N', 1)
								if l_index > 1 then
									l_name := l_name.substring (1, l_index - 1)
								end
								if l_name /= Void and then l_name.substring (1, l_name.count.min (reference_prefix.count)).is_case_insensitive_equal (reference_prefix.as_string_32) then
										-- The file contains a license reference, redirect to use that instead.
									l_name.keep_tail (l_name.count - reference_prefix.count)
									Result := load_named_license (l_name, a_use_old_syntax)
								end
							end
						end
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		rescue
			retried := True
			retry
		end

	load_named_license (a_name: attached STRING_32; a_use_old_syntax: BOOLEAN): detachable STRING_32
			-- Attempt to load a license from the licenses folder.
			--
			-- `a_name': The name of the license file to load.
			-- `a_use_old_syntax': True to use older syntax, False to use the standard.
			-- `Result': The license text or Void if the license file did not exist or was incompatible
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_fn: PATH
			l_user_fn: detachable PATH
			retried: BOOLEAN
		do
			if not retried then
				l_fn := eiffel_layout.templates_path.extended ("licenses").extended (a_name + {STRING_32} "." + license_extension)

					-- Check user file
				l_user_fn := eiffel_layout.user_priority_file_name (l_fn, True)
				if l_user_fn /= Void then
					l_fn := l_user_fn
				end
				if l_fn /= Void then
					Result := load_license (l_fn, a_use_old_syntax)
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {NONE} -- Constants: Symbols

	default_license_filename: STRING_32 = "license"

	alternative_default_license_filename: STRING_32 = "licence"

	license_extension: STRING_32 = "lic"

	note_keyword_symbol: STRING = "NOTE_KEYWORD"
			-- Keyword symbol in the template license file.

	year_symbol: STRING = "YEAR"
			-- Year symbol in the template license file.

	reference_prefix: STRING = "reference:"
			-- Reference prefix for named licenses.

feature {NONE} -- Internationalization

	invalid_license_license: STRING = "${NOTE_KEYWORD}%N%Tlicense: %"The specified license contains syntax errors!%""
			-- Default invalid license.

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

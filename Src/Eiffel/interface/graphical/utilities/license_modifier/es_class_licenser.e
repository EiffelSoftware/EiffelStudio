indexing
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

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE} -- Helpers

	frozen logger: !SERVICE_CONSUMER [LOGGER_S]
			-- Access to the logger service.
		once
			create Result
		end

	frozen wizard_enginer: !SERVICE_CONSUMER [WIZARD_ENGINE_S]
			-- Access to the wizard engine service.
		once
			create Result
		end

feature -- Basic operatons

	relicense (a_class: !CLASS_I) is
			-- Initialize a class licenser for a given class.
			--
			-- `a_class': The class to license.
		local
			l_mod: !ES_CLASS_LICENSE_MODIFIER
			l_name: !STRING_32
			l_license: ?like load_license
		do
			create l_mod.make (a_class)
			l_mod.prepare
			if l_mod.is_prepared and then l_mod.is_ast_available then
					-- Parsed successfully.
				l_name := l_mod.license_name
				l_license := load_license (l_name, a_class.options.syntax_level.item = {CONF_OPTION}.syntax_level_obsolete)
				if l_license /= Void then
					if not l_license.is_empty then
						if l_mod.is_valid_license (l_license) then
							l_mod.set_license (l_license)
							if l_mod.is_dirty then
								l_mod.commit
							end
						else
								-- There is no license file or the file cannot be read.
							if logger.is_service_available then
									-- Log error.
								logger.service.put_message_format_with_severity (
									"Unable to parse the license associated with the license ID {1}. Make sure the usage of the note and indexing clause are correct.",
									[l_name],
									{ENVIRONMENT_CATEGORIES}.editor,
									{PRIORITY_LEVELS}.high)
							end
						end
					end
				else
						-- There is no license file or the file cannot be read.
					if logger.is_service_available then
							-- Log error.
						logger.service.put_message_format_with_severity (
							"Unable to read license file associated with the license ID {1}.",
							[l_name],
							{ENVIRONMENT_CATEGORIES}.editor,
							{PRIORITY_LEVELS}.high)
					end
				end
			else
					-- The class contains sytax errors
				if logger.is_service_available then
						-- Log error.
					logger.service.put_message_format_with_severity (
						"Unable to apply license because class {1} contains syntax errors.",
						[a_class.name],
						{ENVIRONMENT_CATEGORIES}.editor,
						{PRIORITY_LEVELS}.high)
				end
			end
		end

feature {NONE} -- Basic operation

	load_license (a_name: !STRING_32; a_use_old_syntax: BOOLEAN): ?STRING_32
			-- Attempt to load a license file
			--
			-- `a_name': The name of the license file to load.
			-- `a_use_old_syntax': True to use older syntax, False to use the standard.
			-- `Result': The license text or Void if the license file did not exist or was incompatible
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_fn: !FILE_NAME
			l_user_fn: ?FILE_NAME
			l_file: ?PLAIN_TEXT_FILE
			l_parameters: !DS_HASH_TABLE [!ANY, !STRING]
			retried: BOOLEAN
		do
			if not retried then
				create l_fn.make_from_string (eiffel_layout.templates_path.string)
				l_fn.extend ("licenses")
				l_fn.set_file_name (a_name)
				l_fn.add_extension ("tpl")

					-- Check user file
				l_user_fn := eiffel_layout.user_priority_file_name (l_fn, True)
				if l_user_fn /= Void then
					l_fn := l_user_fn
				end

				if (create {RAW_FILE}.make (l_fn.string)).exists then
					if wizard_enginer.is_service_available then
							-- Set up wizard parameters
						create l_parameters.make (2)
						l_parameters.put_last ((create {DATE}.make_now).year, year_symbol)
						if a_use_old_syntax then
							l_parameters.put_last ("indexing", keyword_symbol)
						else
							l_parameters.put_last ("note", keyword_symbol)
						end

							-- Render template
						Result := wizard_enginer.service.render_template_from_file (l_fn.string, l_parameters)
						Result.right_adjust
						Result.left_adjust
						if Result.is_empty then
								-- Wipe out, because empty licenses are not valid.
							Result := Void
						end
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		rescue
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
			retried := True
			retry
		end

feature {NONE} -- Symbols

	keyword_symbol: !STRING = "KEYWORD"
			-- Keyword symbol in the template license file.

	year_symbol: !STRING = "YEAR"
			-- Year symbol in the template license file.

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end

note
	description: "[
		Service implementation for manipulating and querying the global code template catalog, based on the service description {ES_CODE_TEMPLATE_CATALOG_S}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CODE_TEMPLATE_CATALOG

inherit

	ES_CODE_TEMPLATE_CATALOG_S

	DISPOSABLE_SAFE

	SHARED_EIFFEL_PARSER

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the code template catalog.
		local
			l_tester: EQUALITY_TESTER [PATH]
		do
			create l_tester
			create cataloged_folder_files.make_with_key_tester (10, l_tester)
			create cataloged_template_definitions.make_with_key_tester (10, l_tester)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if
				a_explicit and then
				attached internal_code_templates as l_templates
			then
				l_templates.wipe_out
			end
		ensure then
			internal_code_templates_is_empty:
				attached internal_code_templates as l_templates implies l_templates.is_empty
		end

feature -- Access

	code_templates: DS_BILINEAR [ES_CODE_TEMPLATE_DEFINITION]
			-- <Precursor>
		local
			l_templates: DS_ARRAYED_LIST [ES_CODE_TEMPLATE_DEFINITION]
		do
			if attached internal_code_templates as l_results then
				Result := l_results
			else
				create l_templates.make_default
				across cataloged_template_definitions as l_cursor loop
					if attached l_cursor.item as l_item and then attached l_item.definition as l_definition then
						l_templates.force_last (l_definition)
					end
				end
				Result := l_templates
				internal_code_templates := l_templates
			end
		end

feature {NONE} -- Access

	cataloged_folder_files: HASH_TABLE_EX [ARRAYED_LIST [PATH], PATH]
			-- Cataloged folders, where template files are extracted from.
			-- Key: Folder path
			-- Value: List of file names

	cataloged_template_definitions: HASH_TABLE_EX [TUPLE [definition: detachable ES_CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], PATH]
			-- Cataloged code template definitions, with reference count.
			-- Key: Code template definition file name
			-- Value: A code template definition with a cataloged reference count.

feature -- Status report

	is_cataloged (a_folder: PATH): BOOLEAN
			-- <Precursor>
		do
			Result := cataloged_folder_files.has (a_folder)
		ensure then
			cataloged_folder_files_has_a_folder: Result implies cataloged_folder_files.has (a_folder)
		end

feature -- Query

	template_by_file_name (a_file_name: PATH): detachable ES_CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_templates: like cataloged_template_definitions
		do
			l_templates := cataloged_template_definitions
			if l_templates.has (a_file_name) and then attached l_templates.item (a_file_name) as l_item then
				Result := l_item.definition
			end
		end

feature -- Events

	catalog_changed_event: EVENT_TYPE [TUPLE]
			-- <Precursor>
		do
			if attached internal_catalog_changed_event as l_result then
				Result := l_result
			else
				create Result
				internal_catalog_changed_event := Result
				auto_dispose (Result)
			end
		end

feature -- Events: Connection point

	code_template_catalog_connection: EVENT_CONNECTION_I [ES_CODE_TEMPLATE_CATALOG_OBSERVER, ES_CODE_TEMPLATE_CATALOG_S]
			-- <Precursor>
		do
			if attached internal_code_template_catalog_connection as l_result then
				Result := l_result
			else
				create {EVENT_CONNECTION [ES_CODE_TEMPLATE_CATALOG_OBSERVER, ES_CODE_TEMPLATE_CATALOG_S]} Result.make (
					agent (ia_observer: ES_CODE_TEMPLATE_CATALOG_OBSERVER): ARRAY [TUPLE [event: EVENT_TYPE [TUPLE]; action: PROCEDURE]]
						do
							Result := << [catalog_changed_event, agent ia_observer.on_catalog_changed] >>
						end)
				auto_dispose (Result)
				internal_code_template_catalog_connection := Result
			end
		end

feature {NONE} -- Helpers

	logger_service: SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		do
			if attached internal_logger_service as l_result then
				Result := l_result
			else
				create Result
				internal_logger_service := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = logger_service
		end

feature -- Basic operations

	rescan (a_folder: PATH)
			-- <Precursor>
		local
			l_empty: BOOLEAN
		do
			l_empty := cataloged_folder_files.is_empty
			if (attached internal_catalog_changed_event as l_events) and then (not l_events.is_suspended) then
				l_events.perform_suspended_action (agent rescan (a_folder))
				if not l_empty or else l_empty /= cataloged_folder_files.is_empty then
					l_events.publish (Void)
				end
			elseif not l_empty then
				remove_catalog (a_folder)
				extend_catalog (a_folder)
			end
		ensure then
			cataloged_folder_files_count_unchanged:
				old not cataloged_folder_files.is_empty implies
				(cataloged_folder_files.count = old cataloged_folder_files.count)
		end

	rescan_catalog
			-- <Precursor>
		local
			l_keys: ARRAY [PATH]
			l_key: PATH
			l_empty: BOOLEAN
			i, nb: INTEGER
		do
			if attached internal_catalog_changed_event as l_events and then not l_events.is_suspended then
				l_empty := cataloged_folder_files.is_empty
				l_events.perform_suspended_action (agent rescan_catalog)
				if not l_empty or else l_empty /= cataloged_folder_files.is_empty then
					l_events.publish (Void)
				end
			else
					-- Remove cataloged data.
				l_keys := cataloged_folder_files.current_keys

				cataloged_folder_files.wipe_out
				cataloged_template_definitions.wipe_out

				from
					i := l_keys.lower
					nb := l_keys.upper
				until
					i > nb
				loop
						-- Extend catalogs
					l_key := l_keys.item (i)
					check l_key_attached: l_key /= Void end
					extend_catalog (l_key)
					i := i + 1
				end
			end
--		ensure then
--			cataloged_folder_files_count_unchanged:
--				old not cataloged_folder_files.is_empty implies
--				(cataloged_folder_files.count = old cataloged_folder_files.count)
		end

feature -- Extension

	extend_catalog (a_folder: PATH)
			-- <Precursor>
		local
			l_definitions: like cataloged_template_definitions
			l_definition: detachable TUPLE [definition: detachable ES_CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_files: ARRAYED_LIST [PATH]
			l_changed: BOOLEAN
		do
			l_files := file_utilities.ends_with (a_folder, ".e", -1)
			if not l_files.is_empty then
				l_definitions := cataloged_template_definitions
				from l_files.start until l_files.after loop
					if attached l_files.item_for_iteration as l_file then
						if l_definitions.has (l_file) then
								-- The template definition already exists, no need to build
								-- the definition files.
							l_definition := l_definitions.item (l_file)
							if attached l_definition then
									-- Increment the reference count.
								l_definition.ref_count := l_definition.ref_count + 1
							end
						else
								-- Build code template definition and add to the catalog
							l_definition := [build_template (l_file), {NATURAL_8} 1]
							l_definitions.force (l_definition, l_file)
							l_changed := True

							if l_definition.definition /= Void then
									-- A new declaration was added, so invalidate the cached code templates.
								internal_code_templates := Void
							end
						end
					end
					l_files.forth
				end
			end

				-- Extends the folder catalog
			cataloged_folder_files.force (l_files, a_folder)

			if l_changed and then (attached internal_catalog_changed_event as l_events) then
				l_events.publish (Void)
			end
		end

feature -- Removal

	remove_catalog (a_folder: PATH)
			-- <Precursor>
		local
			l_catalog: like cataloged_folder_files
			l_folder: PATH
			l_files: ARRAYED_LIST [PATH]
			l_definitions: like cataloged_template_definitions
			l_definition: TUPLE [definition: detachable ES_CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_file: PATH
			l_changed: BOOLEAN
		do
			l_catalog := cataloged_folder_files
			l_folder := a_folder
			l_files := l_catalog.item (l_folder)
			if attached l_files and then not l_files.is_empty then
				l_definitions := cataloged_template_definitions
				from l_files.start until l_files.after loop
					if attached l_files.item_for_iteration as l_file_item then
						l_file := l_file_item
						if l_definitions.has (l_file) then
								-- Decrement reference count
							l_definition := l_definitions.item (l_file)
							if l_definition /= Void then
									-- Decrement the reference count.
								l_definition.ref_count := l_definition.ref_count - 1
								if l_definition.ref_count = 0 then
										-- Remove the file from the catalog.
									l_definitions.remove (l_file)
									l_changed := True

									if l_definition.definition /= Void then
											-- An existing declaration was remove, so invalidate the cached code templates.
										internal_code_templates := Void
									end
								end
							end
						else
								-- This means a file was not added correctly in `extend_catalog'.
							check False end
						end
					end
					l_files.forth
				end
			end

				-- Remove from the folder/file catalog.
			l_catalog.remove (l_folder)

			if l_changed and then attached internal_catalog_changed_event as l_events then
				l_events.publish (Void)
			end
		end

feature {NONE} -- Helpers

	file_utilities: GOBO_FILE_UTILITIES
			-- Shared access to file utilities.
		once
			create Result
		ensure
			result_attached: attached Result
		end

	eiffel_parser_wrapper: EIFFEL_PARSER_WRAPPER
			-- Eiffel parsed use to parse the code template files.
		once
			create Result
		ensure
			result_attached: attached Result
		end


feature {NONE} -- Basic operations

	build_template (a_file_name: PATH): detachable ES_CODE_TEMPLATE_DEFINITION
			-- Builds a code template definition model from a file.
			--
			-- `a_file_name': Path to the code template file.
			-- `Result': A code template definition model or Void if the template file could not be parsed.
		require
			is_interface_usable: is_interface_usable
			a_file_name_attached: attached a_file_name
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {FILE_UTILITIES}).file_path_exists (a_file_name)
		local
			l_parser: like eiffel_parser_wrapper
			retried: BOOLEAN
			l_file: RAW_FILE
		do
			if not retried then
				create l_file.make_with_path (a_file_name)
				l_file.open_read
				if not l_file.is_empty then
					l_file.read_stream (l_file.count)
					l_parser := eiffel_parser_wrapper
					l_parser.parse_with_option_32 (Heavy_eiffel_parser, l_file.last_string, {CONF_OPTION}.create_from_namespace_or_latest ({CONF_FILE_CONSTANTS}.latest_namespace), False, Void)
					if
						attached l_parser.ast_node as l_ast_node and then
						attached l_parser.ast_match_list as l_ast_match_list
					then
						create Result.make (l_ast_node, l_ast_match_list)
					else
							-- Log parse error
						if attached logger_service.service as l_service then
							l_service.put_message_with_severity (
								(create {ERROR_MESSAGES}).e_code_template_parse ("Not parsed", a_file_name.name),
								{ENVIRONMENT_CATEGORIES}.internal_event,
								{PRIORITY_LEVELS}.high)
						end
					end
				end
				l_file.close
			else
					-- Log parse error
				if attached logger_service.service as l_service then
						l_service.put_message_with_severity (
						(create {ERROR_MESSAGES}).e_code_template_parse ("Not parsed", a_file_name.name),
						{ENVIRONMENT_CATEGORIES}.internal_event,
						{PRIORITY_LEVELS}.high)
				end
			end
		ensure
			result_is_interface_usable: attached Result implies Result.is_interface_usable
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation: Internal cached

	internal_catalog_changed_event: detachable like catalog_changed_event
			-- Cached version of `internal_catalog_changed_event'.
			-- Note: Do not use directly!

	internal_code_template_catalog_connection: detachable like code_template_catalog_connection
			-- Cached version of `code_template_catalog_connection'.
			-- Note: Do not use directly!

	internal_code_templates: detachable like code_templates
			-- Cached version of `code_templates'.
			-- Note: Do not use directly!

	internal_logger_service: detachable like logger_service
			-- Cached version of `logger_service'.
			-- Note: Do not use directly!

invariant
	cataloged_folder_files_attached: attached cataloged_folder_files
	cataloged_template_definitions_attached: attached cataloged_template_definitions

;note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

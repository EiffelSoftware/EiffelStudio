note
	description: "[
		Service implementation for manipulating and querying the global code template catalog, based on the service description {CODE_TEMPLATE_CATALOG_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TEMPLATE_CATALOG

inherit
	CODE_TEMPLATE_CATALOG_S

	DISPOSABLE_SAFE

--inherit {NONE}
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the code template catalog.
		local
			l_tester: KL_EQUALITY_TESTER [STRING]
		do
			create catalog_changed_event
			auto_dispose (catalog_changed_event)

			create cataloged_folder_files.make_default
			create cataloged_template_definitions.make_default
			if {PLATFORM}.is_windows then
				create {KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER} l_tester
			else
				create {KL_STRING_EQUALITY_TESTER} l_tester
			end
			cataloged_folder_files.set_key_equality_tester (l_tester)
			cataloged_template_definitions.set_key_equality_tester (l_tester)
		end

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
			if a_explicit then
				if internal_code_templates /= Void then
					internal_code_templates.wipe_out
				end
			end
		ensure then
			internal_code_templates_is_empty: internal_code_templates /= Void implies internal_code_templates.is_empty
		end

feature -- Access

	code_templates: attached DS_BILINEAR [attached CODE_TEMPLATE_DEFINITION]
			-- <Precursor>
		local
			l_result: DS_ARRAYED_LIST [attached CODE_TEMPLATE_DEFINITION]
			l_cursor: DS_HASH_TABLE_CURSOR [attached TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], STRING]
		do
			if attached {like code_templates} internal_code_templates as l_templates then
				Result := l_templates
			else
				create l_result.make_default
				l_cursor := cataloged_template_definitions.new_cursor
				from l_cursor.start until l_cursor.after loop
					if attached {attached CODE_TEMPLATE_DEFINITION} l_cursor.item.definition as l_definition then
						l_result.force_last (l_definition)
					end
					l_cursor.forth
				end
				Result := l_result
				internal_code_templates := l_result
			end
		end

feature {NONE} -- Access

	cataloged_folder_files: attached DS_HASH_TABLE [attached DS_ARRAYED_LIST [attached READABLE_STRING_GENERAL], STRING]
			-- Cataloged folders, where template files are extracted from.
			-- Key: Folder path
			-- Value: List of file names

	cataloged_template_definitions: attached DS_HASH_TABLE [attached TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], STRING]
			-- Cataloged code template definitions, with reference count.
			-- Key: Code template definition file name
			-- Value: A code template definition with a cataloged reference count.

feature -- Status report

	is_cataloged (a_folder: attached READABLE_STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			Result := cataloged_folder_files.has (a_folder.as_string_8.as_attached)
		ensure then
			cataloged_folder_files_has_a_folder: Result implies cataloged_folder_files.has (a_folder.as_string_8.as_attached)
		end

feature -- Query

	template_by_file_name (a_file_name: attached READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_fn: attached READABLE_STRING_8
			l_templates: like cataloged_template_definitions
		do
			l_fn := a_file_name.as_string_8.as_attached
			l_templates := cataloged_template_definitions
			if l_templates.has (l_fn) then
				Result := l_templates.item (l_fn).definition
			end
		end

	template_by_title (a_title: attached READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_template: attached CODE_TEMPLATE_DEFINITION
			l_cursor: DS_BILINEAR_CURSOR [attached CODE_TEMPLATE_DEFINITION]
		do
			l_cursor := code_templates.new_cursor
			from l_cursor.finish until l_cursor.before loop
				l_template := l_cursor.item
				if a_title.as_string_32.is_equal (l_template.metadata.title) then
					Result := l_template
					l_cursor.go_before
				else
					l_cursor.back
				end
			end
			check gobo_cursor_cleaned_up: l_cursor.off end
		end

	template_by_shortcut (a_shortcut: attached READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_template: attached CODE_TEMPLATE_DEFINITION
			l_cursor: DS_BILINEAR_CURSOR [attached CODE_TEMPLATE_DEFINITION]
		do
			l_cursor := code_templates.new_cursor
			from l_cursor.finish until l_cursor.before loop
				l_template := l_cursor.item
				if a_shortcut.as_string_32.is_equal (l_template.metadata.shortcut) then
					Result := l_template
					l_cursor.go_before
				else
					l_cursor.back
				end
			end
			check gobo_cursor_cleaned_up: l_cursor.off end
		end

	templates_by_category (a_categories: attached DS_BILINEAR [attached READABLE_STRING_GENERAL]; a_conjunctive: BOOLEAN): attached DS_ARRAYED_LIST [attached CODE_TEMPLATE_DEFINITION]
			-- <Precursor>
		local
			l_categories: attached CODE_CATEGORY_COLLECTION
			l_cat_cursor: DS_BILINEAR_CURSOR [attached READABLE_STRING_GENERAL]
			l_cursor: DS_HASH_TABLE_CURSOR [TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], READABLE_STRING_8]
			l_item: TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_continue: BOOLEAN
		do
			create Result.make_default
			l_cat_cursor := a_categories.new_cursor
			l_cursor := cataloged_template_definitions.new_cursor

				-- Iterate code template definitions for matching categories
			from l_cursor.start until l_cursor.after loop
				l_item := l_cursor.item
				if l_item /= Void and then attached {attached CODE_TEMPLATE_DEFINITION} l_item.definition as l_definition then
						-- Iterate supplied applicable categories for a matching code template definition category.
					l_continue := False
					l_categories := l_definition.metadata.categories
					if a_conjunctive then
						from l_cat_cursor.start until l_cat_cursor.after or else not l_categories.has (l_cat_cursor.item) loop
							l_cat_cursor.forth
						end
						if l_cat_cursor.after then
								-- Contains all categories
							Result.force_last (l_definition)
						end
					else
						from l_cat_cursor.start until l_cat_cursor.after or l_continue loop
							l_continue := l_categories.has (l_cat_cursor.item)
							if l_continue then
								Result.force_last (l_definition)
							end
							l_cat_cursor.forth
						end
					end
				end
				l_cursor.forth
			end
			sort_templates_by_title (Result)
		end

feature -- Events

	catalog_changed_event: attached EVENT_TYPE [TUPLE]
			-- <Precursor>

feature {NONE} -- Helpers

	logger_service: attached SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		do
			if attached {attached SERVICE_CONSUMER [LOGGER_S]} internal_logger_service as l_service then
				Result := l_service
			else
				create Result
				internal_logger_service := Result
			end
		end

feature -- Basic operations

	rescan (a_folder: attached READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_empty: BOOLEAN
		do
			l_empty := cataloged_folder_files.is_empty
			if not catalog_changed_event.is_suspended then
				catalog_changed_event.perform_suspended_action (agent rescan (a_folder))
				if not l_empty or else l_empty /= cataloged_folder_files.is_empty then
					catalog_changed_event.publish (Void)
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
			l_keys: DS_BILINEAR [STRING]
			l_key: STRING
			l_empty: BOOLEAN
		do
			if not catalog_changed_event.is_suspended then
				l_empty := cataloged_folder_files.is_empty
				catalog_changed_event.perform_suspended_action (agent rescan_catalog)
				if not l_empty or else l_empty /= cataloged_folder_files.is_empty then
					catalog_changed_event.publish (Void)
				end
			else
					-- Remove cataloged data.
				cataloged_folder_files.wipe_out
				cataloged_template_definitions.wipe_out

				l_keys := cataloged_folder_files.keys
				if not l_keys.is_empty then
						-- Extend catalogs
					from l_keys.start until l_keys.after loop
						l_key := l_keys.item_for_iteration
						check l_key_attached: l_key /= Void end
						extend_catalog (l_key)
						l_keys.forth
					end
				end
			end
		ensure then
			cataloged_folder_files_count_unchanged:
				old not cataloged_folder_files.is_empty implies
				(cataloged_folder_files.count = old cataloged_folder_files.count)
		end

feature -- Extension

	extend_catalog (a_folder: attached READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_definitions: like cataloged_template_definitions
			l_definition: TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_files: attached DS_ARRAYED_LIST [attached STRING]
			l_file: attached STRING
			l_changed: BOOLEAN
		do
			l_files := file_utilities.scan_for_files (a_folder, -1, code_file_regex, Void)
			if not l_files.is_empty then
				l_definitions := cataloged_template_definitions
				from l_files.start until l_files.after loop
					l_file := l_files.item_for_iteration
					if l_definitions.has (l_file) then
							-- The template definition already exists, no need to build
							-- the definition files.
						l_definition := l_definitions.item (l_file)
						l_definition.ref_count := l_definition.ref_count + 1
					else
							-- Build code template definition and add to the catalog
						create l_definition
						l_definition.definition := build_template (l_files.item_for_iteration)
						l_definition.ref_count := 1
						l_definitions.force_last (l_definition, l_file)
						l_changed := True

						if l_definition.definition /= Void then
								-- A new declaration was added, so invalidate the cached code templates
							internal_code_templates := Void
						end
					end
					l_files.forth
				end
			end

				-- Extends the folder catalog
			cataloged_folder_files.put (l_files, a_folder.as_string_8)

			if l_changed then
				catalog_changed_event.publish (Void)
			end
		end

feature -- Removal

	remove_catalog (a_folder: attached READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			l_catalog: like cataloged_folder_files
			l_folder: STRING
			l_files: attached DS_ARRAYED_LIST [attached READABLE_STRING_GENERAL]
			l_definitions: like cataloged_template_definitions
			l_definition: TUPLE [definition: detachable CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_file: STRING
			l_changed: BOOLEAN
		do
			l_catalog := cataloged_folder_files
			l_folder := a_folder.as_string_8
			l_files := l_catalog.item (l_folder)
			if not l_files.is_empty then
				l_definitions := cataloged_template_definitions
				from l_files.start until l_files.after loop
					l_file := l_files.item_for_iteration.as_string_8
					if l_definitions.has (l_file) then
							-- Decrement reference count
						l_definition := l_definitions.item (l_file)
						l_definition.ref_count := l_definition.ref_count - 1
						if l_definition.ref_count = 0 then
							l_definitions.remove (l_file)
							l_changed := True

							if l_definition.definition /= Void then
									-- An existing declaration was remove, so invalidate the cached code templates
								internal_code_templates := Void
							end
						end
					else
							-- This means a file was not added correctly in `extend_catalog'.
						check False end
					end
					l_files.forth
				end
			end

				-- Remove from the folder/file catalog.
			l_catalog.remove (l_folder)

			if l_changed then
				catalog_changed_event.publish (Void)
			end
		end

feature {NONE} -- Helpers

	file_utilities: attached FILE_UTILITIES
			-- Shared access to file utilities.
		once
			create Result
		end

	xml_parser: attached XM_EIFFEL_PARSER
			-- Xml parser used to parse the code template files.
		once
			create Result.make
		end

feature {NONE} -- Basic operations

	build_template (a_file_name: attached READABLE_STRING_GENERAL): detachable CODE_TEMPLATE_DEFINITION
			-- Builds a code template definition model from a file.
			--
			-- `a_file_name': Path to the code template file.
			-- `Result': A code template definition model or Void if the template file could not be parsed.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: file_system.file_exists (a_file_name.as_string_8)
		local
			l_parser: like xml_parser
			l_file_name: STRING
			l_resolver: attached XM_FILE_EXTERNAL_RESOLVER
			l_callbacks: attached CODE_TEMPLATE_LOAD_CALLBACK
			retried: BOOLEAN
		do
			if not retried then
				l_file_name := a_file_name.as_string_8
				check l_file_name_attached: l_file_name /= Void end

				create l_resolver.make
				l_resolver.resolve (l_file_name)
				if not l_resolver.has_error then
						-- File is loaded, create the callbacks and parse the XML.
					l_parser := xml_parser
					create l_callbacks.make (create {attached CODE_FACTORY}, l_parser)
					check
						l_parser_callbacks_set: l_parser.callbacks = l_callbacks
					end
					l_parser.parse_from_stream (l_resolver.last_stream)
					l_resolver.last_stream.close
					if not l_callbacks.has_error then
							-- Successful parse, return the template.
						Result := l_callbacks.last_code_template_definition
					else
							-- Log parse error
						if logger_service.is_service_available then
							logger_service.service.put_message_with_severity (
								(create {ERROR_MESSAGES}).e_code_template_parse (l_callbacks.last_error_message, l_file_name),
								{ENVIRONMENT_CATEGORIES}.internal_event,
								{PRIORITY_LEVELS}.high)
						end
					end
				end
			else
				check l_file_name_attached: l_file_name /= Void end

				if l_resolver.last_stream /= Void then
					l_resolver.last_stream.close
				end

					-- Log failed load error
				if logger_service.is_service_available then
					logger_service.service.put_message_with_severity (
						(create {ERROR_MESSAGES}).e_code_template_read (l_file_name),
						{ENVIRONMENT_CATEGORIES}.internal_event,
						{PRIORITY_LEVELS}.high)
				end
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature {NONE} -- Regular expressions

	frozen code_file_regex: attached RX_PCRE_MATCHER
			-- Regular expression for match code template file names
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("\.code$")
		ensure
			result_is_compiled: Result.is_compiled
		end

feature {NONE} -- Internal implementation cache

	internal_code_templates: detachable like code_templates
			-- Cached version of `code_templates'.
			-- Note: Do not use directly!

	internal_logger_service: detachable like logger_service
			-- Cached version of `logger_service'.
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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

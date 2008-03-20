indexing
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

	SAFE_AUTO_DISPOSABLE

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the code template catalog
		do
			create cataloged_folder_files.make_default
			create cataloged_template_definitions.make_default
			if {PLATFORM}.is_windows and then {l_tester: !KL_EQUALITY_TESTER [!STRING]} create {KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER} then
				cataloged_folder_files.set_key_equality_tester (l_tester)
				cataloged_template_definitions.set_key_equality_tester (l_tester)
			end
		end

feature -- Access

	code_templates: !DS_BILINEAR [!CODE_TEMPLATE_DEFINITION]
			-- <Precursor>
		local
			l_result: !DS_ARRAYED_LIST [!CODE_TEMPLATE_DEFINITION]
			l_item: TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
		do
			if {l_templates: !DS_BILINEAR [!CODE_TEMPLATE_DEFINITION]} internal_code_templates then
				Result := l_templates
			else
				create l_result.make_default
				if {l_cursor: !DS_HASH_TABLE_CURSOR [TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], !STRING_8]} cataloged_template_definitions.new_cursor then
					from l_cursor.start until l_cursor.after loop
						l_item := l_cursor.item
						if l_item /= Void and then {l_definition: !CODE_TEMPLATE_DEFINITION} l_item.definition then
							l_result.force_last (l_definition)
						end
						l_cursor.forth
					end
				end

				Result ?= l_result
				internal_code_templates := Result
			end
		end

feature {NONE} -- Access

	cataloged_folder_files: !DS_HASH_TABLE [!DS_ARRAYED_LIST [!STRING], !STRING_8]
			-- Cataloged folders, where template files are extracted from.
			-- Key: Folder path
			-- Value: List of file names

	cataloged_template_definitions: !DS_HASH_TABLE [TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], !STRING]
			-- Cataloged code template definitions, with reference count.
			-- Key: Code template definition file name
			-- Value: A code template definition with a cataloged reference count.

feature -- Status report

	is_cataloged (a_folder: STRING_GENERAL): BOOLEAN
			-- <Precursor>
		do
			Result := cataloged_folder_files.has (({!STRING_8}) #? a_folder.as_string_8)
		ensure then
			cataloged_folder_files_has_a_folder: Result implies cataloged_folder_files.has (({!STRING_8}) #? a_folder.as_string_8)
		end

feature -- Query

	template_by_file_name (a_file_name: STRING_GENERAL): ?CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_templates: like cataloged_template_definitions
			l_file: TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_fn: !STRING_8
		do
			l_fn ?= a_file_name.as_string_8
			l_templates := cataloged_template_definitions
			if l_templates.has (l_fn) then
				l_file := l_templates.item (l_fn)
				if l_file /= Void then
					Result := l_file.definition
				end
			end
		end

	template_by_title (a_title: STRING_GENERAL): ?CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_template: !CODE_TEMPLATE_DEFINITION
		do
			if {l_cursor: !DS_BILINEAR_CURSOR [!CODE_TEMPLATE_DEFINITION]} code_templates.new_cursor then
				from l_cursor.finish until l_cursor.before or Result /= Void loop
					l_template := l_cursor.item
					if a_title.as_string_32.is_equal (l_template.metadata.title) then
						Result := l_template
					end
					l_cursor.back
				end
			end
		end

	template_by_shortcut (a_shortcut: STRING_GENERAL): ?CODE_TEMPLATE_DEFINITION
			-- <Precursor>
		local
			l_template: !CODE_TEMPLATE_DEFINITION
		do
			if {l_cursor: !DS_BILINEAR_CURSOR [!CODE_TEMPLATE_DEFINITION]} code_templates.new_cursor then
				from l_cursor.finish until l_cursor.before or Result /= Void loop
					l_template := l_cursor.item
					if a_shortcut.as_string_32.is_equal (l_template.metadata.shortcut) then
						Result := l_template
					end
					l_cursor.back
				end
			end
		end

	templates_by_category (a_categories: DS_BILINEAR [STRING_GENERAL]): !DS_ARRAYED_LIST [!CODE_TEMPLATE_DEFINITION]
			-- <Precursor>
		local
			l_categories: !CODE_CATEGORY_COLLECTION
			l_item: TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_continue: BOOLEAN
		do
			create Result.make_default
			if {l_cursor: !DS_HASH_TABLE_CURSOR [TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8], !STRING_8]} cataloged_template_definitions.new_cursor then
				if {l_cat_cursor: !DS_BILINEAR_CURSOR [!STRING_32]} a_categories.new_cursor then
						-- Iterate code template definitions for matching categories
					from l_cursor.start until l_cursor.after loop
						l_item := l_cursor.item
						if l_item /= Void and then {l_definition: !CODE_TEMPLATE_DEFINITION} l_item.definition then
								-- Iterate supplied applicable categories for a matching code template definition category.
							l_continue := False
							l_categories := l_definition.metadata.categories
							from l_cat_cursor.start until l_cat_cursor.after or l_continue loop
								l_continue := l_categories.has (l_cat_cursor.item)
								if l_continue then
									Result.force_last (l_definition)
								end
								l_cat_cursor.forth
							end
						end
						l_cursor.forth
					end
				end
			end
		end

feature {NONE} -- Helpers

	logger_service: !SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		do
			if {l_service: !SERVICE_CONSUMER [LOGGER_S]} internal_logger_service then
				Result := l_service
			else
				create Result
				internal_logger_service := Result
			end
		end

feature -- Basic operations

	rescan (a_folder: STRING_GENERAL)
			-- <Precursor>
		do
			remove_catalog (a_folder)
			extend_catalog (a_folder)
		ensure then
			cataloged_folder_files_count_unchanged: cataloged_folder_files.count = old cataloged_folder_files.count
		end

	rescan_catalog
			-- <Precursor>
		local
			l_keys: DS_BILINEAR [!STRING_8]
		do
			l_keys := cataloged_folder_files.keys.twin

				-- Remove cataloged data.
			cataloged_folder_files.wipe_out
			cataloged_template_definitions.wipe_out

			if not l_keys.is_empty then
					-- Extend catalogs
				from l_keys.start until l_keys.after loop
					extend_catalog (l_keys.item_for_iteration)
					l_keys.forth
				end
			end
		ensure then
			cataloged_folder_files_count_unchanged: cataloged_folder_files.count = old cataloged_folder_files.count
		end

feature -- Extension

	extend_catalog (a_folder: STRING_GENERAL)
			-- <Precursor>
		local
			l_definitions: like cataloged_template_definitions
			l_definition: TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_files: !DS_ARRAYED_LIST [!STRING_8]
			l_file: !STRING_8
		do
			l_files := file_utilities.scan_for_files (a_folder, -1, Void, Void)
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

						if l_definition.definition /= Void then
								-- A new declaration was added, so invalidate the cached code templates
							internal_code_templates := Void
						end
					end
					l_files.forth
				end
			end

				-- Extends the folder catalog
			cataloged_folder_files.put (l_files, ({!STRING}) #? a_folder.as_string_8)
		end

feature -- Removal

	remove_catalog (a_folder: STRING_GENERAL)
			-- <Precursor>
		local
			l_catalog: like cataloged_folder_files
			l_files: !DS_ARRAYED_LIST [!STRING_8]
			l_definitions: like cataloged_template_definitions
			l_definition: TUPLE [definition: ?CODE_TEMPLATE_DEFINITION; ref_count: NATURAL_8]
			l_file: !STRING_8
			l_folder: !STRING_8
		do
			l_folder ?= a_folder.as_string_8
			l_catalog := cataloged_folder_files
			l_files := l_catalog.item (l_folder)
			if not l_files.is_empty then
				l_definitions := cataloged_template_definitions
				from l_files.start until l_files.after loop
					l_file := l_files.item_for_iteration
					if l_definitions.has (l_file) then
							-- Decrement reference count
						l_definition := l_definitions.item (l_file)
						l_definition.ref_count := l_definition.ref_count - 1
						if l_definition.ref_count = 0 then
							l_definitions.remove (l_file)

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
		end

feature {NONE} -- Helpers

	file_utilities: !FILE_UTILITIES
			-- Shared access to file utilities.
		once
			create Result
		end

	xml_parser: !XM_EIFFEL_PARSER
			-- Xml parser used to parse the code template files.
		once
			create Result.make
		end

feature {NONE} -- Basic operations

	build_template (a_file_name: !STRING_8): ?CODE_TEMPLATE_DEFINITION
			-- Builds a code template definition model from a file.
			--
			-- `a_file_name': Path to the code template file.
			-- `Result': A code template definition model or Void if the template file could not be parsed.
		require
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: file_system.file_exists (a_file_name)
		local
			l_parser: like xml_parser
			l_resolver: !XM_FILE_EXTERNAL_RESOLVER
			l_callbacks: !CODE_TEMPLATE_LOAD_CALLBACK
			retried: BOOLEAN
		do
			if not retried then
				create l_resolver.make
				l_resolver.resolve (a_file_name)
				if not l_resolver.has_error then
						-- File is loaded, create the callbacks and parse the XML.
					l_parser := xml_parser
					create l_callbacks.make (create {!CODE_FACTORY}, l_parser)
					check
						l_parser_callbacks_set: l_parser.callbacks = l_callbacks
					end
					l_parser.parse_from_stream (l_resolver.last_stream)
					if not l_callbacks.has_error then
							-- Successful parse, return the template.
						Result := l_callbacks.last_code_template_definition
					else
							-- Log parse error
						if logger_service.is_service_available then
							logger_service.service.put_message_with_severity (
								(create {ERROR_MESSAGES}).e_code_template_parse (l_callbacks.last_error_message, a_file_name),
								{ENVIRONMENT_CATEGORIES}.internal_event,
								{PRIORITY_LEVELS}.normal)
						end
					end
				end
			else
					-- Log failed load error
				if logger_service.is_service_available then
					logger_service.service.put_message_with_severity (
						(create {ERROR_MESSAGES}).e_code_template_read (a_file_name),
						{ENVIRONMENT_CATEGORIES}.internal_event,
						{PRIORITY_LEVELS}.normal)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Internal implementation cache

	internal_code_templates: ?DS_BILINEAR [!CODE_TEMPLATE_DEFINITION]
			-- Cached version of `code_templates'
			-- Note: Do not use directly!

	internal_logger_service: SERVICE_CONSUMER [LOGGER_S]
			-- Cached version of `logger_service'
			-- Note: Do not use directly!

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

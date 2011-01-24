note
	description: "Summary description for {ER_CODE_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create uicc_manager
		end

feature -- Command

	generate_all_codes
			--
		do
			group_counter := 0
			button_counter := 0

			uicc_manager.compile
			-- Check XML compilation error here?
			save_project_info
			generate_ecf
			copy_predefine_classes
			generate_readonly_classes

			generate_eiffel_class_for_header_file

		end

feature -- Query

	is_uicc_available: BOOLEAN
			--
		do
			Result := uicc_manager.check_if_uicc_available
		end

feature {NONE} -- Constants

	command_name_constants: STRING = "command_name_constants"
			-- Constants for command name file

feature {NONE} -- Implementation

	ecf_template_file_path: STRING
			--
		local
			l_file_name: FILE_NAME
			l_constants: ER_MISC_CONSTANTS
		once
			create l_constants
			create l_file_name.make_from_string (l_constants.template)
			l_file_name.set_file_name ("eiffelribbon_ecf_template.ecf")
			Result := l_file_name
		end

	save_project_info
			--
		local
			l_sed: SED_MEDIUM_READER_WRITER
			l_sed_utility: SED_STORABLE_FACILITIES
			l_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_singleton: ER_SHARED_SINGLETON
		do
			create l_constants
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_constants.project_full_file_name as l_project_config then
					create l_file.make (l_project_config)
					l_file.create_read_write
					create l_sed.make (l_file)
					l_sed.set_for_writing

					create l_sed_utility
					l_sed_utility.store (l_info, l_sed)

					l_file.close
				end
			end
		end

	generate_ecf
			--
		local
			l_file, l_dest_file: RAW_FILE
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: FILE_NAME
		do
			-- Copy template ecf
			create l_file.make (ecf_template_file_path)
			if l_file.exists then
				create l_singleton
				if attached l_singleton.project_info_cell.item as l_info then
					if attached l_info.project_location as l_location and then not l_location.is_empty then
						create l_file_name.make_from_string (l_location)
						l_file_name.set_file_name ("ribbon_project.ecf")
						create l_dest_file.make (l_file_name)
						-- Don't replace destination file
						if not l_dest_file.exists then
							l_dest_file.create_read_write

							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop

								l_file.read_line

								l_dest_file.put_string (l_file.last_string+ "%N")
							end
							l_dest_file.close
						end
					end
				end

			else
				check corrupted_installation: False end
			end

			--
		end

	copy_predefine_classes
			--
		local
			l_file, l_dest_file: RAW_FILE
			l_dir: DIRECTORY
			l_constants: ER_MISC_CONSTANTS
			l_sub_files: ARRAYED_LIST [STRING_8]
			l_file_name, l_dest_file_name, l_source_dir: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir: STRING
		do
			create l_singleton
			l_sub_dir := "code_predefined"
			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants
					create l_source_dir.make_from_string (l_constants.template)
					l_source_dir.set_subdirectory (l_sub_dir)
					create l_dir.make_open_read (l_source_dir)

					from
						l_sub_files := l_dir.linear_representation
						l_sub_files.start
					until
						l_sub_files.after
					loop
						create l_file_name.make_from_string (l_constants.template)
						l_file_name.set_subdirectory (l_sub_dir)
						l_file_name.set_file_name (l_sub_files.item)
						create l_file.make (l_file_name)

						if l_file.exists and then l_file.is_readable
							and then not l_file.is_directory
							and then not l_sub_files.item.is_equal (".")
							and then not l_sub_files.item.is_equal ("..") then
							create l_dest_file_name.make_from_string (l_project_location)
							l_dest_file_name.set_file_name (l_sub_files.item)
							create l_dest_file.make (l_dest_file_name)
							-- Don't replace destination files
							if not l_dest_file.exists then
								l_dest_file.create_read_write
								l_file.open_read
								l_file.start
								l_file.copy_to (l_dest_file)

								l_file.close
								l_dest_file.close
							end

						end

						l_sub_files.forth
					end
				end
			end

		end

	generate_eiffel_class_for_header_file
			--
		local
			l_translator: ER_H_FILE_TRANSLATOR
			l_singleton: ER_SHARED_SINGLETON
			l_source_header: FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_source_header.make_from_string (l_project_location)
					l_source_header.set_file_name ({ER_MISC_CONSTANTS}.header_file_name)
					create l_translator.make (l_source_header, l_project_location, command_name_constants)
					l_translator.translate
				end
			end

		end

	generate_readonly_classes
			--
		local
			l_list: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]
			l_singleton: ER_SHARED_SINGLETON
		do
			-- Parse EV_TREE until Ribbon.Tabs
--			from
				create l_singleton
				l_list := l_singleton.layout_constructor_list
--				l_list.start
--			until
--				l_list.after
--			loop
--				generate_readonly_classes_imp (l_list.item)
--				l_list.forth
--			end
			-- FIXME: Current only generate classes for default window (application mode is 0)
			generate_readonly_classes_imp (l_list.first)
		end

	generate_readonly_classes_imp (a_layout_constructor: ER_LAYOUT_CONSTRUCTOR)
			-- Generate readonly ribbon widget classes
		local
			l_tree: EV_TREE
			l_tree_node: detachable EV_TREE_NODE
			l_xml: ER_XML_CONSTANTS
		do
			from
				create l_xml
				l_tree := a_layout_constructor.widget
				l_tree.start
			until
				l_tree.after or l_tree_node /= Void
			loop
				l_tree_node := tree_node_with_text (l_tree.item, l_xml.ribbon_tabs)

				l_tree.forth
			end

			if l_tree_node /= Void then
				-- Start real generation
				generate_tool_bar_class (l_tree_node)
			end
		end

	tree_node_with_text (a_tree_node: EV_TREE_NODE; a_text: STRING): detachable EV_TREE_NODE
			-- Recursive find a tree node which has `a_text'
		require
			not_void: a_tree_node /= void
			not_void: a_text /= void
		local
			l_xml: ER_XML_CONSTANTS
		do
			create l_xml
			if a_tree_node.text.is_equal (l_xml.ribbon_tabs) then
				Result := a_tree_node
			else
				from
					a_tree_node.start
				until
					a_tree_node.after
				loop
					Result := tree_node_with_text (a_tree_node.item, a_text)
					a_tree_node.forth
				end
			end
		end

	uicc_manager: ER_UICC_MANAGER
			--

	generate_tool_bar_class (a_tabs_root_note: EV_TREE_NODE)
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_tabs)
		local
			l_tab_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_file, l_sub_imp_dir: STRING
			l_last_string: STRING
			l_tab_creation_string, l_tab_registry_string, l_tab_declaration_string: STRING
		do
			-- First check how many tabs
			l_tab_count := a_tabs_root_note.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_file := "ribbon.e"
			l_sub_imp_dir := "code_generated_everytime"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
							l_tab_creation_string := tab_creation_string (a_tabs_root_note)
							l_tab_registry_string := tab_registry_string (a_tabs_root_note)
							l_tab_declaration_string := tab_declaration_string (a_tabs_root_note)
						until
							l_file.after
						loop
							l_file.read_line
							l_last_string := l_file.last_string
							l_last_string.replace_substring_all ("$TAB_CREATION", l_tab_creation_string)
							l_last_string.replace_substring_all ("$TAB_REGISTRY", l_tab_registry_string)
							l_last_string.replace_substring_all ("$TAB_DECLARATION", l_tab_declaration_string)

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

				end
			end

			-- Generate tab classes
			from
				a_tabs_root_note.start
			until
				a_tabs_root_note.after
			loop
				check a_tabs_root_note.item.text.is_equal ({ER_XML_CONSTANTS}.tab) end
				generate_tab_class (a_tabs_root_note.item, a_tabs_root_note.index)
				a_tabs_root_note.forth
			end

		end

	tab_creation_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_tabs)
		local
			l_count, l_index: INTEGER
			l_template, l_command_string: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin

				if attached {ER_TREE_NODE_TAB_DATA} a_tabs_root_note.i_th (l_index).data as l_group_data then
					if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_command_string := "<<{" + command_name_constants.as_upper + "}." + l_command_name + ">>"
						l_generated.replace_substring_all ("$INDEX", l_command_name.as_lower)
					else
						l_command_string := "<<>>"
						l_generated.replace_substring_all ("$INDEX", "tab_" + l_index.out)
					end
				else
					l_command_string := "<<>>"
					l_generated.replace_substring_all ("$INDEX", "tab_" + l_index.out)
				end
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	tab_registry_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_tabs)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			--"tabs.extend (tab_1)"
			create Result.make_empty
			l_template := "%T%T%Ttabs.extend ($TAB)"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_TAB_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$TAB", l_command_name.as_lower)
					else
						l_generated.replace_substring_all ("$TAB", "tab_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$TAB", "tab_" + l_index.out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	tab_declaration_string (a_tabs_root_note: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tabs_root_note /= Void
			valid:  a_tabs_root_note.text.is_equal ({ER_XML_CONSTANTS}.ribbon_tabs)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"

			from
				l_index := 1
				l_count := a_tabs_root_note.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_TAB_DATA} a_tabs_root_note.i_th (l_index).data as l_tab_data then
					if attached l_tab_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_generated.replace_substring_all ("$INDEX_1", l_command_name.as_lower)
						l_generated.replace_substring_all ("$INDEX_2", l_command_name.as_upper)
					else
						l_generated.replace_substring_all ("$INDEX_1", "tab_" + l_index.out)
						l_generated.replace_substring_all ("$INDEX_2", "RIBBON_TAB_" + l_index.out)
					end
				else
					l_generated.replace_substring_all ("$INDEX_1", "tab_" + l_index.out)
					l_generated.replace_substring_all ("$INDEX_2", "RIBBON_TAB_" + l_index.out)
				end
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	generate_tab_class (a_tab_node: EV_TREE_NODE; a_index: INTEGER)
			--
		require
			not_void: a_tab_node /= void
			valid: a_tab_node.text.is_equal ({ER_XML_CONSTANTS}.tab)
		local
			l_group_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_tab_file, l_sub_imp_dir, l_tool_bar_tab_imp_file: STRING
			l_group_creation_string, l_group_registry_string, l_group_declaration_string: STRING
			l_last_string: STRING
			l_identifier_name: detachable STRING
		do
			-- First check how many groups
			l_group_count := a_tab_node.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_tab_file := "ribbon_tab_imp"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_tab_imp_file := "ribbon_tab"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar tab class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					if attached {ER_TREE_NODE_TAB_DATA} a_tab_node.data as l_data then
						if attached l_data.command_name as l_command_name  and then not l_command_name.is_empty then
							l_identifier_name := l_command_name
						end
					end
					l_file_name.set_file_name (l_tool_bar_tab_file + ".e")

					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= void  then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + "_imp.e")
							create l_dest_file.make_create_read_write (l_dest_file_name)
						else
							l_dest_file_name.set_file_name (l_tool_bar_tab_file)
							create l_dest_file.make_create_read_write (l_dest_file_name + "_" + a_index.out + ".e")
						end

						from
							l_group_creation_string := group_creation_string (a_tab_node)
							l_group_registry_string := group_registry_string (a_tab_node)
							l_group_declaration_string := group_declaration_string (a_tab_node)
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- replace/add tab codes here
							l_file.read_line
							l_last_string := l_file.last_string
							l_last_string.replace_substring_all ("$GROUP_CREATION", l_group_creation_string)
							l_last_string.replace_substring_all ("$GROUP_REGISTRY", l_group_registry_string)
							l_last_string.replace_substring_all ("$GROUP_DECLARATION", l_group_declaration_string)

							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper + "_IMP")
							else
								l_last_string.replace_substring_all ("$INDEX", "RIBBON_TAB_IMP_" + a_index.out)
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar tab imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_tab_imp_file + ".e")

					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + ".e")
							create l_dest_file.make (l_dest_file_name)
						else
							l_dest_file_name.set_file_name (l_tool_bar_tab_imp_file)
							create l_dest_file.make (l_dest_file_name + "_" + a_index.out + ".e")
						end

						-- Don't replace destination file if exists
						if not l_dest_file.exists then
							l_dest_file.create_read_write
							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								-- replace/add tab codes here
								l_file.read_line
								l_last_string := l_file.last_string
								if l_identifier_name /= Void then
									l_last_string.replace_substring_all ("$INDEX_1", l_identifier_name.as_upper)
									l_last_string.replace_substring_all ("$INDEX_2", l_identifier_name.as_upper + "_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX_1", "RIBBON_TAB_" + a_index.out)
									l_last_string.replace_substring_all ("$INDEX_2", "RIBBON_TAB_IMP_" + a_index.out)
								end
								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end
				end
			end

			-- Generate group classes
			from
				a_tab_node.start
			until
				a_tab_node.after
			loop
				check a_tab_node.item.text.is_equal ({ER_XML_CONSTANTS}.group) end
				generate_group_class (a_tab_node.item, a_tab_node.index + group_counter)
				a_tab_node.forth
			end
			group_counter := group_counter + a_tab_node.count
		end

	group_creation_string (a_tab_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tab_node /= void
			valid: a_tab_node.text.is_equal ({ER_XML_CONSTANTS}.tab)
		local
			l_count, l_index: INTEGER
			l_template, l_command_string: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			from
				l_index := 1
				l_count := a_tab_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_GROUP_DATA} a_tab_node.i_th(l_index).data as l_data
					and then attached l_data.command_name as l_identify_name
					and then not l_identify_name.is_empty then
					l_generated.replace_substring_all ("$INDEX", l_identify_name.as_lower)
				else
					l_generated.replace_substring_all ("$INDEX", "group_" + (group_counter + l_index).out)
				end

				if attached {ER_TREE_NODE_GROUP_DATA} a_tab_node.i_th (l_index).data as l_group_data then
					if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_command_string := "<<{" + command_name_constants.as_upper + "}." + l_command_name + ">>"
					else
						l_command_string := "<<>>"
					end
				else
					l_command_string := "<<>>"
				end
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	group_registry_string (a_tab_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tab_node /= void
			valid: a_tab_node.text.is_equal ({ER_XML_CONSTANTS}.tab)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			--"groups.extend (group_1)"
			create Result.make_empty
			l_template := "%T%T%Tgroups.extend ($INDEX)"

			from
				l_index := 1
				l_count := a_tab_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_GROUP_DATA} a_tab_node.i_th(l_index).data as l_data
					and then attached l_data.command_name as l_identify_name
					and then not l_identify_name.is_empty then
					l_generated.replace_substring_all ("$INDEX", l_identify_name.as_lower)
				else
					l_generated.replace_substring_all ("$INDEX", "group_" + (group_counter + l_index).out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	group_declaration_string (a_tab_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_tab_node /= void
			valid: a_tab_node.text.is_equal ({ER_XML_CONSTANTS}.tab)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"

			from
				l_index := 1
				l_count := a_tab_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_GROUP_DATA} a_tab_node.i_th(l_index).data as l_data
					and then attached l_data.command_name as l_identify_name
					and then not l_identify_name.is_empty then

					l_generated.replace_substring_all ("$INDEX_1", l_identify_name.as_lower)
					l_generated.replace_substring_all ("$INDEX_2", l_identify_name.as_upper)
				else
					l_generated.replace_substring_all ("$INDEX_1", "group_" + (group_counter + l_index).out)
					l_generated.replace_substring_all ("$INDEX_2", "RIBBON_GROUP_" + (group_counter + l_index).out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	group_counter, button_counter: INTEGER
			-- When generating group classes , it count how many groups totally

	generate_group_class (a_group_node: EV_TREE_NODE; a_index: INTEGER)
			--
		require
			not_void: a_group_node /= void
			valid: a_group_node.text.is_equal ({ER_XML_CONSTANTS}.group)
		local
			l_button_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_group_file, l_sub_imp_dir, l_tool_bar_group_imp_file: STRING
			l_last_string: STRING
			l_button_creation_string, l_button_registry_string, l_button_declaration_string: STRING
			l_identifier_name: detachable STRING
		do
			-- First check how many groups
			l_button_count := a_group_node.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_group_file := "ribbon_group_imp"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_group_imp_file := "ribbon_group"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar group class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_group_file + ".e")
					create l_file.make (l_file_name)

					if attached {ER_TREE_NODE_GROUP_DATA} a_group_node.data as l_data then
						if attached l_data.command_name as l_command_name  and then not l_command_name.is_empty then
							l_identifier_name := l_command_name
						end
					end

					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + "_imp.e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_group_file + "_" + a_index.out + ".e")
						end

						create l_dest_file.make_create_read_write (l_dest_file_name)

						from
							l_button_creation_string := button_creation_string (a_group_node)
							l_button_registry_string := button_registry_string (a_group_node)
							l_button_declaration_string := button_declaration_string (a_group_node)
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- replace/add tab codes here
							l_file.read_line
							l_last_string := l_file.last_string
							l_last_string.replace_substring_all ("$BUTTON_CREATION", l_button_creation_string)
							l_last_string.replace_substring_all ("$BUTTON_REGISTRY", l_button_registry_string)
							l_last_string.replace_substring_all ("$BUTTON_DECLARATION", l_button_declaration_string)
							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper + "_IMP")
							else
								l_last_string.replace_substring_all ("$INDEX", "RIBBON_GROUP_IMP_" + a_index.out)
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar group imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_group_imp_file + ".e")
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + ".e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_group_imp_file + "_" + a_index.out + ".e")
						end

						create l_dest_file.make (l_dest_file_name)
						-- Don't replace destination file if exists
						if not l_dest_file.exists then
							l_dest_file.create_read_write
							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								-- replace/add tab codes here
								l_file.read_line
								l_last_string := l_file.last_string
								if l_identifier_name /= Void then
									l_last_string.replace_substring_all ("$INDEX_1", l_identifier_name.as_upper)
									l_last_string.replace_substring_all ("$INDEX_2", l_identifier_name.as_upper + "_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX_1", "RIBBON_GROUP_" + a_index.out)
									l_last_string.replace_substring_all ("$INDEX_2", "RIBBON_GROUP_IMP_" + a_index.out)
								end

								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end
				end
			end

			-- Generate button classes
			from
				a_group_node.start
			until
				a_group_node.after
			loop
				if a_group_node.item.text.is_equal ({ER_XML_CONSTANTS}.button)  then
					generate_button_class (a_group_node.item, a_group_node.index + button_counter)
				elseif a_group_node.item.text.is_equal ({ER_XML_CONSTANTS}.check_box) then
					generate_checkbox_class (a_group_node.item, a_group_node.index + button_counter)
				else
					check not_implemented: False end
				end

				a_group_node.forth
			end
			button_counter := button_counter + a_group_node.count
		end

	button_creation_string (a_group_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_group_node /= void
			valid: a_group_node.text.is_equal ({ER_XML_CONSTANTS}.group)
		local
			l_count, l_index: INTEGER
			l_template, l_command_string: STRING
			l_generated: detachable STRING
		do
			create Result.make_empty
			l_template := "%T%T%Tcreate $INDEX.make_with_command_list ($COMMAND_IDS)"

			from
				l_index := 1
				l_count := a_group_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_BUTTON_DATA} a_group_node.i_th(l_index).data as l_data
					and then attached l_data.command_name as l_identify_name
					and then not l_identify_name.is_empty then
					l_generated.replace_substring_all ("$INDEX", l_identify_name.as_lower)
				else
					l_generated.replace_substring_all ("$INDEX", "button_" + (button_counter + l_index).out)
				end

				if attached {ER_TREE_NODE_BUTTON_DATA} a_group_node.i_th (l_index).data as l_group_data then
					if attached l_group_data.command_name as l_command_name and then not l_command_name.is_empty then
						l_command_string := "<<{" + command_name_constants.as_upper + "}." + l_command_name + ">>"
					else
						l_command_string := "<<>>"
					end
				else
					l_command_string := "<<>>"
				end
				l_generated.replace_substring_all ("$COMMAND_IDS", l_command_string)
				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	button_registry_string (a_group_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_group_node /= void
			valid: a_group_node.text.is_equal ({ER_XML_CONSTANTS}.group)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
		do
			--"groups.extend (group_1)"
			create Result.make_empty
			l_template := "%T%T%Tbuttons.extend ($INDEX)"

			from
				l_index := 1
				l_count := a_group_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if attached {ER_TREE_NODE_BUTTON_DATA} a_group_node.i_th(l_index).data as l_data
					and then attached l_data.command_name as l_identify_name
					and then not l_identify_name.is_empty then
					l_generated.replace_substring_all ("$INDEX", l_identify_name.as_lower)
				else
					l_generated.replace_substring_all ("$INDEX", "button_" + (button_counter + l_index).out)
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	button_declaration_string (a_group_node: EV_TREE_NODE): STRING
			--
		require
			not_void: a_group_node /= void
			valid: a_group_node.text.is_equal ({ER_XML_CONSTANTS}.group)
		local
			l_count, l_index: INTEGER
			l_template: STRING
			l_generated: detachable STRING
			l_constants: ER_XML_CONSTANTS
		do
			create Result.make_empty
			l_template := "%T$INDEX_1: $INDEX_2"
			from
				create l_constants
				l_index := 1
				l_count := a_group_node.count
			until
				l_count < l_index
			loop
				l_generated := l_template.twin
				if a_group_node.i_th (1).text.same_string (l_constants.button) then
					if attached {ER_TREE_NODE_BUTTON_DATA} a_group_node.i_th(l_index).data as l_data
						and then attached l_data.command_name as l_identify_name
						and then not l_identify_name.is_empty then
						l_generated.replace_substring_all ("$INDEX_1", l_identify_name.as_lower)
						l_generated.replace_substring_all ("$INDEX_2", l_identify_name.as_upper)
					else
						l_generated.replace_substring_all ("$INDEX_1", "button_" + (button_counter + l_index).out)
						l_generated.replace_substring_all ("$INDEX_2", "RIBBON_BUTTON_" + (button_counter + l_index).out)
					end
				elseif a_group_node.i_th (1).text.same_string (l_constants.check_box) then
					if attached {ER_TREE_NODE_BUTTON_DATA} a_group_node.i_th(l_index).data as l_data
						and then attached l_data.command_name as l_identify_name
						and then not l_identify_name.is_empty then
						l_generated.replace_substring_all ("$INDEX_1", l_identify_name.as_lower)
						l_generated.replace_substring_all ("$INDEX_2", l_identify_name.as_upper)
					else
						l_generated.replace_substring_all ("$INDEX_1", "checkbox_" + (button_counter + l_index).out)
						l_generated.replace_substring_all ("$INDEX_2", "RIBBON_CHECKBOX_" + (button_counter + l_index).out)
					end

				else
					create l_generated.make_empty
					check not_implemented: False end
				end

				l_index := l_index + 1
				if l_generated /= Void then
					Result.append (l_generated + "%N")
				end
			end
		end

	generate_button_class (a_buttn_node: EV_TREE_NODE; a_index: INTEGER)
			--
		require
			not_void: a_buttn_node /= void
			valid: a_buttn_node.text.is_equal ({ER_XML_CONSTANTS}.button)
		local
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_button_file, l_sub_imp_dir, l_tool_bar_button_imp_file: STRING
			l_last_string: STRING
			l_identifier_name: detachable STRING
		do
			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_button_file := "ribbon_button_imp"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_button_imp_file := "ribbon_button"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar button class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_button_file + ".e")
					if attached {ER_TREE_NODE_BUTTON_DATA} a_buttn_node.data as l_data then
						if attached l_data.command_name as l_command_name  and then not l_command_name.is_empty then
							l_identifier_name := l_command_name
						end
					end
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name + "_imp.e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_button_file + "_" + a_index.out + ".e")
						end
						create l_dest_file.make_create_read_write (l_dest_file_name)

						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- replace/add tab codes here
							l_file.read_line
							l_last_string := l_file.last_string
							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper + "_IMP")
							else
								l_last_string.replace_substring_all ("$INDEX", "RIBBON_BUTTON_IMP_" + a_index.out)
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar button imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_button_imp_file + ".e")
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= void then
							l_dest_file_name.set_file_name (l_identifier_name + ".e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_button_imp_file + "_" + a_index.out + ".e")
						end

						create l_dest_file.make (l_dest_file_name)
						if not l_dest_file.exists then
							l_dest_file.create_read_write
							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								-- replace/add tab codes here
								l_file.read_line
								l_last_string := l_file.last_string
								if l_identifier_name /= void then
									l_last_string.replace_substring_all ("$INDEX_1", l_identifier_name.as_upper)
									l_last_string.replace_substring_all ("$INDEX_2", l_identifier_name.as_upper + "_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX_1", "RIBBON_BUTTON_" + a_index.out)
									l_last_string.replace_substring_all ("$INDEX_2", "RIBBON_BUTTON_IMP_" + a_index.out)
								end

								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end
				end
			end
		end

	generate_checkbox_class (a_checkbox_node: EV_TREE_NODE; a_index: INTEGER)
			--
		require
			not_void: a_checkbox_node /= void
			valid: a_checkbox_node.text.is_equal ({ER_XML_CONSTANTS}.check_box)
		local
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_button_file, l_sub_imp_dir, l_tool_bar_button_imp_file: STRING
			l_last_string: STRING
			l_identifier_name: detachable STRING
		do
			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_button_file := "ribbon_checkbox_imp"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_button_imp_file := "ribbon_checkbox"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar button class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_button_file + ".e")
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if attached {ER_TREE_NODE_BUTTON_DATA} a_checkbox_node.data as l_data then
							if attached l_data.command_name as l_command_name  and then not l_command_name.is_empty then
								l_identifier_name := l_command_name
							end
						end
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + "_imp.e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_button_file + "_" + a_index.out + ".e")
						end

						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- replace/add tab codes here
							l_file.read_line
							l_last_string := l_file.last_string
							if l_identifier_name /= Void then
								l_last_string.replace_substring_all ("$INDEX", l_identifier_name.as_upper + "_IMP")
							else
								l_last_string.replace_substring_all ("$INDEX", "RIBBON_CHECKBOX_IMP_" + a_index.out)
							end

							l_dest_file.put_string (l_last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar button imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_button_imp_file + ".e")
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						if l_identifier_name /= Void then
							l_dest_file_name.set_file_name (l_identifier_name.as_lower + ".e")
						else
							l_dest_file_name.set_file_name (l_tool_bar_button_imp_file + "_" + a_index.out + ".e")
						end

						create l_dest_file.make (l_dest_file_name)
						if not l_dest_file.exists then
							l_dest_file.create_read_write
							from
								l_file.open_read
								l_file.start
							until
								l_file.after
							loop
								-- replace/add tab codes here
								l_file.read_line
								l_last_string := l_file.last_string
								if l_identifier_name /= Void then
									l_last_string.replace_substring_all ("$INDEX_1", l_identifier_name.as_upper)
									l_last_string.replace_substring_all ("$INDEX_2", l_identifier_name.as_upper + "_IMP")
								else
									l_last_string.replace_substring_all ("$INDEX_1", "RIBBON_CHECKBOX_" + a_index.out)
									l_last_string.replace_substring_all ("$INDEX_2", "RIBBON_CHECKBOX_IMP_" + a_index.out)
								end

								l_dest_file.put_string (l_last_string + "%N")
							end

							l_file.close
							l_dest_file.close
						end

					end
				end
			end
		end

end

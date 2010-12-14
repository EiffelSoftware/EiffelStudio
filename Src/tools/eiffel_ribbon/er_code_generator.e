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
			uicc_manager.compile
			-- Check XML compilation error here?
			save_project_info
			generate_ecf
			copy_predefine_classes
			generate_readonly_classes

			generate_eiffel_class_for_header_file
		end

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
				if attached l_constants.project_configuration_file_name as l_project_config then
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
							create l_dest_file.make_create_read_write (l_dest_file_name)

							l_file.open_read
							l_file.start
							l_file.copy_to (l_dest_file)

							l_file.close
							l_dest_file.close
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
					create l_translator.make (l_source_header, l_project_location, "er_c_constants")
					l_translator.translate
				end
			end

		end

	generate_readonly_classes
			-- Generate readonly ribbon widget classes
		local
			l_singleton: ER_SHARED_SINGLETON
			l_tree: EV_TREE
			l_tree_node: detachable EV_TREE_NODE
			l_xml: ER_XML_CONSTANTS
		do
			-- Parse EV_TREE until Ribbon.Tabs
			create l_singleton
			if attached l_singleton.layout_constructor_cell.item as l_layout_constructor then
				from
					create l_xml
					l_tree := l_layout_constructor.widget
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
			l_sub_dir, l_tool_bar_file, l_sub_imp_dir, l_tool_bar_imp_file: STRING
		do
			-- First check how many tabs
			l_tab_count := a_tabs_root_note.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_file := "er_tool_bar.e"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_imp_file := "er_tool_bar_imp.e"

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
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_imp_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_imp_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
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
				generate_tab_class (a_tabs_root_note.item)
				a_tabs_root_note.forth
			end

		end

	generate_tab_class (a_tab_note: EV_TREE_NODE)
			--
		require
			not_void: a_tab_note /= void
			valid: a_tab_note.text.is_equal ({ER_XML_CONSTANTS}.tab)
		local
			l_group_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_tab_file, l_sub_imp_dir, l_tool_bar_tab_imp_file: STRING
		do
			-- First check how many groups
			l_group_count := a_tab_note.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_tab_file := "er_tool_bar_tab.e"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_tab_imp_file := "er_tool_bar_tab_imp.e"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar tab class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_tab_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_tab_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar tab imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_tab_imp_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_tab_imp_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end
				end
			end

			-- Generate group classes
			from
				a_tab_note.start
			until
				a_tab_note.after
			loop
				check a_tab_note.item.text.is_equal ({ER_XML_CONSTANTS}.group) end
				generate_group_class (a_tab_note.item)
				a_tab_note.forth
			end

		end

	generate_group_class (a_group_node: EV_TREE_NODE)
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
		do
			-- First check how many groups
			l_button_count := a_group_node.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_group_file := "er_tool_bar_group.e"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_group_imp_file := "er_tool_bar_group_imp.e"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar group class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_group_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_group_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar group imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_group_imp_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_group_imp_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end
				end
			end

			-- Generate button classes
			from
				a_group_node.start
			until
				a_group_node.after
			loop
				check a_group_node.item.text.is_equal ({ER_XML_CONSTANTS}.button) end
				generate_button_class (a_group_node.item)
				a_group_node.forth
			end

		end

	generate_button_class (a_buttn_node: EV_TREE_NODE)
			--
		require
			not_void: a_buttn_node /= void
			valid: a_buttn_node.text.is_equal ({ER_XML_CONSTANTS}.button)
		local
--			l_button_count: INTEGER
			l_file, l_dest_file: RAW_FILE
			l_constants: ER_MISC_CONSTANTS
			l_file_name, l_dest_file_name: FILE_NAME
			l_singleton: ER_SHARED_SINGLETON
			l_sub_dir, l_tool_bar_button_file, l_sub_imp_dir, l_tool_bar_button_imp_file: STRING
		do
			-- First check how many groups
--			l_button_count := a_group_node.count

			create l_singleton
			l_sub_dir := "code_generated_once_change_by_user"
			l_tool_bar_button_file := "er_tool_bar_button.e"
			l_sub_imp_dir := "code_generated_everytime"
			l_tool_bar_button_imp_file := "er_tool_bar_button_imp.e"

			if attached l_singleton.project_info_cell.item as l_project_info then
				if attached l_project_info.project_location as l_project_location then
					create l_constants

					-- Generate tool bar button class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_dir)
					l_file_name.set_file_name (l_tool_bar_button_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_button_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end

					-- Generate tool bar button imp class
					create l_file_name.make_from_string (l_constants.template)
					l_file_name.set_subdirectory (l_sub_imp_dir)
					l_file_name.set_file_name (l_tool_bar_button_imp_file)
					create l_file.make (l_file_name)
					if l_file.exists and then l_file.is_readable then
						create l_dest_file_name.make_from_string (l_project_location)
						l_dest_file_name.set_file_name (l_tool_bar_button_imp_file)
						create l_dest_file.make_create_read_write (l_dest_file_name)
						from
							l_file.open_read
							l_file.start
						until
							l_file.after
						loop
							-- FIXME: replace/add tab codes here
							l_file.read_line
							l_dest_file.put_string (l_file.last_string + "%N")
						end

						l_file.close
						l_dest_file.close
					end
				end
			end

--			-- Generate button classes
--			from
--				a_group_node.start
--			until
--				a_group_node.after
--			loop
--				check a_group_node.item.text.is_equal ({ER_XML_CONSTANTS}.button) end
--				generate_button_class (a_group_node.item)
--				a_group_node.forth
--			end
		end

end

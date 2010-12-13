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
--					if l_tree.item.text.is_equal (l_xml.ribbon_tabs) then
--						l_tree_node
--					else
						-- Continue iteration
					l_tree_node := tree_node_with_text (l_tree.item, l_xml.ribbon_tabs)
--					end

					l_tree.forth
				end

				if l_tree_node /= Void then
					-- Start real generation

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

end

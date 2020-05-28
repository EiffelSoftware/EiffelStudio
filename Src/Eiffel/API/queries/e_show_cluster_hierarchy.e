note
	description: "Command to display hierarchical structure of the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class E_SHOW_CLUSTER_HIERARCHY

inherit
	E_OUTPUT_CMD

	SHARED_EIFFEL_PROJECT

	QL_SHARED

create
	make, do_nothing

feature -- Execution

	work
			-- Show groups in universe
		do
			processed_libraries.wipe_out
			processed_assemblies.wipe_out
			display_target (system_target_domain.first, -1, is_class_displayed)
		end

feature -- Status report

	is_class_displayed: BOOLEAN
			-- Is classes displayed?
		do
		end

	is_folder_hierarchy_displayed: BOOLEAN
			-- Is folder hierarchy displayed?
			-- e.g., should we display folders in a cluster?
		do
			Result := True
		end

feature {NONE} -- Implementation

	display_target (a_target: QL_TARGET; a_tab_count: INTEGER; a_is_class_displayed: BOOLEAN)
			-- Display `a_target' in `text_formatter' starting with `a_tab_count' tabs.
			-- If `a_is_class_displayed' is True, display classes in `a_group'.
		require
			a_target_attached: a_target /= Void
		local
			l_group_domain: QL_GROUP_DOMAIN
		do
			l_group_domain := a_target.groups_in_target
			l_group_domain.sort (agent group_tester ({QL_GROUP}?, {QL_GROUP}?))
			from
				l_group_domain.start
			until
				l_group_domain.after
			loop
				display_group (l_group_domain.item, a_tab_count + 1, a_is_class_displayed)
				l_group_domain.forth
			end
		end

	append_group_information (a_group: CONF_GROUP)
			-- Append information of `a_group' (such as cluster, override, library, assembly, is_precompiled) into `text_formatter'.
		require
			a_group_attached: a_group /= Void
		local
			l_classes: STRING_TABLE [CONF_CLASS]
			l_class_cnt: INTEGER
		do
			l_classes := a_group.classes
			text_formatter.add (output_interface_names.lparan)
			if a_group.is_cluster then
				text_formatter.add (output_interface_names.cluster)
			elseif a_group.is_override then
				text_formatter.add (output_interface_names.override)
			elseif a_group.is_library then
				text_formatter.add (output_interface_names.library)
				if attached {CONF_LIBRARY} a_group as l_library then
					if l_library.is_precompile then
						text_formatter.add (output_interface_names.comma)
						text_formatter.add_space
						text_formatter.add (output_interface_names.precompiled)
					end
				else
					check is_library: False end
				end
			elseif a_group.is_assembly or a_group.is_physical_assembly then
				text_formatter.add (output_interface_names.assembly)
			end
			if l_classes /= Void and then not l_classes.is_empty then
				l_class_cnt := l_classes.count
				text_formatter.add (output_interface_names.comma)
				text_formatter.add_space
				text_formatter.add_int (l_class_cnt)
				text_formatter.add_space
				if l_class_cnt > 1 then
					text_formatter.add (output_interface_names.classes)
				else
					text_formatter.add (output_interface_names.one_class)
				end
			end
			text_formatter.add (output_interface_names.rparan)
			text_formatter.add_new_line
		end

	display_group (a_group: QL_GROUP; a_tab_count: INTEGER; a_is_class_displayed: BOOLEAN)
			-- Display `a_group' in `text_formatter' starting with `a_tab_count' tabs.
			-- If `a_is_class_displayed' is True, display classes in `a_group'.
		require
			a_group_attached: a_group /= Void
			a_tab_count_non_negative: a_tab_count >= 0
		local
			l_group, g: CONF_GROUP
			l_classes: STRING_TABLE [CONF_CLASS]
			l_processed: BOOLEAN
			l_assembly_processed: BOOLEAN
		do
			l_group := a_group.group
			l_classes := l_group.classes

			text_formatter.add_indents (a_tab_count)
			text_formatter.add_group (l_group, l_group.name)
			if l_group.is_library then
				if attached {CONF_LIBRARY} l_group as l_library then
					if attached l_library.library_target as l_lib_target then
						l_processed := processed_libraries.has (l_lib_target.system.uuid)
						if l_processed then
							text_formatter.add (output_interface_names.ellipse)
						else
							processed_libraries.extend (l_lib_target.system.uuid)
						end
					end
				else
					check is_library: False end
				end
			elseif l_group.is_assembly or l_group.is_physical_assembly then
				if attached {CONF_ASSEMBLY} l_group as l_assembly then
					g := l_assembly.physical_assembly
				else
					g := l_group
				end
				if attached {CONF_PHYSICAL_ASSEMBLY} g as l_phys_as then
					l_assembly_processed := processed_assemblies.has (l_phys_as.guid)
					if l_assembly_processed then
						text_formatter.add (output_interface_names.ellipse)
					else
						processed_assemblies.extend (l_phys_as.guid)
					end
				end
			end
			text_formatter.add_space
			append_group_information (l_group)
			if l_group.classes_set then
				if l_group.is_cluster then
					if l_classes /= Void and then not l_classes.is_empty then
						display_cluster_hierarchy (l_group, a_tab_count + 1, a_is_class_displayed)
					end
				elseif l_group.is_library then
					if not l_processed then
						display_target (a_group.library_target, a_tab_count, a_is_class_displayed)
					end
				elseif l_group.is_assembly and then not l_assembly_processed and then a_is_class_displayed then
					display_classes_in_assembly (l_group, a_tab_count + 1)
				end
			end
		end

	display_cluster_hierarchy (a_group: CONF_GROUP; a_tab_count: INTEGER; a_is_class_displayed: BOOLEAN)
			-- Display classes in `a_group' staring with `a_tab_count' tabs.
		require
			a_group_attached: a_group /= Void
			a_group_has_classes: a_group.classes /= Void and then not a_group.classes.is_empty
			a_tab_count_non_negative: a_tab_count >= 0
		local
			l_class_table: like class_table
			l_sorted_classes: ARRAYED_LIST [CONF_CLASS]
		do
			if is_folder_hierarchy_displayed then
				l_class_table := class_table (a_group.classes)
				display_folder ({STRING_32} "", a_group.location.evaluated_path, l_class_table, a_tab_count, a_is_class_displayed)
			else
				if a_is_class_displayed then
					if a_group.classes_set then
						l_sorted_classes := sorted_classes (a_group.classes)
						from
							l_sorted_classes.start
						until
							l_sorted_classes.after
						loop
							display_class (l_sorted_classes.item_for_iteration, a_tab_count + 1)
							l_sorted_classes.forth
						end
					end
				end
			end
		end

	display_folder (a_path: READABLE_STRING_32; a_directory: PATH; a_class_table: like class_table; a_tab_count: INTEGER; a_is_class_displayed: BOOLEAN)
			-- Dispaly information of a folder whose location is `a_directory' starting with `a_tab_count' tabs.
			-- `a_path' is used to find classes in `a_class_table'.
			-- If `a_is_class_displayed' is True, display classes in that folder.
		require
			a_path_attached: a_path /= Void
			a_directory_attached: a_directory /= Void
			a_class_table_attached: a_class_table /= Void
			a_tab_count_non_negative: a_tab_count >= 0
		local
			l_list: LIST [CONF_CLASS]
			l_dir: DIRECTORY
			l_file: RAW_FILE
			l_dir_list: PART_SORTED_TWO_WAY_LIST [STRING_32]
			l_new_dir: PATH
			l_new_path: READABLE_STRING_32
			l_has_class: BOOLEAN
		do
				-- Find folder hierarchy
			create l_dir.make_with_path (a_directory)
			l_dir.open_read
			create l_dir_list.make
			from
				l_dir.readentry
			until
				l_dir.last_entry_32 = Void
			loop
				if not l_dir.last_entry_32.same_string_general (once ".") and not l_dir.last_entry_32.same_string_general (once "..") then
					create l_file.make_with_path (a_directory.extended (l_dir.last_entry_32))
					if l_file.is_directory then
						l_dir_list.put_front (l_dir.last_entry_32)
					end
				end
				l_dir.readentry
			end
			if not l_dir_list.is_empty then
				l_dir_list.sort
				from
					l_dir_list.start
				until
					l_dir_list.after
				loop
					if a_path.is_empty then
						l_new_path := l_dir_list.item
					else
						l_new_path := a_path + "/" + l_dir_list.item
					end
					from
						a_class_table.start
					until
						a_class_table.after or l_has_class
					loop
						if a_class_table.key_for_iteration.substring (1, l_new_path.count).same_string (l_new_path) then
							l_has_class := True
						end
						a_class_table.forth
					end
					if l_has_class then
						text_formatter.add_indents (a_tab_count)
						text_formatter.add (l_dir_list.item)
						l_list := a_class_table.item (l_new_path)
						text_formatter.add_space
						text_formatter.add (output_interface_names.lparan)
						text_formatter.add (output_interface_names.cluster)

						if l_list /= Void then
							text_formatter.add (output_interface_names.comma)
							text_formatter.add_space
							text_formatter.add_int (l_list.count)
							text_formatter.add_space
							if l_list.count > 1 then
								text_formatter.add (output_interface_names.classes)
							else
								text_formatter.add (output_interface_names.one_class)
							end
							text_formatter.add (output_interface_names.rparan)
							text_formatter.add_new_line
						else
							text_formatter.add (output_interface_names.rparan)
							text_formatter.add_new_line
						end
						l_new_dir := a_directory.extended (l_dir_list.item)
						display_folder (l_new_path, l_new_dir, a_class_table, a_tab_count + 1, a_is_class_displayed)
					end
					l_dir_list.forth
				end
			end
			if a_is_class_displayed then
				l_list := a_class_table.item (a_path)
				if l_list /= Void then
					from
						l_list.start
					until
						l_list.after
					loop
						display_class (l_list.item_for_iteration, a_tab_count)
						l_list.forth
					end
				end
			end
		end

	class_table (a_classes: STRING_TABLE [CONF_CLASS]): STRING_TABLE [ARRAYED_LIST [CONF_CLASS]]
			-- Table of classes from `a_classes' indexed by renamed name.
			-- Key is `path', value are list of classes with the same `path'.
		require
			a_classes_attached: a_classes /= Void
			not_a_classes_is_empty: not a_classes.is_empty
		local
			l_list: ARRAYED_LIST [CONF_CLASS]
			l_class: CONF_CLASS
			l_agent_tester: AGENT_EQUALITY_TESTER [CONF_CLASS]
			l_sorter: QUICK_SORTER [CONF_CLASS]
		do
			create Result.make (30)
			from
				a_classes.start
			until
				a_classes.after
			loop
				l_class := a_classes.item_for_iteration
				l_list := Result.item (l_class.path)
				if l_list = Void then
					create l_list.make (20)
					Result.force (l_list, l_class.path)
				end
				l_list.extend (l_class)
				a_classes.forth
			end
			create l_agent_tester.make (agent class_name_tester)
			create l_sorter.make (l_agent_tester)
			from
				Result.start
			until
				Result.after
			loop
				l_sorter.sort (Result.item_for_iteration)
				Result.forth
			end
		ensure
			result_attached: Result /= Void
		end

	path_tester (a_item, b_item: CONF_CLASS): BOOLEAN
			-- Compare name of `a_item' and `b_item'.
			-- If `a_item' is less than `b_item' literally, return True.
		require
			a_item_attached: a_item /= Void
			b_item_attached: b_item /= Void
		do
			Result := a_item.path < b_item.path
		end

	display_classes_in_assembly (a_group: CONF_GROUP; a_tab_count: INTEGER)
			-- Display `a_classes' `a_group' into `text_formatter' starting with `a_tab_count' tabs.
		require
			a_group_attached: a_group /= Void
			a_group_is_assembly: a_group.is_assembly or a_group.is_physical_assembly
			a_tab_count_non_negative: a_tab_count >= 0
		local
			l_sorted_list: ARRAYED_LIST [CONF_CLASS]
			l_classes: STRING_TABLE [CONF_CLASS]
		do
			l_classes := a_group.classes
			if l_classes /= Void and then not l_classes.is_empty then
				l_sorted_list := sorted_classes (l_classes)
				from
					l_sorted_list.start
				until
					l_sorted_list.after
				loop
					display_class (l_sorted_list.item_for_iteration, a_tab_count)
					l_sorted_list.forth
				end
			end
		end

	display_class (a_class: CONF_CLASS; a_tab_count: INTEGER)
			-- Display `a_class' in `text_formatter' starting with `a_tab_count' tabs.
		require
			a_class_attached: a_class /= Void
			a_tab_count_non_negative: a_tab_count >= 0
		do
			text_formatter.add_indents (a_tab_count)
			if attached {CLASS_I} a_class as l_class_i then
				if
					a_class.is_compiled and then
					attached {CLASS_C} l_class_i.compiled_class as l_class_c
				then
					l_class_c.append_signature (text_formatter, True)
				else
					l_class_i.append_name (text_formatter)
					text_formatter.add_space
					text_formatter.add (output_interface_names.not_in_system)
				end
			else
				check is_class_i: False end
			end
			text_formatter.add_new_line
		end

feature{NONE} -- Sorting

	name_tester (a_item, b_item: QL_ITEM): BOOLEAN
			-- Compare name of `a_item' and `b_item'.
			-- If `a_item' is less than `b_item' literally, return True.
		require
			a_item_attached: a_item /= Void
			b_item_attached: b_item /= Void
		do
			Result := a_item.name < b_item.name
		end

	class_name_tester (a_class, b_class: CONF_CLASS): BOOLEAN
			-- Compare name of `a_class' and `b_class'.
			-- If `b_class' is less than `b_clas', return True.
		require
			a_class_attached: a_class /= Void
			b_class_attached: b_class /= Void
		do
			Result := a_class.name < b_class.name
		end

	group_tester (a_group, b_group: QL_GROUP): BOOLEAN
			-- Compare name of `a_group' and `b_group'.
			-- If `a_group' is less than `b_group', return True.
		require
			a_group_attached: a_group /= Void
			b_group_attached: b_group /= Void
		local
			l_a_index: INTEGER
			l_b_index: INTEGER
		do
			l_a_index := group_index (a_group.group)
			l_b_index := group_index (b_group.group)
			if l_a_index /= l_b_index then
				Result := l_a_index < l_b_index
			else
				Result := a_group.name < b_group.name
			end
		end

	group_index (a_group: CONF_GROUP): INTEGER
			-- Index of `a_group' used to sort groups
		require
			a_group_attached: a_group /= Void
		do
			if a_group.is_cluster then
				if a_group.is_override then
					Result := 2
				else
					Result := 1
				end
			elseif a_group.is_library then
				Result := 3
			else
				Result := 4
			end
		end

feature{NONE} -- Implementation

	processed_libraries: ARRAYED_LIST [UUID]
			-- List of processed libraries
		do
			if processed_libraries_internal = Void then
				create processed_libraries_internal.make (30)
				processed_libraries_internal.compare_objects
			end
			Result := processed_libraries_internal
		ensure
			result_attached: Result /= Void
		end

	processed_libraries_internal: like processed_libraries
			-- Implementation of `processed_libraries'

	processed_assemblies: ARRAYED_LIST [READABLE_STRING_32]
			-- List of processed assemblies
		do
			if processed_assemblies_internal = Void then
				create processed_assemblies_internal.make (30)
			end
			Result := processed_assemblies_internal
		ensure
			result_attached: Result /= Void
		end

	processed_assemblies_internal: like processed_assemblies
			-- Implementation of `processed_assemblies'

	directory_separator: CHARACTER
			-- Directory separator
		local
			l_op: OPERATING_ENVIRONMENT
		once
			create l_op
			Result := l_op.directory_separator
		end

	sorted_classes (a_table: STRING_TABLE [CONF_CLASS]): ARRAYED_LIST [CONF_CLASS]
			-- Classes from `a_class_table' that are sorted using `class_name_tester'
		require
			a_table_attached: a_table /= Void
		local
			l_agent_tester: AGENT_EQUALITY_TESTER [CONF_CLASS]
			l_sorter: QUICK_SORTER [CONF_CLASS]
		do
			create {ARRAYED_LIST [CONF_CLASS]} Result.make (a_table.count)
			from
				a_table.start
			until
				a_table.after
			loop
				Result.extend (a_table.item_for_iteration)
				a_table.forth
			end
			create l_agent_tester.make (agent class_name_tester)
			create l_sorter.make (l_agent_tester)
			l_sorter.sort (Result)
		ensure
			result_attached: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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

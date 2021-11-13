note
	description: "[
		Objects that adopt the test map of an {ETEST_CLASS} corresponding to it's AST stored on disc.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_CLASS_SYNCHRONIZER

inherit
	AST_ITERATOR
		redefine
			process_class_as,
			process_feature_as,
			process_feature_clause_as,
			process_feature_name,
			process_id_as,
			process_index_as,
			process_string_as,
			process_verbatim_string_as
		end

	SHARED_EIFFEL_PARSER_WRAPPER
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

		-- In order to get UTF-8 text to parse it directly without conversion.
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (a_project_access: like project_access)
			-- Initialize `Current'.
			--
			-- `a_project_access': Project accessfor retrieving class information.
		require
			a_project_access_attached: a_project_access /= Void
		do
			project_access := a_project_access
			current_state := default_state
			class_tags := new_tag_set
			feature_tags := new_tag_set
			current_tag_set := class_tags
		end

feature -- Access

	project_access: EC_PROJECT_ACCESS
			-- Project access

feature {NONE} -- Access

	test_class: detachable ETEST_CLASS
			-- Test class currently being synchronized

	old_test_map: detachable TAG_HASH_TABLE [ETEST]
			-- Old `test_map' of `test_class' containing previously parsed {ETEST} instances

	class_tags: TAG_SEARCH_TABLE
			-- Tags found in note clause of class being processed

	feature_tags: TAG_SEARCH_TABLE
			-- Tags found in note clause of feature being processed

feature {NONE} -- Access: onces

	eiffel_parser: EIFFEL_PARSER
			-- Simple parser used to parse test classes
		once
			create Result.make
		end

	frozen test_suite: SERVICE_CONSUMER [TEST_SUITE_S]
			-- Access to test suite service {TEST_SUITE_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access: AST

	current_tag_set: like class_tags
			-- Tag set to which tags will be added when visiting

	current_state: NATURAL
			-- State of `Current' determing what part of the AST is traversed

	default_state: NATURAL = 0
	extract_tags_state: NATURAL = 1
	check_feature_clause_state: NATURAL = 2
			-- Possible states

feature -- Status report

	is_synchronizing: BOOLEAN
			-- Is `Current' synchronizing a test class?
		do
			Result := test_class /= Void
		ensure
			result_implies_test_class_attached: Result implies test_class /= Void
		end

feature {NONE} -- Status report

	is_valid_feature_clause: BOOLEAN
			-- Is traversed feature clause valid for containing test routines?

	is_valid_feature (a_feature: FEATURE_AS): BOOLEAN
			-- Is given feature valid for to represent a test routine?
		do
			Result := (attached a_feature.body.arguments as l_args implies l_args.is_empty) and
			          not a_feature.is_function and not a_feature.is_attribute
		end

feature {ETEST_SUITE} -- Basic operations

	synchronize (an_etest_class: ETEST_CLASS; a_remove: BOOLEAN)
			-- Synchronize given {ETEST_CLASS} with found routines in corresponding {EIFFEL_CLASS_I} by
			-- parsing class. Any old routines are removed from test map. Any changes are updated in
			-- {TEST_SUITE_S}.
			--
			-- `an_etest_class': Test class to be synchronized
			-- `a_remove': If True all tests in `an_etest_class' are removed (also from {TEST_SUITE_S})
		require
			not_synchronizing: not is_synchronizing
		local
			l_map: like old_test_map
			l_test: ETEST
		do
			test_class := an_etest_class
			l_map := an_etest_class.test_map
			if not l_map.is_empty then
				old_test_map := l_map
				an_etest_class.reset_test_map
			end

			if not a_remove then
				safe_process (ast (an_etest_class.eiffel_class))
			end

			if attached test_suite.service as l_test_suite and old_test_map = l_map then
				from
					l_map.start
				until
					l_map.after
				loop
					l_test := l_map.item_for_iteration
					if
						l_test_suite.is_interface_usable and then
						l_test_suite.has_test (l_test.name) and then
						l_test_suite.test (l_test.name) = l_test
					then
						l_test_suite.remove_test (l_test)
					end
					l_map.forth
				end
			end

			test_class := Void
			old_test_map := Void
		ensure
			not_synchronizing: not is_synchronizing
		end

feature {NONE} -- Implementation

	synchronize_routine (a_routine_name: STRING)
			-- Synchronize `test_class' with found test routine name.
			--
			-- `a_routine_name': Name of found test routine.
		require
			synchronizing: is_synchronizing
		local
			l_test_class: like test_class
			l_test: detachable ETEST
			l_name: detachable IMMUTABLE_STRING_8
		do
			if attached test_suite.service as l_test_suite and then l_test_suite.is_interface_usable then
				l_test_class := test_class
				check l_test_class /= Void end

				if attached old_test_map as l_old_map then
					l_old_map.search (a_routine_name)
					if l_old_map.found then
						l_test := l_old_map.found_item
						l_name := a_routine_name
						l_old_map.remove (a_routine_name)
					end
				end
				if l_test = Void or l_name = Void then
						-- TODO: pass `test_class'
					create l_test.make (a_routine_name, l_test_class)
					create l_name.make_from_string (a_routine_name)
				end

				if l_test_suite.has_test (l_test.name) then
					if l_test_suite.test (l_test.name) /= l_test then
						l_test := Void
					end
				else
					l_test_suite.add_test (l_test)
				end

					-- Update tags
				if l_test /= Void then
					l_test_class.test_map.force (l_test, l_name)
					update_tags (l_test_suite.tag_tree, l_test)
				end
			end
		ensure
			synchronizing: is_synchronizing
		end

feature {NONE} -- Implementation: tags

	update_tags (a_tag_tree: TAG_TREE [TEST_I]; a_test: TEST_I)
			-- Update test tags in given tag tree according to `class_tags' and `feature_tags'.
			--
			-- `a_tag_tree': Tag tree in which tags should be updated.
			-- `a_test': Test for which tags should be updated.
			-- `an_old_tags': Old
		require
			a_tag_tree_attached: a_tag_tree /= Void
			a_test_attached: a_test /= Void
		local
			l_hash_set: detachable TAG_SEARCH_TABLE
			l_set: like class_tags
			l_add: BOOLEAN
		do
			if a_tag_tree.has_item (a_test) then
				l_hash_set := a_tag_tree.tags_of_item (a_test)
			end
			from
				l_set := class_tags
				l_set.start
			until
				l_set.after
			loop
				l_add := True
				if l_hash_set /= Void then
					l_hash_set.remove (l_set.item_for_iteration)
				end
				if l_add and a_tag_tree.is_valid_tag_for_item (a_test, l_set.item_for_iteration) then
					a_tag_tree.add_tag (a_test, l_set.item_for_iteration)
				end

				l_set.forth
				if l_set.after and l_set = class_tags then
					l_set := feature_tags
					l_set.start
				end
			end

			if l_hash_set /= Void and then not l_hash_set.is_empty then
				from
					l_hash_set.start
				until
					l_hash_set.after
				loop
					if
						not a_tag_tree.formatter.is_prefix ("result", l_hash_set.item_for_iteration)
					then
						a_tag_tree.remove_tag (a_test, l_hash_set.item_for_iteration)
					end
					l_hash_set.forth
				end
			end
		end

	add_tag (a_tag: STRING)
			-- Add tag to set by replacing all class names with current cluster/class/feature hierarchy.
			--
			-- `a_tag': Tag to be added to set
		require
			a_tag_not_empty: not a_tag.is_empty
		local
			i, start: INTEGER
			l_in_class, l_in_feature: BOOLEAN
			c: CHARACTER
			l_final, l_class_name: STRING_32
			l_feature_name: detachable STRING
		do
			create l_final.make (a_tag.count*2)
			if
				not (a_tag.starts_with ("class/") or
				a_tag.starts_with ("covers/") or
				a_tag.starts_with ("execution/"))
			then
				l_final.append ("user/")
			end
			from
				start := 1
				i := 1
			until
				i > a_tag.count
			loop
				c := a_tag.item (i)
				if c = '/' or not (c.is_alpha_numeric or c = '_') then
					if l_in_feature then
						l_in_feature := False
						if i > start + 1 then
							l_feature_name := a_tag.substring (start + 1, i - 1)
							start := i
						end
						add_class_path (l_final, l_class_name, l_feature_name)
						l_feature_name := Void
					end
					if c = '{' then
						if i > start then
							l_final.append (a_tag.substring (start, i - 1))
						end
						start := i
						l_in_class := True
					elseif l_in_class then
						l_in_class := False
						if c = '}' and i > start + 1 then
							l_class_name := a_tag.substring (start + 1, i - 1)
							start := i + 1
							if a_tag.count > i + 1 and then a_tag.item (i + 1) = '.' then
								i := i + 1
								l_in_feature := True
							else
								add_class_path (l_final, l_class_name, Void)
							end
						end
					end
				end
				i := i + 1
			end
			if l_in_feature then
				l_feature_name := a_tag.substring (start + 1, i - 1)
				add_class_path (l_final, l_class_name, l_feature_name)
			elseif start < i then
				l_final.append (a_tag.substring (start, i - 1))
			end
			current_tag_set.force (l_final)
		ensure
			current_tag_set_increased: current_tag_set.count = old current_tag_set.count + 1
		end

	add_class_path (a_tag: STRING_32; a_class_name: READABLE_STRING_32; a_feature_name: detachable STRING)
			-- Add cluster/class/feature information to tag
			--
			-- `a_tag': Tag to which information should be added
			-- `a_class_name': Name of class for which information is added
			-- `a_feature_name': Name of feature in class (Can be Void if only class information is added)
		require
			a_class_name_not_empty: not a_class_name.is_empty
			a_feature_name_not_empty: a_feature_name /= Void implies a_feature_name /= Void
		local
			l_current, l_group: CONF_GROUP
			l_uni: UNIVERSE_I
			l_list: LIST [CONF_LIBRARY]
			l_path: LIST [STRING_32]
			l_class: EIFFEL_CLASS_I
			l_uuid: detachable UUID
			l_dir: detachable STRING_32
			l_test_class: like test_class
			l_cluster_stack: ARRAYED_STACK [CONF_GROUP]
		do
			l_test_class := test_class
			check l_test_class /= Void end

			if project_access.is_initialized then
				l_class := l_test_class.eiffel_class
				l_group := l_class.cluster
			end

			if l_class /= Void then
				create l_cluster_stack.make (10)
				l_uni := project_access.project.universe
				from
					l_current := l_class.cluster
				until
					l_current = Void
				loop
					l_cluster_stack.force (l_current)
					if attached {CONF_CLUSTER} l_current as l_cluster then
						l_current := Void
						if l_cluster.parent /= Void then
							l_current := l_cluster.parent
						elseif l_cluster.is_used_in_library then
							l_uuid := l_cluster.target.system.uuid
							if l_uuid /= Void then
								l_list := l_uni.library_of_uuid (l_uuid, True)
								if not l_list.is_empty then
									from
										l_list.start
									until
										l_list.after
									loop
										if l_list.item_for_iteration.target = l_uni.target or
										   l_list.item_for_iteration = l_list.last
										then
											l_cluster_stack.force (l_list.item_for_iteration)
											l_list.finish
										end
										l_list.forth
									end
								end
							end
						end
					else
						l_current := Void
					end
				end
				from until
					l_cluster_stack.is_empty
				loop
					l_group := l_cluster_stack.item
					if attached {CONF_LIBRARY} l_group as l_lib then
						a_tag.append ({EC_TAG_TREE_CONSTANTS}.library_prefix)
						a_tag.append (l_group.name)
						a_tag.append_character ({EC_TAG_TREE_CONSTANTS}.delimiter_symbol)
						a_tag.append (l_lib.library_target.system.uuid.string)
					else
						if l_group.is_override then
							a_tag.append ({EC_TAG_TREE_CONSTANTS}.override_prefix)
						elseif l_group.is_cluster then
							a_tag.append ({EC_TAG_TREE_CONSTANTS}.cluster_prefix)
						end
						a_tag.append (l_group.name)
					end
					a_tag.append_character ({CHARACTER_32} '/')
					l_cluster_stack.remove
				end
				l_cluster_stack.wipe_out
				l_path := l_class.path.split (unix_file_system.directory_separator)
				from
					l_path.start
				until
					l_path.after
				loop
					l_dir := l_path.item_for_iteration
					if l_dir /= Void and then not l_dir.is_empty then
						a_tag.append ({EC_TAG_TREE_CONSTANTS}.directory_prefix)
						a_tag.append (l_dir)
						a_tag.append_character ({CHARACTER_32} '/')
					end
					l_path.forth
				end
			end
			a_tag.append ({EC_TAG_TREE_CONSTANTS}.class_prefix)
			a_tag.append (a_class_name)
			if a_feature_name /= Void then
				a_tag.append_character ({CHARACTER_32} '/')
				a_tag.append ({EC_TAG_TREE_CONSTANTS}.feature_prefix)
				a_tag.append (a_feature_name)
			end
		end

feature {NONE} -- Implementation: AST

	process_class_as (l_as: CLASS_AS)
			-- <Precursor>
		local
			l_tag: STRING_32
		do
			if
				not l_as.is_deferred and
				(attached l_as.creators as l_creators implies l_creators.is_empty)
			then
					-- Find testing tags written in class text
				current_tag_set := class_tags
				current_state := extract_tags_state
				safe_process (l_as.top_indexes)
				safe_process (l_as.bottom_indexes)
				current_state := default_state

					-- Add default "class/" tag
				create l_tag.make (100)
				l_tag.append ({STRING_32} "class/")
				add_class_path (l_tag, l_as.class_name.name_32, Void)
				class_tags.force (l_tag)

				safe_process (l_as.features)

				class_tags.wipe_out
			end
		end

	process_feature_clause_as (l_as: FEATURE_CLAUSE_AS)
			-- <Precursor>
		do
			if attached l_as.clients as l_clients then
				is_valid_feature_clause := False
				current_state := check_feature_clause_state
				l_clients.process (Current)
				current_state := default_state
			else
				is_valid_feature_clause := True
			end
			if is_valid_feature_clause then
				l_as.features.process (Current)
			end
		end

	process_id_as (l_as: ID_AS)
			-- <Precursor>
		do
			inspect
				current_state
			when check_feature_clause_state then
				is_valid_feature_clause := is_valid_feature_clause or
					l_as.name.is_case_insensitive_equal ("ANY")
			when extract_tags_state then
				extract_tags (l_as.name)
			end
		end

	process_feature_as (l_as: FEATURE_AS)
			-- <Precursor>
		do
			if is_valid_feature (l_as) then
					-- Retrieve tags from note clause
				current_state := extract_tags_state
				current_tag_set := feature_tags
				safe_process (l_as.indexes)
				current_state := default_state

				l_as.feature_names.process (Current)
				feature_tags.wipe_out
			end
		end

	process_feature_name (l_as: FEATURE_NAME)
			-- <Precursor>
		do
				-- We found a test routine!
			synchronize_routine (l_as.feature_name.name)
		end

	process_index_as (l_as: INDEX_AS)
			-- <Precursor>
		do
			if l_as.tag.name.is_case_insensitive_equal ("testing") then
				Precursor (l_as)
			end
		end

	process_string_as (l_as: STRING_AS)
			-- <Precursor>
		do
			check extract_tags_state: current_state = extract_tags_state end
			extract_tags (l_as.string_value)
		end

	process_verbatim_string_as (l_as: VERBATIM_STRING_AS)
			-- <Precursor>
		do
			check extract_tags_state: current_state = extract_tags_state end
			extract_tags (l_as.string_value)
		end

feature {NONE} -- Implementation: tags

	valid_tag_chars: STRING
			-- Character other than alpha numeric which are allowed in tags
		once
			Result := "_{}()[]:.-/"
		end

	extract_tags (a_string: STRING)
			-- Extract tags defined in string.
			--
			-- `a_string': String to look for tags.
			-- `a_callback': Routine called once for every tag found in string.
		local
			l_start, l_end: INTEGER
			l_char: CHARACTER
			l_valid_chars: like valid_tag_chars
		do
			l_valid_chars := valid_tag_chars
			from
				l_start := 1
				l_end := 1
			until
				l_start > a_string.count
			loop
				l_char := a_string.item (l_end)
				if not (l_char.is_alpha_numeric or l_valid_chars.has (l_char)) then
					if l_end > l_start then
						add_tag (a_string.substring (l_start, l_end-1))
					end
					l_start := l_end + 1
				end
				l_end := l_end + 1
			end
		end

feature {NONE} -- Implementation: AST

	ast (a_class: EIFFEL_CLASS_I): detachable CLASS_AS
			-- Retrieve ast for `a_class'
		local
			l_text: STRING
			l_parser: like eiffel_parser
		do
--			if a_class.is_compiled then
--				Result := a_class.compiled_representation.ast
--			else
				l_text := a_class.text
				if l_text /= Void then
					l_parser := eiffel_parser
					eiffel_parser_wrapper.parse_with_option (l_parser, l_text, a_class.options, True, Void)
					if attached {CLASS_AS} eiffel_parser_wrapper.ast_node as l_class_ast then
						Result := l_class_ast
					end
					l_parser.reset
				end
--			end
		end

feature {NONE} -- Factory

	new_tag_set: like class_tags
			-- Create new tag set
		do
			create Result.make (10)
		end


invariant
	old_map_attached_implies_test_class_attached:
		attached old_test_map implies attached test_class

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

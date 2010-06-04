note
	description: "[
		Traverses a cluster to find classes of type {EIFFEL_CLASS_I}. Any found classes inheriting from
		{EQA_TEST_SET} are then reported back to the Eiffel test retrieval to check for test routines.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_CLUSTER_RETRIEVAL

inherit
	ROTA_TASK_I

	SHARED_EIFFEL_PARSER_WRAPPER

		-- In order to get UTF-8 text to parse it directly without conversion.
	INTERNAL_COMPILER_STRING_EXPORTER

create {ETEST_RETRIEVAL}
	make

feature {NONE} -- Initialization

	make (a_session: like session; a_cluster: like cluster; a_common_ancestor: like common_ancestor)
			-- Initialize `Current'.
			--
			-- `a_session': Retrieval session.
			-- `a_cluster': Cluster in which Eiffel tests should be retrieved.
		require
			a_session_attached: a_session /= Void
			a_cluster_attached: a_cluster /= Void
			a_common_ancestor_attached: a_common_ancestor /= Void
		local
			l_old: CURSOR
		do
			session := a_session
			cluster := a_cluster
			common_ancestor := a_common_ancestor

			if attached cluster.classes as l_ht and then not l_ht.is_empty then
				l_old := l_ht.cursor
				l_ht.start
				cursor := l_ht.cursor
				l_ht.go_to (l_old)
				class_count := l_ht.count.to_natural_32
				index := 1
			end
		end

feature -- Access

	cluster: CONF_CLUSTER
			-- Cluster in which Eiffel tests should be retrieved

	common_ancestor: EIFFEL_CLASS_I
			-- CLASS_I instance of {EQA_TEST_SET}, from which all test classes must inherit

	class_count: NATURAL
			-- Total number of classes in `cluster'

	index: NATURAL
			-- Index of current class being traversed

feature {NONE} -- Access

	session: ETEST_RETRIEVAL
			-- Retrieval session

	cursor: detachable CURSOR
			-- Current cursor position in class table of `cluster'

feature -- Status report

	has_next_step: BOOLEAN
			-- <Precursor>
		do
			Result := cursor /= Void
		ensure then
			result_implies_cursor_attached: Result implies cursor /= Void
		end

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Status setting

	step
			-- <Precursor>
		local
			i: like classes_per_step
		do
			from
				i := 1
			until
				i > classes_per_step or not has_next_step
			loop
				step_one_class
				i := i + 1
			end
		end

	cancel
			-- <Precursor>
		do
			cursor := Void
			index := 0
		end

feature {NONE} -- Query

	is_descendant (a_class: EIFFEL_CLASS_I; a_cache: BOOLEAN): BOOLEAN
			-- Is class descendant of {TEST_SET}?
			--
			-- `a_class': Class for which it should be determined whether it is a descendant of {TEST_SET}.
			-- `a_cache': If True, `a_class' will be cached in either `traversed_descendants' or
			--            `traversed_helpers'. This should be False for actual test classes, since they are
			--            generally not parents of other test classes.
		require
			project_initialized: session.project_access.is_initialized
		local
			l_parents: like parents_of_class
		do
			if a_class = common_ancestor then
					-- `a_class' is
				Result := True
			elseif session.traversed_descendants.has (a_class) then
				Result := True
			elseif not (session.traversed_helpers.has (a_class) or a_class = session.project_access.project.system.any_class) then
				if a_cache then
					session.traversed_helpers.force (a_class)
				end
					--| Note: we only check compiled parents of potential test classes, hence `a_cache' must be
					--|       true in the following statement.
				if a_class.is_compiled and common_ancestor.is_compiled then
					Result := a_class.compiled_class.conform_to (common_ancestor.compiled_representation)
				else
					l_parents := parents_of_class (a_class)
					from
						l_parents.start
					until
						l_parents.after or Result
					loop
						Result := is_descendant (l_parents.item_for_iteration, True)
						l_parents.forth
					end
				end
				if Result and a_cache then
					session.traversed_helpers.remove (a_class)
					session.traversed_descendants.force (a_class)
				end
			end
		ensure
			cached_descendants_correctly: a_cache implies
			    (Result = (session.traversed_descendants.has (a_class) or a_class = common_ancestor))
			cached_helpers_correctly: a_cache implies
				(Result = not (session.traversed_helpers.has (a_class) or a_class = session.project_access.project.system.any_class))
		end

feature {NONE} -- Implementation

	step_one_class
			-- Process a single class.
		require
			has_next_step: has_next_step
		local
			l_cursor, l_old: like cursor
		do
			l_cursor := cursor
			check cursor_attached: l_cursor /= Void end
			if
				session.project_access.is_initialized and
				attached cluster.classes as l_ht and then
				l_ht.valid_cursor (l_cursor)
			 then
				l_old := l_ht.cursor
				l_ht.go_to (l_cursor)
				if attached {EIFFEL_CLASS_I} l_ht.item_for_iteration as l_class then
					process_class (l_class)
				end
				l_ht.forth
				if l_ht.after then
					cursor := Void
					index := 0
				else
					cursor := l_ht.cursor
					index := index + 1
				end
				l_ht.go_to (l_old)
			else
				cancel
			end
		end

	process_class (a_class: EIFFEL_CLASS_I)
			-- Retrieve any tests in given class.
			--
			-- `a_class': Class in which tests should be retrieved.
		require
			a_class_attached: a_class /= Void
		do
			if is_descendant (a_class, False) then
				session.etest_suite.synchronize_test_class (a_class)
			end
		end

	parents_of_class (a_class: EIFFEL_CLASS_I): LIST [EIFFEL_CLASS_I]
			-- List of direct ancestors of `a_class'
			--
			-- `a_class': Class for which we want to retreive ancestors
			-- `Result': List of direct ancestors of `a_class'.
		require
			project_initialized: session.project_access.is_initialized
			factory_reset: session.inheritance_ast_factory.is_reset
		local
			l_universe: UNIVERSE_I
			l_group: CONF_GROUP
			l_ancestors: LIST [STRING]
			l_list: ARRAYED_LIST [EIFFEL_CLASS_I]
			l_text: STRING
		do
			l_universe := session.project_access.project.universe
			l_group := a_class.cluster
			l_text := a_class.text
			if l_text /= Void then
				eiffel_parser_wrapper.parse_with_option (session.inheritance_parser, l_text, a_class.options, True, Void)
				create l_list.make (session.inheritance_ast_factory.ancestors.count)
				l_ancestors := session.inheritance_ast_factory.ancestors
				from
					l_ancestors.start
				until
					l_ancestors.after
				loop
					if attached {EIFFEL_CLASS_I} l_universe.safe_class_named (l_ancestors.item_for_iteration, l_group) as l_class then
						l_list.force (l_class)
					end
					l_ancestors.forth
				end
				session.inheritance_ast_factory.reset
				session.inheritance_parser.reset
			else
				create l_list.make (0)
			end
			Result := l_list
		ensure
			factory_reset: session.inheritance_ast_factory.is_reset
		end

feature {NONE} -- Constants

	classes_per_step: NATURAL = 5
			-- Number of classes which are parsed per call to `step'

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
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

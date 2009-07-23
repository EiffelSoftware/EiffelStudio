note
	description: "[
		Retrieval that traverses a project to find Eiffel tests.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETEST_RETRIEVAL

inherit
	TEST_RETRIEVAL_I
		select
			step
		end

	ROTA_SERIAL_TASK_I
		rename
			step as proceed
		redefine
			proceed,
			remove_task
		end

	CONF_VISITOR

create {ETEST_SUITE}
	make

feature {NONE} -- Initialization

	make (an_etest_suite: like etest_suite;
	      a_test_suite: like test_suite;
	      a_target: like target;
	      an_ancestor: like common_ancestor)
			-- Initialize `Current'.
			--
			-- `an_etest_suite': Test suite for which classes should be traversed.
			-- `a_test_suite': {TEST_SUITE_S} running `Current'.
			-- `a_target': Target in which Eiffel tests should be retrieved.
			-- `an_ancestor': Class from which all test classes must inherit.
		require
			an_etest_suite_attached: an_etest_suite /= Void
			a_target_attached: a_target /= Void
			a_test_suite_attached: a_test_suite /= Void
			an_ancestor_attached: an_ancestor /= Void
		local
			l_conf_items: like conf_items
			l_clusters: HASH_TABLE [CONF_CLUSTER, STRING]
		do
			test_suite := a_test_suite
			target := a_target
			etest_suite := an_etest_suite
			common_ancestor := an_ancestor
			create conf_items.make_default
			create traversed_descendants.make_default
			create traversed_helpers.make_default
			create traversed_libraries.make_default
			traversed_libraries.set_equality_tester (create {KL_EQUALITY_TESTER [UUID]})
			create progress_list.make_default
			create proceeded_event
		end

feature -- Access

	etest_suite: ETEST_SUITE
			-- Eiffel test suite to which eiffel classes are reported

	test_suite: TEST_SUITE_S
			-- <Precursor>

	project_access: EC_PROJECT_ACCESS
			-- Project which is being traversed
		do
			Result := etest_suite.project_access
		end

	target: CONF_TARGET
			-- Target in which Eiffel tests should be retrieved

	progress: REAL
			-- <Precursor>
		local
			i: INTEGER
			l_invert: like progress
			l_progress: TUPLE [conf_item: CONF_VISITABLE; total, remaining: INTEGER]
			l_sub_task: like sub_task
		do
			from
				l_sub_task := sub_task
				check l_sub_task /= Void end
				Result := l_sub_task.index/l_sub_task.class_count
				i := progress_list.count
			until
				i < 1
			loop
				l_progress := progress_list.at (i)
				l_invert := 1/l_progress.total
				Result := Result*l_invert + (1 - (l_progress.remaining + 1)*l_invert)
				i := i - 1
			end
		end

	sleep_time: NATURAL = 0
			-- <Precursor>
			--
			-- TODO: make this configurable through preferences

feature {ETEST_CLUSTER_RETRIEVAL} -- Access

	inheritance_parser: EIFFEL_PARSER
			-- Parser for retrieving inheritance information only
		once
			create Result.make_with_factory (inheritance_ast_factory)
		end

	inheritance_ast_factory: ETEST_INHERITANCE_AST_FACTORY
			-- Factory for retrieving inheritance information from uncompiled classes
		once
			create Result.make
		end

	traversed_descendants: DS_HASH_SET [EIFFEL_CLASS_I]
			-- Cached classes which are descendants of {TEST_SET}
			--
			-- TODO: use {ETEST_CLASS} instances from test suite instead, this however requires that all
			--       ancestors are kept even if they do not contain test routines.

	traversed_helpers: DS_HASH_SET [EIFFEL_CLASS_I]
			-- Cached ancestors which are not descendants of {TEST_SET}

feature {NONE} -- Access

	sub_task: detachable ETEST_CLUSTER_RETRIEVAL
			-- <Precursor>

	conf_items: DS_ARRAYED_LIST [CONF_VISITABLE]
			-- {CONF_*} items of `target' which will be traversed by sub tasks to retrieve tests
			--
			-- Note: this serves as a stack, where always the last item is removed by `initialize_sub_task'
			--       to be processed.

	traversed_libraries: DS_HASH_SET [UUID]
			-- UUID of libraries which have already been visited by `Current'

	progress_list: DS_ARRAYED_LIST [TUPLE [conf_item: CONF_VISITABLE; total, remaining: INTEGER]]
			-- List containing progress of current library/cluster depth
			--
			-- Note: `progress_list' uses the fact that `conf_items' has a stack structure and basically
			--       keeps track how many items were added on top of the stack by `append_items' or
			--       `append_table' and how many of these elements still remain on the stack. That way the
			--       progress can be computed quite simple.
			--
			-- conf_item: CONF_[TARGET/GROUP]
			-- total: Total child items added to `conf_items'
			-- remaining: Remaining items in `conf_items'

	common_ancestor: EIFFEL_CLASS_I
			-- Common ancestor of all test classes, Void if testing library is not included yet.

	current_library: detachable CONF_LIBRARY
			-- Library for which its clusters are currently being processed

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	has_progress: BOOLEAN = True
			-- <Precursor>

feature {TEST_SUITE_S} -- Status report

	start
			-- <Precursor>
		local
			l_formatter: TEXT_FORMATTER
		do
			if project_access.is_initialized then

				if attached test_suite.output (Current) as l_output then
					l_output.lock
					l_formatter := l_output.formatter
					l_formatter.process_basic_text ("Synchronizing test suite with project")
					l_formatter.add_new_line
					l_formatter.add_new_line
					l_formatter.process_basic_text ("Parsing classes in cluster:")
					l_formatter.add_new_line
					l_output.unlock
				end

				target.process (Current)
				initialize_sub_task
			end
		end

feature {NONE} -- Status setting

	proceed
			-- <Precursor>
		local
			l_sub_task: like sub_task
		do
				-- If `project' is being compiled we abort
			if project_access.is_initialized then

					-- Note: Replace following with Precursor call below once bug #16017 is fixed.
				l_sub_task := sub_task
				check l_sub_task_attached: l_sub_task /= Void end
				l_sub_task.step
				if not l_sub_task.has_next_step then
					remove_task (l_sub_task, False)
				end
				--Precursor {ROTA_SERIAL_TASK_I}
			else
				cancel
			end
		end

	remove_task (a_task: attached like sub_task; a_cancel: BOOLEAN)
			-- <Precursor>
		do
			sub_task := Void
			if not a_cancel then
				initialize_sub_task
			end
			if sub_task = Void then
				conf_items.wipe_out
				traversed_descendants.wipe_out
				traversed_helpers.wipe_out
				traversed_libraries.wipe_out
				progress_list.wipe_out
				current_library := Void
			end
		end

	initialize_sub_task
			-- Initialize next task for `sub_task', which is retrieving tests in last item of `conf_items'.
		require
			sub_task_void: sub_task = Void
		local
			l_conf_items: like conf_items
			l_item: CONF_VISITABLE
			l_progress: TUPLE [conf_item: CONF_VISITABLE; total, remaining: INTEGER]
			l_progress_list: like progress_list
		do
			from
				l_progress_list := progress_list
				l_conf_items := conf_items
			until
				l_conf_items.is_empty or
				(attached sub_task as l_sub_task and then l_sub_task.has_next_step)
			loop
				from
					l_progress := l_progress_list.last
				until
					l_progress.remaining > 0
				loop
					l_progress_list.remove_last
					l_progress := l_progress_list.last
				end
				l_progress.remaining := l_progress.remaining - 1

				l_item := l_conf_items.last
				l_conf_items.remove_last

				l_item.process (Current)
			end
		end

feature -- Basis operations

	process_target (a_target: CONF_TARGET)
			-- <Precursor>
		local
			l_uuid: UUID
			l_old_count, l_count, l_total: INTEGER
		do
			l_uuid := a_target.system.uuid

				-- We only check for an attached `common_ancestor' so we do not unecessarily continue if
				-- testing library is not included.
			if not traversed_libraries.has (l_uuid) and attached common_ancestor then
				traversed_libraries.force_last (l_uuid)

					-- Add clusters to `conf_items'
				l_old_count := conf_items.count
				append_table (a_target.libraries)
				append_table (a_target.clusters)
				l_count := conf_items.count
				if l_count > l_old_count then
					l_total := l_count - l_old_count
					progress_list.force_last ([a_target, l_total, l_total])
				end
			end
		end

	process_library (a_library: CONF_LIBRARY)
			-- <Precursor>
		local
			l_formatter: TEXT_FORMATTER
		do
			if attached test_suite.output (Current) as l_output then
				l_output.lock
				l_formatter := l_output.formatter
				l_formatter.add_group (a_library, a_library.name)
				l_formatter.process_basic_text (" (library)")
				l_formatter.add_new_line
				l_output.unlock
			end
			current_library := a_library
			process_target (a_library.library_target)
		end

	process_cluster (a_cluster: CONF_CLUSTER)
			-- <Precursor>
		local
			l_old_count, l_count, l_total: INTEGER
			l_plist: like progress_list
			l_formatter: TEXT_FORMATTER
			l_appending: BOOLEAN
		do
			if attached common_ancestor as l_class_i then
				l_plist := progress_list

					-- Add sub clusters to `conf_items' which will be processed next
				if attached a_cluster.children as l_ht then
					l_old_count := conf_items.count
					append_items (l_ht)
					l_count := conf_items.count
					if l_count > l_old_count then
							-- We add one to account for current cluster
						l_total := l_count - l_old_count
						l_plist.force_last ([a_cluster, l_total + 1, l_total])
					end
				end

				create sub_task.make (Current, a_cluster, l_class_i)
				if attached test_suite.output (Current) as l_output then
					l_output.lock
					l_formatter := l_output.formatter
					print_cluster (l_formatter, a_cluster)
					l_formatter.add_new_line
					l_output.unlock
				end
			end
		end

feature {NONE} -- Basic operations

	print_cluster (a_formatter: TEXT_FORMATTER; a_cluster: CONF_CLUSTER)
			-- Recursively print cluster path to given formatter.
			--
			-- `a_formatter': Formatter for printing groups.
			-- `a_cluster': Cluster for which path should be printed to `a_formatter'.
		require
			a_formatter_attached: a_formatter /= Void
			a_cluster_attached: a_cluster /= Void
		do
			if attached a_cluster.parent as l_parent then
				print_cluster (a_formatter, l_parent)
				a_formatter.process_basic_text ("/")
			else
				if attached current_library as l_library then
					a_formatter.add_indent
				end
			end
			a_formatter.add_group (a_cluster, a_cluster.name)
		end

feature -- Events

	proceeded_event: EVENT_TYPE [TUPLE [TEST_SESSION_I]]
			-- <Precursor>

feature {NONE} -- Implementation

	append_item (an_item: CONF_VISITABLE)
			-- Append item to `conf_items'.
			--
			-- `an_item': Item to be appended to `conf_items'.
		do
			if
				attached {CONF_LIBRARY} an_item as l_library and then
				not l_library.is_readonly and then l_library.classes_set
			then
				conf_items.force_last (l_library)
			elseif
				attached {CONF_CLUSTER} an_item as l_cluster
			then
				conf_items.force_last (l_cluster)
			end
		end

	append_items (a_list: LIST [CONF_VISITABLE])
			-- Append items in given list to `conf_items'.
			--
			-- `a_list': List containing items to be appended to `conf_items'.
		local
			l_conf_items: like conf_items
		do
			from
				l_conf_items := conf_items
				a_list.start
			until
				a_list.after
			loop
				append_item (a_list.item_for_iteration)
				a_list.forth
			end
		ensure
			appended: conf_items.count = old conf_items.count + a_list.count
		end

	append_table (a_hash_table: HASH_TABLE [CONF_VISITABLE, STRING])
			-- Append items in given table to `conf_items'.
			--
			-- `a_hash_table': Hash table containing items to be appended to `conf_items'
		local
			l_conf_items: like conf_items
		do
			from
				l_conf_items := conf_items
				a_hash_table.start
			until
				a_hash_table.after
			loop
				append_item (a_hash_table.item_for_iteration)
				a_hash_table.forth
			end
		ensure
			appended: conf_items.count = old conf_items.count + a_hash_table.count
		end

feature {NONE} -- Implementation: null routines

	process_system (a_system: CONF_SYSTEM)
			-- <Precursor>
		do
		end

	process_group (a_group: CONF_GROUP)
			-- <Precursor>
		do
		end

	process_assembly (an_assembly: CONF_ASSEMBLY)
			-- <Precursor>
		do
		end

	process_physical_assembly (an_assembly: CONF_PHYSICAL_ASSEMBLY_INTERFACE)
			-- <Precursor>
		do
		end

	process_precompile (a_precompile: CONF_PRECOMPILE)
			-- <Precursor>
		do
		end

	process_test_cluster (a_test_cluster: CONF_TEST_CLUSTER)
			-- <Precursor>
		do
		end

	process_override (an_override: CONF_OVERRIDE)
			-- <Precursor>
		do
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

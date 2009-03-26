note
	description: "[
		Objects implementing {TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	TEST_I

	TEST_MEMENTO_I

create {TEST_PROJECT_I}
	make

feature {NONE} -- Initialization

	make (a_name: like name; a_class_name: like class_name)
			-- Initialize `Current'
			--
			-- `a_name': name of test routine
			-- `a_parent_name': name of class in which routine `a_name' is defined
		do
			name := a_name
			class_name := a_class_name
			internal_tags := new_hash_set (0)
			create {DS_ARRAYED_LIST [EQA_TEST_RESULT]} internal_outcomes.make (0)
		ensure
			name_set: name = a_name
			class_name_set: class_name = a_class_name
			not_has_changed: not has_changed
		end

feature -- Access

	name: STRING
			-- <Precursor>

	class_name: STRING
			-- <Precursor>

	tags: DS_LINEAR [STRING]
			-- <Precursor>
		do
			Result := internal_tags
		end

	outcomes: DS_BILINEAR [like last_outcome]
			-- <Precursor>
		do
			Result := internal_outcomes
		end

	executor: TEST_EXECUTOR_I
			-- <Precursor>
		local
			l_executor: like internal_executor
		do
			l_executor := internal_executor
			check l_executor /= Void end
			Result := l_executor
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := name.hash_code
		end

	memento: TEST_MEMENTO_I
			-- <Precursor>
		do
			Result := Current
		end

feature -- Access: Memento

	added_tags: like tags
			-- Tags added by last call to `set_explicit_tags'
		local
			l_tags: like internal_added_tags
		do
			l_tags := internal_added_tags
			if l_tags /= Void then
				Result := l_tags
			else
				Result := empty_tags
			end
		end

	removed_tags: like tags
			-- Tags removed by last call to `set_explicit_tags'
		local
			l_tags: like internal_removed_tags
		do
			l_tags := internal_removed_tags
			if l_tags /= Void then
				Result := l_tags
			else
				Result := empty_tags
			end
		end

feature {NONE} -- Access

	internal_tags: DS_HASH_SET [STRING]
			-- Internal set of tags

	internal_added_tags: detachable like internal_tags
			-- Internal storage for `added_tags'

	internal_removed_tags: detachable like internal_tags
			-- Internal storage for `removed_tags'

	empty_tags: DS_LINEAR [STRING]
			-- Empty list of tags
		once
			create {DS_ARRAYED_LIST [STRING]} Result.make (0)
		ensure
			empty: Result.is_empty
		end

	internal_executor: detachable TEST_EXECUTOR_I
			-- Internal storage for `executor'

	internal_outcomes: DS_LIST [like last_outcome]
			-- Internal list of outcomes

	old_tags: detachable like internal_tags
			-- Old tags

feature {NONE} -- Query

	outcome_tag: STRING
			-- Tag representing status of last outcome
		require
			has_been_tested: is_outcome_available
		do
			if failed then
				Result := {TEST_CONSTANTS}.outcome_fail_tag
			elseif passed then
				Result := {TEST_CONSTANTS}.outcome_pass_tag
			else
				Result := {TEST_CONSTANTS}.outcome_unresolved_tag
			end
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	has_changed: BOOLEAN
			-- <Precursor>
		do
			Result := internal_added_tags /= Void or internal_removed_tags /= Void or
				is_outcome_added or has_execution_status_changed
		end

	is_queued: BOOLEAN
			-- <Precursor>

	is_running: BOOLEAN
			-- <Precursor>

feature -- Status report: Memento

	is_outcome_added: BOOLEAN
			-- Has outcome been added since last call to `clear_changes'?

	has_execution_status_changed: BOOLEAN
			-- Has execution status changed since last call to `clear_changes'?

feature {ACTIVE_COLLECTION_I} -- Status setting

	clear_changes
			-- <Precursor>
		do
			internal_added_tags := Void
			internal_removed_tags := Void
			is_outcome_added := False
			has_execution_status_changed := False
		end

feature {TEST_SUITE_S} -- Status setting

	set_explicit_tags (a_list: DS_LINEAR [STRING])
			-- <Precursor>
		do
			old_tags := internal_tags
			internal_tags := new_hash_set (a_list.count.to_natural_32)
			a_list.do_all (agent add_tag)
			if is_outcome_available then
				add_tag (outcome_tag)
			end
			if not old_tags.is_empty then
				internal_removed_tags := old_tags
			end
			old_tags := Void
		end

	set_queued (a_executor: like executor)
			-- <Precursor>
		do
			is_queued := True
			has_execution_status_changed := True
			internal_executor := a_executor
		end

	set_running
			-- <Precursor>
		do
			is_queued := False
			has_execution_status_changed := True
			is_running := True
		end

	add_outcome (an_outcome: like last_outcome)
			-- Add `an_outcome' to the end of `outcomes'. Addopt outcome tag
			-- according to `an_outcome' and set `has_changed' to True if `tags'
			-- has changed. Otherwise `has_changed' is False.
		local
			l_old, l_new: STRING
		do
			if is_outcome_available then
				l_old := outcome_tag
			end
			internal_outcomes.force_last (an_outcome)
			l_new := outcome_tag
			if l_old = Void or else not l_old.is_equal (l_new) then
				if internal_added_tags = Void then
					internal_added_tags := new_hash_set (1)
				end
				internal_added_tags.force_last (l_new)
				internal_tags.force_last (l_new)
				if l_old /= Void then
					if internal_removed_tags = Void then
						internal_removed_tags := new_hash_set (1)
					end
					internal_removed_tags.force_last (l_old)
					internal_tags.remove (l_old)
				end
			end
			is_running := False
			is_queued := False
			has_execution_status_changed := True
			is_outcome_added := True
		ensure then
			tags_contain_outcome_tag: tags.has (outcome_tag)
		end

	abort
			-- <Precursor>
		do
			internal_executor := Void
			is_queued := False
			is_running := False
			has_execution_status_changed := True
		end

feature {TEST_MEMENTO_I} -- Factory

	new_hash_set (a_count: NATURAL): like internal_tags
			-- Create new {DS_HASH_SET [!STRING]} with capacity `n' using a string equality tester.
		do
			create Result.make (a_count.to_integer_32)
			Result.set_equality_tester (create {KL_STRING_EQUALITY_TESTER_A [STRING]})
		end

feature {NONE} -- Implementation

	add_tag (a_tag: STRING)
			-- Add tag to `internal_tags' and remove it from `old_tags'
		require
			old_tags_attached: old_tags /= Void
		do
			internal_tags.force_last (a_tag)
			old_tags.search (a_tag)
			if old_tags.found then
				old_tags.remove_found_item
			else
				if internal_added_tags = Void then
					internal_added_tags := new_hash_set (5)
				end
				internal_added_tags.force_last (a_tag)
			end
		end

note
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

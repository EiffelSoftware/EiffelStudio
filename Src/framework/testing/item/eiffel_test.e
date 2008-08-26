indexing
	description: "[
		Objects implementing {EIFFEL_TEST_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST

inherit
	EIFFEL_TEST_I

	SHARED_TEST_CONSTANTS

	KL_SHARED_STRING_EQUALITY_TESTER

create {EIFFEL_TEST_PROJECT_I}
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
			internal_tags := new_hash_set
			create {!DS_ARRAYED_LIST [!TEST_OUTCOME]} internal_outcomes.make (0)
			add_implicit_tags
		ensure
			name_set: name = a_name
			class_name_set: class_name = a_class_name
			not_has_changed: not has_changed
		end

feature -- Access

	name: !STRING
			-- <Precursor>

	class_name: !STRING
			-- <Precursor>

	tags: !DS_LINEAR [!STRING]
			-- <Precursor>
		do
			Result := internal_tags
		end

	outcomes: !DS_BILINEAR [like last_outcome]
			-- <Precursor>
		do
			Result := internal_outcomes
		end

	executor: !EIFFEL_TEST_EXECUTOR_I
			-- <Precursor>
		do
			Result ?= internal_executor
		end

	hash_code: INTEGER
			-- <Precursor>
		do
			Result := name.hash_code
		end

	memento: !EIFFEL_TEST_MEMENTO_I is
			-- <Precursor>
		do
			Result ?= internal_memento
		end

feature {NONE} -- Access

	internal_tags: !DS_HASH_SET [!STRING]
			-- Internal set of tags

	internal_executor: ?EIFFEL_TEST_EXECUTOR_I
			-- Internal storage for `executor'

	internal_outcomes: !DS_LIST [like last_outcome]
			-- Internal list of outcomes

	internal_memento: ?EIFFEL_TEST_MEMENTO

feature {NONE} -- Query

	outcome_tag: !STRING
			-- Tag representing status of last outcome
		require
			has_been_tested: is_outcome_available
		do
			if failed then
				Result := outcome_fail_tag
			elseif passed then
				Result := outcome_pass_tag
			else
				Result := outcome_unresolved_tag
			end
		end

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	has_changed: BOOLEAN is
			-- <Precursor>
		do
			Result := internal_memento /= Void
		end

	is_queued: BOOLEAN
			-- <Precursor>

	is_running: BOOLEAN
			-- <Precursor>

	is_outcome_available: BOOLEAN
			-- <Precursor>
		do
			Result := not internal_outcomes.is_empty
		end

feature {ACTIVE_COLLECTION_I} -- Status setting

	clear_changes is
			-- <Precursor>
		do
			internal_memento := Void
		end

feature {EIFFEL_TEST_SUITE_S} -- Status setting

	set_explicit_tags (a_list: !DS_LINEAR [!STRING]) is
			-- <Precursor>
		local
			l_old_tags: like internal_tags
		do
			l_old_tags := internal_tags
			internal_tags := new_hash_set
			internal_tags.append (a_list)
			add_implicit_tags
			if not l_old_tags.is_equal (internal_tags) then
				create_memento
				l_old_tags.do_all (agent (a_tag: !STRING)
					do
						if not internal_tags.has (a_tag) then
							internal_memento.removed_tags.force (a_tag)
						end
					end)
				internal_tags.do_all (agent (a_tag: !STRING; l_old: like internal_tags)
					do
						if not l_old.has (a_tag) then
							internal_memento.added_tags.force (a_tag)
						end
					end (?, l_old_tags))
			end
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	abort is
			-- <Precursor>
		do
			internal_executor := Void
			is_queued := False
			is_running := False
		end

	set_running is
			-- <Precursor>
		do
			is_queued := False
			is_running := True
		end

	set_queued (a_executor: like executor) is
			-- <Precursor>
		do
			is_queued := True
			internal_executor := a_executor
		end

	add_outcome (an_outcome: like last_outcome) is
			-- Add `an_outcome' to the end of `outcomes'. Addopt outcome tag
			-- according to `an_outcome' and set `has_changed' to True if `tags'
			-- has changed. Otherwise `has_changed' is False.
		do
			internal_tags.remove (outcome_tag)
			internal_outcomes.force_last (an_outcome)
			internal_tags.force (outcome_tag)
		ensure then
			tags_contain_outcome_tag: tags.has (outcome_tag)
		end

feature {EIFFEL_TEST_MEMENTO} -- Factory

	new_hash_set: like internal_tags
			-- Create new {DS_HASH_SET [!STRING]} with capacity `n' using a string equality tester.
		do
			create Result.make_default
			Result.set_equality_tester ({KL_EQUALITY_TESTER [!STRING]} #? string_equality_tester)
		end

feature {NONE} -- Implementation

	create_memento is
			-- Create `internal_memento' to indicate that `Current' has changed.
		do
			create internal_memento.make (Current)
		end

	add_implicit_tags
			-- Add implicit tags for `Current' to `internal_tags'.
		do
			internal_tags.force_last ({!STRING} #? "class.{" + class_name + "}")
			if is_outcome_available then
				internal_tags.force_last (outcome_tag)
			end
		end

end

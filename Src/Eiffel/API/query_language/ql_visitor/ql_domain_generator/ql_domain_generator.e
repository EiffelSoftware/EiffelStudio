indexing
	description: "Object to generate different domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_DOMAIN_GENERATOR

inherit
	QL_VISITOR

	QL_SHARED_SCOPES

	QL_OBSERVABLE
		rename
			observed_data_type as item_type
		redefine
			item_type
		end

feature -- Setting

	reset_domain is
			-- Reset `domain' to its empty status.
		do
			domain.content.wipe_out
		ensure
			domain_reset: domain.is_empty
		end

	set_criterion (a_criterion: like criterion) is
			-- Set `criterion' with `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		do
			criterion := a_criterion
			internal_actual_criterion := Void
		ensure
			criterion_set: criterion = a_criterion
			internal_actual_criterion_reset: internal_actual_criterion = Void
		end

	remove_criterion is
			-- Remove `criterion'.
		do
			criterion := Void
			internal_actual_criterion := Void
		ensure
			criterion_removed: criterion = Void
			internal_actual_criterion_reset: internal_actual_criterion = Void
		end

	enable_fill_domain is
			-- Enable that newly generated domain will be filled with satisfied items.
		do
			is_fill_domain_enabled := True
		ensure
			fill_domain_enabled: is_fill_domain_enabled
		end

	disable_fill_domain is
			-- Disable that newly generated domain will be filled with satisfied items.
		do
			is_fill_domain_enabled := False
		ensure
			fill_domain_disabled: not is_fill_domain_enabled
		end

feature -- Status report

	is_fill_domain_enabled: BOOLEAN
			-- During domain generation, if some item is satisfied by `criterion' will it
			-- be inserted into `domain'?
			-- Default: False

feature -- Access

	actions: ACTION_SEQUENCE [TUPLE[like item_type]] is
			-- Actions to be performed when a new item is generated
		do
			if actions_internal = Void then
				create actions_internal
			end
			Result := actions_internal
		ensure
			result_attached: Result /= Void
		end

	criterion: QL_CRITERION
			-- Criterion used when generating new items

	domain: QL_DOMAIN is
			-- Generated domain
		deferred
		ensure
			result_attached: Result /= Void
		end

	scope: QL_SCOPE is
			-- Scope of current generator
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Visit

	process_domain (a_item: QL_DOMAIN) is
			-- Process `a_item'.
		local
			l_criterion: like criterion
			l_domain: like domain
		do
			current_source_domain := a_item
			actual_criterion.set_source_domain (a_item)
			l_criterion := actual_criterion
			if l_criterion.is_atomic and l_criterion.has_intrinsic_domain then
				l_domain := criterion.intrinsic_domain
				l_domain.content.do_all (agent on_item_satisfied_by_criterion ({QL_ITEM}?))
				domain.content.fill (l_domain.content)
			else
				if not a_item.is_empty then
					a_item.content.do_all (agent process_item ({QL_ITEM}?))
				end
			end
		end

feature{NONE} -- Implementation

	actions_internal: like actions
			-- Implementation of `actions'

	actual_criterion: like criterion is
			-- Actual criterion used when generating items
		do
			if internal_actual_criterion = Void then
				if criterion = Void then
					internal_actual_criterion := tautology_criterion
				else
					if criterion.require_compiled then
						internal_actual_criterion := criterion.compiled_criterion
					else
						internal_actual_criterion := criterion
					end
				end
			end
			Result := internal_actual_criterion
		ensure
			result_attached: Result /= Void
		end

	internal_actual_criterion: like criterion
			-- Implementation of `actual_criterion'

	tautology_criterion: like criterion is
			-- Tautology criterion
		deferred
		ensure
			good_result: Result /= Void
		end

	compiled_criterion: like criterion is
			-- A criterion that only compiled items can satisfy
		deferred
		ensure
			good_result: Result /= Void
		end

	evaluate_item (a_item: like item_type) is
			-- Evaluate `a_item' using `actual_criterion'.
			-- If `actual_criterion' is satisfied by `a_item', put `a_item' in `domain' and call `actions'.
		require
			a_item_attached: a_item /= Void
		do
			if has_observer then
				set_changed
				notify (a_item)
			end
			if actual_criterion.is_satisfied_by (a_item) then
				on_item_satisfied_by_criterion (a_item)
				if is_fill_domain_enabled then
					domain.content.extend (a_item)
				end
			end
		end

feature{NONE} -- Implementation

	process_groups_from_target (a_target: CONF_TARGET; a_parent: QL_ITEM; a_action: PROCEDURE [ANY, TUPLE [QL_GROUP]]) is
			-- Iterate through groups in `a_target' and call `a_action' for every group.
		require
			a_target_attached: a_target /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
			a_action_attached: a_action /= Void
		local
			l_groups: HASH_TABLE [CONF_GROUP, STRING]
			l_cursor: CURSOR
			l_group: QL_GROUP
		do
			l_groups := a_target.groups
			l_cursor := l_groups.cursor
			from
				l_groups.start
			until
				l_groups.after
			loop
				create l_group.make_with_parent (l_groups.item_for_iteration, a_parent)
				l_group.set_name (l_groups.key_for_iteration)
				a_action.call ([l_group])
				l_groups.forth
			end
			if l_cursor /= Void then
				l_groups.go_to (l_cursor)
			end
		end

	process_classes_from_group (a_group: CONF_GROUP; a_parent: QL_ITEM; a_action: PROCEDURE [ANY, TUPLE [QL_CLASS]]) is
			-- For every class in `a_group', call `a_action'.
		require
			a_group_attached: a_group /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
			a_action_attached: a_action /= Void
		local
			l_class: QL_CLASS
			l_classes: HASH_TABLE [CONF_CLASS, STRING]
			l_cursor: CURSOR
			l_actual_criterion: like actual_criterion
			l_class_cri: QL_CLASS_CRITERION
		do
			l_classes := a_group.classes
			if l_classes /= Void and then not l_classes.is_empty then
				l_actual_criterion := actual_criterion
				if l_actual_criterion.require_compiled then
					create {QL_CLASS_IS_COMPILED_CRI}l_class_cri
				else
					create {QL_CLASS_TRUE_CRI}l_class_cri
				end
				check current_source_domain /= Void end
				l_class_cri.set_source_domain (current_source_domain)
				l_cursor := l_classes.cursor
				from
					l_classes.start
				until
					l_classes.after
				loop
					create l_class.make_with_parent (l_classes.item_for_iteration, a_parent)
					l_class.set_name (l_classes.key_for_iteration)
					if l_class_cri.is_satisfied_by (l_class) then
						a_action.call ([l_class])
					end
					l_classes.forth
				end
				if l_cursor /= Void and then l_classes.valid_cursor (l_cursor) then
					l_classes.go_to (l_cursor)
				end
			end
		end

	process_line_from_code_item (a_item: QL_CODE_STRUCTURE_ITEM) is
			-- Find out all possible QL_LINE items from `a_item'.
		local
			l_lines: LIST [STRING]
			l_class_text: STRING
			l_index: INTEGER
			l_count: INTEGER
			l_line: QL_LINE
			l_cur_line: STRING
			l_new_line_char: CHARACTER
		do
			if a_item.is_compiled then
				l_new_line_char := '%N'
				l_class_text := a_item.text
				l_lines := l_class_text.split (l_new_line_char)
				from
					l_lines.start
					l_index := 1
					l_count := l_lines.count - 1
				until
					l_index > l_count
				loop
					l_cur_line := l_lines.item
					l_cur_line.append_character (l_new_line_char)
					create l_line.make_with_text (l_index, l_cur_line, a_item)
					evaluate_item (l_line)
					l_lines.forth
					l_index := l_index + 1
				end
					-- Special case for last line: check if last line is not ended with a new-line character,
				l_cur_line := l_lines.last
				if l_class_text.item (l_class_text.count) = l_new_line_char then
					l_cur_line.append_character (l_new_line_char)
				end
				create l_line.make_with_text (l_index, l_cur_line, a_item)
				evaluate_item (l_line)
			end
		end

	process_feature_from_class (a_class: QL_CLASS; a_real_feature_action: PROCEDURE [ANY, TUPLE [QL_REAL_FEATURE]]; a_invariant_action: PROCEDURE [ANY, TUPLE [QL_INVARIANT]]) is
			-- Iterate through features in `a_class' and call `a_real_feature_action' for every real feature,
			-- call `a_invariant_action' for every invariant feature.
		require
			a_class_attached: a_class /= Void
			a_class_is_compiled: a_class.is_compiled
			a_real_feature_action_attached: a_real_feature_action /= Void
			a_invariant_action_attached: a_invariant_action /= Void
		local
			l_class_c: CLASS_C
			l_feature_table: E_FEATURE_TABLE
			l_real_feature: QL_REAL_FEATURE
			l_invariant: QL_INVARIANT
			l_parents: LINKED_LIST [CLASS_C]
			l_inv_ast: INVARIANT_AS
		do
			l_class_c := a_class.class_c
				-- Find real features.
			l_feature_table := l_class_c.api_feature_table
			from
				l_feature_table.start
			until
				l_feature_table.after
			loop
				create l_real_feature.make_with_parent (l_feature_table.item_for_iteration, a_class)
				a_real_feature_action.call ([l_real_feature])
				l_feature_table.forth
			end
				-- Find invariant.
				-- First find immediate invariant
			if l_class_c.has_invariant then
				create l_invariant.make_with_parent (l_class_c, l_class_c, a_class)
				a_invariant_action.call ([l_invariant])
			end
				-- Then the inherited invariants.
			from
				create l_parents.make
				record_ancestors_of_class (l_class_c, l_parents)
				l_parents.start
			until
				l_parents.after
			loop
				l_inv_ast := l_parents.item.invariant_ast
				if l_inv_ast /= Void then
					create l_invariant.make_with_parent (l_class_c, l_parents.item, a_class)
					a_invariant_action.call ([l_invariant])
				end
				l_parents.forth
			end
		end

	record_ancestors_of_class (a_class: CLASS_C; a_ancestors: LIST [CLASS_C]) is
			-- Record all ancestores of `a_class' in `a_ancestors' .
		require
			class_not_void: a_class /= Void
			a_ancestors_attached: a_ancestors /= Void
		local
			parents: FIXED_LIST [CL_TYPE_A]
			a_parent: CLASS_C
		do
			from
				parents := a_class.parents
				parents.start
			until
				parents.after
			loop
				a_parent := parents.item.associated_class
				if not a_ancestors.has (a_parent) then
					a_ancestors.extend (a_parent)
					record_ancestors_of_class (a_parent, a_ancestors)
				end
				parents.forth
			end
		end

	internal_domain: like domain
			-- Implementation of `domain'

	on_item_satisfied_by_criterion (a_item: like item_type) is
			-- Action to be performed when `a_item' is satisfied by `criterion'
		require
			a_item_attached: a_item /= Void
			a_item_valid: a_item.is_valid_domain_item
		do
			actions.call ([a_item])
		end

	current_source_domain: QL_DOMAIN
			-- Current processing source domain

	item_type: QL_ITEM
			-- Anchor type for items of generated domain

invariant
	domain_attached: domain /= Void
indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

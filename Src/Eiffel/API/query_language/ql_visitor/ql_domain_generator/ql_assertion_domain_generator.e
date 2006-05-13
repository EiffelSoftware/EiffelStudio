indexing
	description: "Object to generate feature assertion domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ASSERTION_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			domain,
			item_type
		end

	QL_SHARED_ASSERTION_TYPES

feature -- Access

	criterion: QL_ASSERTION_CRITERION
			-- Criterion used when generating new items

	domain: QL_ASSERTION_DOMAIN is
			-- Generated domain
		do
			if internal_domain = Void then
				create internal_domain.make
			end
			Result := internal_domain
		ensure then
			result_set: Result = internal_domain
		end

	scope: QL_SCOPE is
			-- Scope of current generator
		do
			Result := assertion_scope
		ensure then
			good_result: Result = assertion_scope
		end

feature -- Visit

	process_target (a_item: QL_TARGET) is
			-- Process `a_item'.
		do
			process_groups_from_target (a_item.target, a_item, agent process_group)
		end

	process_group (a_item: QL_GROUP) is
			-- Process `a_item'.
		do
			process_classes_from_group (a_item.group, a_item, agent process_class)
		end

	process_class (a_item: QL_CLASS) is
			-- Process `a_item'.
		do
			process_feature_from_class (a_item, agent process_real_feature, agent process_invariant)
		end

	process_feature (a_item: QL_FEATURE) is
			-- Process `a_item'.		
		do
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		local
			l_assertion_server: ASSERTION_SERVER
			l_assertions: CHAINED_ASSERTIONS
			l_assert: ROUTINE_ASSERTIONS
			l_written_in_class: CLASS_C
			l_precondition: REQUIRE_AS
			l_postcondition: ENSURE_AS
			l_routine_as: ROUTINE_AS
		do
			create l_assertion_server.make_for_feature (a_item.class_c.feature_named (a_item.name), a_item.ast)
			l_assertions := l_assertion_server.current_assertion
			if l_assertions /= Void and then not l_assertions.is_empty then
				from
					l_assertions.start
				until
					l_assertions.after
				loop
					l_assert := l_assertions.item
					l_written_in_class := l_assert.origin.written_class
					l_precondition := l_assert.precondition
					if l_precondition /= Void then
						process_precondition (l_precondition, l_written_in_class, a_item)
					end
					l_postcondition := l_assert.postcondition
					if l_postcondition /= Void then
						process_postcondition (l_postcondition, l_written_in_class, a_item)
					end
					l_assertions.forth
				end
			else
				l_routine_as ?= a_item.ast.body.content
				if l_routine_as /= Void then
					l_written_in_class := a_item.written_class
					l_precondition := l_routine_as.precondition
					if l_precondition /= Void then
						process_precondition (l_precondition, l_written_in_class, a_item)
					end
					l_postcondition := l_routine_as.postcondition
					if l_postcondition /= Void then
						process_postcondition (l_postcondition, l_written_in_class, a_item)
					end
				end
			end
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		local
			l_ast: INVARIANT_AS
		do
			l_ast := a_item.ast
			process_assertion_list (l_ast.assertion_list, l_ast, invariant_type, a_item.written_class, a_item)
		end

	process_quantity (a_item: QL_QUANTITY) is
			-- Process `a_item'.
		do
		end

	process_line (a_item: QL_LINE) is
			-- Process `a_item'.
		do
		end

	process_generic (a_item: QL_GENERIC) is
			-- Process `a_item'.
		do
		end

	process_local (a_item: QL_LOCAL) is
			-- Process `a_item'.
		do
		end

	process_argument (a_item: QL_ARGUMENT) is
			-- Process `a_item'.
		do
		end

	process_assertion (a_item: QL_ASSERTION) is
			-- Process `a_item'.
		do
			evaluate_item (a_item)
		end


feature{NONE} -- Implementation

	tautology_criterion: like criterion is
			-- Tautology criterion
		do
			create {QL_ASSERTION_TRUE_CRI}Result
		end

	compiled_criterion: like criterion is
			-- A criterion that only compiled items can satisfy
		do
			create {QL_ASSERTION_IS_COMPILED_CRI}Result
		end

	process_assertion_list (a_assert_list: EIFFEL_LIST [TAGGED_AS]; a_written_in_ast: AST_EIFFEL; a_assert_type: QL_ASSERTION_TYPE; a_written_class: CLASS_C; a_parent: QL_FEATURE) is
			-- Process `a_assert_list'.
			-- `a_written_in_ast' indicates in which require/ensure/invariant part does `a_assert_list' appears.
			-- `a_assert_type' indicates assertion type of items in `a_assert_list'.
			-- `a_written_class' indicates the written-in class of `a_assert_list'.
			-- `a_parent' indicates to which feature `a_assert_list' belongs.
		require
			a_assert_list_attached: a_assert_list /= Void
			not_a_assert_list_is_empty: not a_assert_list.is_empty
			a_assert_type_attached: a_assert_type /= Void
			a_written_in_ast_attached: a_written_in_ast /= Void
			a_written_class_attached: a_written_class /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item
		local
			l_tags: EIFFEL_LIST [TAGGED_AS]
			l_assertion: QL_ASSERTION
		do
			from
				a_assert_list.start
			until
				a_assert_list.after
			loop
				create l_assertion.make (a_assert_list.item, a_written_in_ast, a_written_class, a_assert_type, a_parent)
				evaluate_item (l_assertion)
				a_assert_list.forth
			end
		end

	process_precondition (a_require: REQUIRE_AS; a_written_class: CLASS_C; a_parent: QL_FEATURE) is
			-- Process all assertions in `a_require'.
			-- `a_written_class' indicates where `a_require' is written.
		require
			a_require_attached: a_require /= Void
			a_written_class_attached: a_written_class /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item and then a_parent.is_real_feature
		local
			l_assert_list: EIFFEL_LIST [TAGGED_AS]
			l_assert_type: QL_ASSERTION_TYPE
		do
			l_assert_list := a_require.full_assertion_list
			if l_assert_list /= Void and then not l_assert_list.is_empty then
				if a_require.is_else then
					l_assert_type := require_else_type
				else
					l_assert_type := require_type
				end
				process_assertion_list (l_assert_list, a_require, l_assert_type, a_written_class, a_parent)
			end
		end

	process_postcondition (a_ensure: ENSURE_AS; a_written_class: CLASS_C; a_parent: QL_FEATURE) is
			-- Process all assertions in `a_ensure'.
			-- `a_written_class' indicates where `a_require' is written.
		require
			a_ensure_attached: a_ensure /= Void
			a_written_class_attached: a_written_class /= Void
			a_parent_attached: a_parent /= Void
			a_parent_valid: a_parent.is_valid_domain_item and then a_parent.is_real_feature
		local
			l_assert_list: EIFFEL_LIST [TAGGED_AS]
			l_assert_type: QL_ASSERTION_TYPE
		do
			l_assert_list := a_ensure.full_assertion_list
			if l_assert_list /= Void and then not l_assert_list.is_empty then
				if a_ensure.is_then then
					l_assert_type := ensure_then_type
				else
					l_assert_type := ensure_type
				end
				process_assertion_list (l_assert_list, a_ensure, l_assert_type, a_written_class, a_parent)
			end
		end

feature{NONE} -- Observable

	item_type: QL_ASSERTION;
			-- Anchor type for items of generated domain

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

indexing
	description: "Visitor to check accessors for a given feature"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ACCESSED_FEATURE_VISITOR

inherit
	AST_ITERATOR
		export
			{NONE} all
		redefine
			process_access_feat_as,
			process_access_assert_as
		end

	QL_UTILITY

	QL_SHARED

create
	make

feature{NONE} -- Initialization

	make is
			-- Initialize Current.
		do
			create {LINKED_LIST [TUPLE [AST_EIFFEL, CLASS_C, BOOLEAN]]} accessors.make
			create ancestor_class_id_set.make (20)
		end

feature -- Access

	accessors: LIST [TUPLE [AST_EIFFEL, CLASS_C, BOOLEAN]]
			-- Accessors found by last `find_accessors'
			-- The TUPLE is in form of [accessor AST, accessor written class, is_in_assertion]

feature -- Status report

	should_assertion_be_checked: BOOLEAN
			-- When searching for callees, should assertions be checked?

feature -- Setting

	set_should_assertion_be_checked (b: BOOLEAN) is
			-- Set `should_assertion_be_checked' with `b'.
		do
			should_assertion_be_checked := b
		ensure
			should_assertion_be_checked_set: should_assertion_be_checked = b
		end

feature -- Process

	find_accessors (a_callee: QL_FEATURE; a_caller: QL_FEATURE) is
			-- Find `a_callee' from `a_caller' and store results in `accessors'.
		require
			a_callee_attached: a_callee /= Void
			a_caller_attached: a_caller /= Void
		local
			l_assertion_domain: QL_ASSERTION_DOMAIN
			l_assertion_generator: QL_ASSERTION_DOMAIN_GENERATOR
		do
			accessors.wipe_out
			ancestor_class_id_set.wipe_out
			if a_callee.is_real_feature then
				e_feature := a_callee.e_feature
				last_class_c := a_caller.class_c
				ancestor_class_id_set.put (e_feature.associated_class.class_id)

					-- Check feature body without assertions
				if a_caller.is_real_feature then
					set_should_assertion_be_checked (False)
					a_caller.ast.process (Current)
				end

					-- Retrieve all assertions and check those assertions.
				setup_ancestor_class_id_table (e_feature.associated_class)
				set_should_assertion_be_checked (True)
				create l_assertion_generator.make (Void, True)
				l_assertion_domain ?= a_caller.wrapped_domain.new_domain (l_assertion_generator)
				if l_assertion_domain /= Void and then not l_assertion_domain.is_empty then
					l_assertion_domain.do_all (agent process_assertion)
				end
			end
		end

	setup_ancestor_class_id_table (a_class_c: CLASS_C) is
			-- Setup `ancestor_class_id_set' with ancestors of `a_class_c'.
		require
			a_class_c_attached: a_class_c /= Void
		local
			l_table: like ancestor_class_id_set
			l_ancestors: QL_CLASS_DOMAIN
			l_class_generator: QL_CLASS_DOMAIN_GENERATOR
		do
				-- Retrieve ancestor classes for associated class of `a_class_c'.
			create l_class_generator.make (
				create {QL_CLASS_ANCESTOR_RELATION_CRI}.make (
					query_class_item_from_class_c (a_class_c).wrapped_domain,
					{QL_CLASS_ANCESTOR_RELATION_CRI}.ancestor_type),
					True)
			l_class_generator.enable_optimization
			l_ancestors ?= system_target_domain.new_domain (l_class_generator)

				-- Setup `ancestor_class_id_table'.			
			if l_ancestors /= Void and then not l_ancestors.is_empty then
				from
					l_table := ancestor_class_id_set
					l_ancestors.start
				until
					l_ancestors.after
				loop
					l_table.force (l_ancestors.item.class_c.class_id)
					l_ancestors.forth
				end
			end
		end

feature{NONE} -- Implementation

	e_feature: E_FEATURE
			-- Eiffel feature whose accessors are to be found

	is_accessor (a_class_id: INTEGER; a_feature_name: STRING): BOOLEAN is
			-- Is feature named `a_feature_name' whose associated class id is `a_class_id' a successor of `e_feature'?
		require
			a_feature_name_attached: a_feature_name /= Void
			not_a_feature_name_is_empty: not a_feature_name.is_empty
		local
			l_feature: like e_feature
		do
			l_feature := e_feature
			Result := a_feature_name.is_case_insensitive_equal (l_feature.name) and then ancestor_class_id_set.has (a_class_id)
		end

	ancestor_class_id_set: DS_HASH_SET [INTEGER]
			-- Class id set of ancestors of associated class of `e_feature'

	last_class_c: CLASS_C
			-- Last processed class

	check_accessor (l_as: ACCESS_FEAT_AS) is
			-- Check if `l_as' is a accessor of `e_feature'.
			-- If it is, store `l_as' into `accessors'.
		do
			if is_accessor (l_as.class_id, l_as.access_name) then
				check last_class_c /= Void end
				accessors.extend ([l_as.feature_name, last_class_c, should_assertion_be_checked])
			end
		end

feature{NONE} -- Implementation/Process

	process_access_feat_as (l_as: ACCESS_FEAT_AS) is
		do
			check_accessor (l_as)
			Precursor (l_as)
		end

	process_access_assert_as (l_as: ACCESS_ASSERT_AS) is
		do
			if should_assertion_be_checked then
				process_access_feat_as (l_as)
			end
		end

	process_assertion (a_assertion: QL_ASSERTION) is
			-- Process `a_assertion'.
		require
			a_assertion_attached: a_assertion /= Void
		do
			last_class_c := a_assertion.written_class
			a_assertion.ast.process (Current)
		end

invariant
	accessors_attached: accessors /= Void
	ancestor_class_id_set_attached: ancestor_class_id_set /= Void

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

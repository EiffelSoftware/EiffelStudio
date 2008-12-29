note
	description: "[
					Object that represents a criterion in Eiffel query lanagage
					
					Intrinsic domain
					
					A criterion can have an inclusive intrinsic domain, exclusive intrinsic domain or 
					no intrinsic domain. To understant what is an intrinsic domain, we should have a look at 
					how query language works in general.
					
					For example, query:
						select class where is_deferred
					This query will list all classes in current application target and check if a classes is deferred, 
					if it is, it will be put into result domain.
					
					And in query:
						select class where ancestor_is "STRING"
					To evaluate this query, in deed, we don't need to list all classes in current application target because, 
					the compiler can provide us the descendant information of class STRING. In this case, 
					the best way to evaluate the query is to get a list of descendant classes of class STRING first 
					from the compiler, and then check those classes to see if they are in current application target 
					(which is obviously true in our case), if so, we put them in the result domain.

					So a criterion like ancestor_is is called criterion with an intrinsic domain. Other
					intrinsic domain criterion include: descendant_is, parent_is, heir_is, caller_is,
					callers_of, implementors_of.
					And in this case, the intrinsic domain is an inclusive intrinsic domain.

					When an inclusive intrinsic domain criterion is applied to a NOT criterion, its inclusive
					intrinsic domain turns to an exclusive intrinsic domain of the not criterion.

					For example,
						select class where not ancestor_is "STRING"
					here, not ancestor_is "STRING" is a NOT criterion with an exclusive intrinsic domain.
					And this exclusive intrinsic domain is from the inclusive intrinsic domain of
					the criterion ancestor_is.

					A criterion such as is_deferred has no intrinsic domain.
					
					-------------------------------------------------------------------------------------------------------------------					
					
					Criterion retrieval
					
					Criterion object can be retrieved from criterion factories.
					For more information about criterion factories, see {QL_CRIERION_FACTORY} and its
					descendant classes.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CRITERION

inherit
	QL_SHARED_SCOPES

	REFACTORING_HELPER

feature -- Evaluate

	is_satisfied_by (a_item: like item_type): BOOLEAN
			-- Evaluate `a_item'.
		require
			a_item_attached: a_item /= Void
			source_domain_attached: source_domain /= Void
		deferred
		end

feature -- Status report

	require_compiled: BOOLEAN
			-- Does current criterion require a compiled item?
		deferred
		end

	scope: QL_SCOPE
			-- Scope of current ciretrion
		deferred
		ensure
			result_attached: Result /= Void
		end

	is_atomic: BOOLEAN
			-- Is current criterion atomic?
		do
			Result := True
		end

	has_inclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has a domain by default?
		do
		end

	has_exclusive_intrinsic_domain: BOOLEAN
			-- Does current criterion has an exclusive intrinsic domain?
		do
		end

	has_intrinsic_domain: BOOLEAN
			-- Does current criterion has an intrinsic domain (either inclusive or exclusive)?
		do
			Result := has_inclusive_intrinsic_domain or has_exclusive_intrinsic_domain
		ensure
			good_result: Result implies (has_inclusive_intrinsic_domain or has_exclusive_intrinsic_domain) and
						 not Result implies (not has_inclusive_intrinsic_domain and not has_exclusive_intrinsic_domain)
		end

feature -- Logic operations

	infix "and" (other: QL_CRITERION): QL_CRITERION
			-- Boolean conjunction with `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	prefix "not": QL_CRITERION
			-- Negation
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	infix "or" (other: QL_CRITERION): QL_CRITERION
			-- Boolean disjunction with `other'
		require
			other_exists: other /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Access

	compiled_criterion: QL_CRITERION
			-- A criterion which takes `require_compiled' into account
		deferred
		ensure
			result_attached: Result /= Void
		end

	source_domain: QL_DOMAIN
			-- Source domain
			-- e.g, Current criterion is used in a domain generator when we want to
			-- generate a new domain from `source_domain'
			-- For example: in query:
			--
			--         from target select class where is_deferred
			--
			-- This query will give you all deferred classes in current system target.
			-- Here, "target" is source domain, and "class" will be the generated domain.
			-- Internally, a class domain generator will
			-- try to find all classes in "target" and then check if it satisfied by criterion "is_deferred",
			-- if so, the domain generator will put this class in newly generated domain.

	domain_generator (a_enable_fill_domain: BOOLEAN; a_apply_current: BOOLEAN): QL_DOMAIN_GENERATOR
			-- Domain generator in which current criterion can be used
			-- If `a_enable_fill_domain' is True, return a generator with `fill_domain_enabled' set to True.
			-- If `a_apply_current' is True, return a generator with `criterion' set to Current.
		deferred
		ensure
			result_attached: Result /= Void
		end

	intrinsic_domain: QL_DOMAIN
			-- Intrinsic_domain which can be inferred from current criterion
		require
			source_domain_attached: source_domain /= Void
			current_has_intrinsic_domain: has_intrinsic_domain
		deferred
		ensure
			result_attached: has_inclusive_intrinsic_domain implies Result /= Void
		end

	used_in_domain_generator: QL_DOMAIN_GENERATOR
			-- Domain generator in which current criterion is used
			-- For example, `a_domain_generator' is a domain generator,
			-- `a_criterion' is a criterion, after `a_domain_generator.set_criterion (a_criterion)',
			-- `a_criterion.used_in_domain_generator' is set with `a_domain_generator'.

feature{QL_CRITERION, QL_DOMAIN_GENERATOR} -- Setting

	set_source_domain (a_domain: like source_domain)
			-- Set `source_domain' with `a_domain'.
		require
			a_domain_attached: a_domain /= Void
		do
			source_domain := a_domain
		ensure
			source_domain_set: source_domain = a_domain
		end

feature{QL_DOMAIN_GENERATOR, QL_CRITERION} -- Setting

	set_used_in_domain_generator (a_domain_generator: QL_DOMAIN_GENERATOR)
			-- Set `used_in_domain_generator' with
			-- If `a_domain_generator' is Void, current `used_in_domain_generator' will be removed.
		do
			used_in_domain_generator := a_domain_generator
		ensure
			used_in_domain_generator_set: used_in_domain_generator = a_domain_generator
		end

feature -- Process

	process (a_criterion_visitor: QL_CRITERION_VISITOR)
			-- Process Current using `a_criterion_visitor'.
		require
			a_criterion_visitor_attached: a_criterion_visitor /= Void
		do
			a_criterion_visitor.process_criterion (Current)
		end

feature{NONE} -- Implementation

	setup_domain_generator (a_generator: QL_DOMAIN_GENERATOR; a_enable_fill_domain: BOOLEAN; a_apply_current: BOOLEAN)
			-- Setup `a_generator'.
			-- If `a_enable_fill_domain' is True, return a generator with `fill_domain_enabled' set to True.
			-- If `a_apply_current' is True, return a generator with `criterion' set to Current.
		require
			a_generator_attached: a_generator /= Void
		do
			if a_enable_fill_domain then
				a_generator.enable_fill_domain
			else
				a_generator.disable_fill_domain
			end
			if a_apply_current then
				a_generator.set_criterion (Current)
			end
		end

	item_type: QL_ITEM
			-- Anchor type
		do
		end

invariant
	intrinsic_domain_valid:
		has_intrinsic_domain implies (has_inclusive_intrinsic_domain or has_exclusive_intrinsic_domain)
	inclusive_exclusive_intrinsic_domain_exclusive:
		(has_inclusive_intrinsic_domain implies not has_exclusive_intrinsic_domain) and
		(has_exclusive_intrinsic_domain implies not has_inclusive_intrinsic_domain)

note
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

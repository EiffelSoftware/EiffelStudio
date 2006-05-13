indexing
	description: "Object to generate feature argument domains used in Eiffel query language"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_ARGUMENT_DOMAIN_GENERATOR

inherit
	QL_DOMAIN_GENERATOR
		redefine
			criterion,
			domain,
			item_type
		end

feature -- Access

	criterion: QL_ARGUMENT_CRITERION
			-- Criterion used when generating new items

	domain: QL_ARGUMENT_DOMAIN is
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
			Result := argument_scope
		ensure then
			good_result: Result = argument_scope
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
		local
			l_arguments: EIFFEL_LIST [TYPE_DEC_AS]
			l_type_dec_as: TYPE_DEC_AS
			l_argument: QL_ARGUMENT
			l_cnt: INTEGER
			i: INTEGER
			l_body_as: BODY_AS
		do
			if a_item.is_real_feature then
				l_body_as := a_item.e_feature.ast.body
				if l_body_as /= Void then
					l_arguments := l_body_as.arguments
					if l_arguments /= Void and then not l_arguments.is_empty then
						from
							l_arguments.start
						until
							l_arguments.after
						loop
							l_type_dec_as := l_arguments.item
							from
								i := 1
								l_cnt := l_type_dec_as.id_list.count
							until
								i > l_cnt
							loop
								create l_argument.make_with_ast (l_type_dec_as.item_name (i), l_type_dec_as, a_item)
								evaluate_item (l_argument)
								i := i + 1
							end
							l_arguments.forth
						end
					end
				end
			end
		end

	process_real_feature (a_item: QL_REAL_FEATURE) is
			-- Process `a_item'.
		do
			process_feature (a_item)
		end

	process_invariant (a_item: QL_INVARIANT) is
			-- Process `a_item'.
		do
			process_feature (a_item)
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
		end

feature{NONE} -- Implementation

	tautology_criterion: like criterion is
			-- Tautology criterion
		do
			create {QL_ARGUMENT_TRUE_CRI}Result
		end

	compiled_criterion: like criterion is
			-- A criterion that only compiled items can satisfy
		do
			create {QL_ARGUMENT_IS_COMPILED_CRI}Result
		end

feature{NONE} -- Observable

	item_type: QL_ARGUMENT;
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

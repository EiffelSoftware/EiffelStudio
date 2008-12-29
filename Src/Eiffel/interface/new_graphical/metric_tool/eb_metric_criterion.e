note
	description: "Criterion used in metric calculation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_CRITERION

inherit
	QL_SHARED_SCOPES

	QL_SHARED_NAMES

	QL_SHARED

	EB_METRIC_VISITABLE

	EB_METRIC_SHARED

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		require
			a_scope_attached: a_scope /= Void
			a_name_attached: a_name /= Void
		do
			set_name (a_name)
			set_scope (a_scope)
		end

feature -- Access

	scope: QL_SCOPE
			-- Scope of current criterion

	name: STRING
			-- Name of current criterion

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION
			-- QL_CRITERION representing current criterion			
			-- `a_scope' is only used in delayed criterion.
		require
			criterion_valid: is_valid
			a_scope_attached: a_scope /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.visitable_name (metric_names.string_general_as_lower (metric_names.t_criterion), name)
		end

feature -- Status report

	is_negation_used: BOOLEAN
			-- Is negation of current criterion used?

	is_normal_criterion: BOOLEAN
			-- Is current a normal criterion?
		do
		end

	is_text_criterion: BOOLEAN
			-- Is current a text criterion?
		do
		end

	is_path_criterion: BOOLEAN
			-- Is current a path criterion?
		do
		end

	is_caller_callee_criterion: BOOLEAN
			-- Is current criterion for caller/callee features?
		do
		end

	is_supplier_client_criterion: BOOLEAN
			-- Is current a criterion for supplier/client classe?
		do
		end

	is_value_criterion: BOOLEAN
			-- Is crrent a value criterion?
		do
		end

	is_domain_criterion: BOOLEAN
			-- Is current a domain criterion?
		do
		end

	is_and_criterion: BOOLEAN
			-- Is current an "AND" criterion?
		do
		end

	is_or_criterion: BOOLEAN
			-- Is current an "OR" criterion?
		do
		end

	is_nary_criterion: BOOLEAN
			-- Is current a nary criterion?
		do
		end

	is_name_valid: BOOLEAN
			-- Is `name' with `scope' valid?
		do
			Result := criterion_factory.has_criterion (name, scope)
		end

	is_parameter_valid: BOOLEAN
			-- Is parameters of current criterion valid?
		deferred
		end

	is_valid: BOOLEAN
			-- Is current valid?
		do
			Result := is_name_valid and then is_parameter_valid
		end

	is_external_command_criterion: BOOLEAN
			-- Is current an external command criterion?
		do
		end

feature -- Setting

	set_name (a_name: STRING)
			-- Set `name' with `a_name'.
		require
			a_name_attached: a_name /= Void
		do
			create name.make_from_string (a_name)
		ensure
			name_set: name /= Void and then name.is_equal (a_name)
		end

	set_scope (a_scope: like scope)
			-- Set `scope' with `a_scope'.
		require
			a_scope_attached: a_scope /= Void
		do
			scope := a_scope
		ensure
			scope_set: scope = a_scope
		end

	set_is_negation_used (b: BOOLEAN)
			-- Set `is_negation_used' with `b'.
		do
			is_negation_used := b
		ensure
			is_negation_used_set: is_negation_used = b
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_criterion (Current)
		end

invariant
	scope_attached: scope /= Void
	name_attached: name /= Void

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

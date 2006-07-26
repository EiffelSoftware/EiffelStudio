indexing
	description: "Criterion that used a domain and a boolean as arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CALLER_CALLEE_CRITERION

inherit
	EB_METRIC_DOMAIN_CRITERION
		redefine
			new_criterion,
			process,
			is_caller_criterion
		end

create
	make,
	make_with_setting

feature -- Access

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION is
			-- QL_CRITERION representing current criterion
		local
			l_criterion_factory: QL_CRITERION_FACTORY
		do
			l_criterion_factory := criterion_factory_table.item (a_scope)
			from
				domain.start
				Result := l_criterion_factory.criterion_with_name (name, [domain.item.domain (a_scope), only_current_version])
				domain.forth
			until
				domain.after
			loop
				Result := Result or l_criterion_factory.criterion_with_name (name, [domain.item.domain (a_scope), only_current_version])
				domain.forth
			end
			if is_negation_used then
				Result := not Result
			end
		end

feature -- Status report

	only_current_version: BOOLEAN
			-- Only current version?

	is_caller_criterion: BOOLEAN is True
			-- Is current a caller criterion?

feature -- Setting

	enable_only_current_version is
			-- Enable only current version.
		do
			only_current_version := True
		ensure
			only_current_version_enabled: only_current_version
		end

	disable_only_current_version is
			-- disable only current version.
		do
			only_current_version := False
		ensure
			only_current_version_disabled: not only_current_version
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_caller_criterion (Current)
		end

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

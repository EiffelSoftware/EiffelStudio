note
	description: "Value retriever to get a value for value criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_VALUE_RETRIEVER

inherit
	EB_METRIC_VISITABLE

feature -- Access

	value (a_ql_domain: QL_DOMAIN): DOUBLE
			-- Retrieved value
		require
			value_retrievable: is_retrievable
			a_ql_domain_attached: a_ql_domain /= Void
		deferred
		end

	value_with_domain (a_domain: EB_METRIC_DOMAIN): DOUBLE
			-- Retrieved value
		require
			value_retrievable: is_retrievable
			a_domain_attached: a_domain /= Void
		deferred
		end

feature -- Status report

	is_retrievable: BOOLEAN
			-- Is `value' retrievable?
		deferred
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_value_retriever (Current)
		end

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

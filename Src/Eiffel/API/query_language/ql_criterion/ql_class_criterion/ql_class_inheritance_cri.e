note
	description: "Object that represents a class inheritance (ancestor/descendant) criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_INHERITANCE_CRI

inherit
	QL_CLASS_HIERARCHY_CRI

feature{NONE} -- Initialization

	make (a_criterion_domain: like criterion_domain; a_relation_type: INTEGER)
			-- Initialize `criteiron_domain' with `a_criterion_domain'.			
		require
			a_criterion_domain_attached: a_criterion_domain /= Void
			a_relation_valid: is_inheritance_relation_valid (a_relation_type)
		do
			inheritance_relation := a_relation_type
			old_make (a_criterion_domain)
		ensure
			inheritance_relation_set: inheritance_relation = a_relation_type
			criterion_domain_set: criterion_domain = a_criterion_domain
		end

feature -- Access

	inheritance_relation: INTEGER;
			-- Type of inheritance

feature -- Status report

	is_inheritance_relation_valid (a_relation: INTEGER): BOOLEAN
			-- Is `a_relation' a valid ancestor relation?			
		deferred
		end

invariant
	inheritance_relation_valid: is_inheritance_relation_valid (inheritance_relation)

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

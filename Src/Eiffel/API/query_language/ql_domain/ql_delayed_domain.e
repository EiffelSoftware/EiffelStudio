indexing
	description: "[
					Object that represents a delayed domain used in Eiffel query language
		
					 A delayed domain means that `content' of the domain is not defined until a certain time.
					 For example, in query:
					     from "base" select class where (count feature from current_class > 10)
					 in this query, current_class is a delayed domain. Content of this delayed domain
					 is only meaningful when this query is executed. To be more detailed, when this query
					 executes, it will iterate all classes in group "base", and for every class, current_class
					 defines a domain which has one item which is the current iterated class in it.
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_DELAYED_DOMAIN

inherit
	QL_DOMAIN
		redefine
			is_delayed
		end

	QL_OBSERVER
		redefine
			update
		end

feature -- Status report

	is_delayed: BOOLEAN is True
			-- Is `Current' a delayed domain?
			-- A delayed domain means that `content' of the domain is not defined until a certain time.
			-- For example, in query:
			--     from "base" select class as current_class where (count feature from current_class > 10)
			-- in this query, current_class is a delayed domain. Content of this delayed domain
			-- is only meaningful when this query is executed. To be more detailed, when this query
			-- executes, it will iterate all classes in group "base", and for every class, current_class
			-- defines a domain which has one item which is the current iterated class in it.			

feature -- Notification

	update (a_observable: QL_DOMAIN_GENERATOR; a_data: like item_type) is
			-- Notification from `a_observable' indicating that `a_data' changed.
		local
			a_item: like item_type
		do
			wipe_out
			a_item ?= a_data.nearest_parent_with_scope (scope)
			if a_item /= Void then
				check a_item.is_valid_domain_item end
				content.extend (a_item)
			end
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

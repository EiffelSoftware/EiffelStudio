indexing
	description: "Application domain item"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_TARGET_DOMAIN_ITEM

inherit
	EB_METRIC_DOMAIN_ITEM
		redefine
			is_target_item,
			is_valid,
			string_representation
		end

	QL_SHARED
		undefine
			is_equal
		end

create
	make

feature -- Status report

	is_target_item: BOOLEAN is True
			-- Is current an application target item?

	is_valid: BOOLEAN is
			-- Does current represent a valid domain item?
		do
			Result := id.is_empty or else target_of_id (id) /= Void
		end

feature -- Access

	domain (a_scope: QL_SCOPE): QL_DOMAIN is
			-- New query lanaguage domain representing current item
		do
			if id.is_empty then
				Result := query_target_item_from_conf_target (universe.target).wrapped_domain
			else
				Result := query_target_item_from_conf_target (target_of_id (id)).wrapped_domain
			end
		end

	string_representation: STRING is
			-- Text of current item
		local
			l_target: CONF_TARGET
			l_target_name: STRING
		do
			if id.is_empty then
				Result := "Application target"
			else
				l_target := target_of_id (id)
				if l_target /= Void then
					Result := l_target.name
				else
					l_target_name := last_target_name
					if l_target_name /= Void and then not l_target_name.is_empty then
						Result := l_target_name
					else
						Result := Precursor
					end
				end
			end
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR) is
			-- Process current using `a_visitor'.
		do
			a_visitor.process_application_target_domain_item (Current)
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

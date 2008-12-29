note
	description: "Object that represents a constant value retriever"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CONSTANT_VALUE_RETRIEVER

inherit
	EB_METRIC_VALUE_RETRIEVER
		redefine
			is_retrievable,
			process
		end

	EB_METRIC_SHARED

create
	default_create,
	make

feature{NONE} -- Initialization

	make (a_value: like value)
			-- Initialize `value' with `a_value'.
		do
			set_value (a_value)
		end

feature -- Access

	value (a_ql_domain: QL_DOMAIN): DOUBLE
			-- Retrieved value
		do
			Result := value_internal
		end

	value_with_domain (a_domain: EB_METRIC_DOMAIN): DOUBLE
			-- Retrieved value
		do
			Result := value_internal
		end

	visitable_name: STRING_GENERAL
			-- Name of current visitable item
		do
			Result := metric_names.l_constant_value
		end

	value_internal: DOUBLE
			-- Value

feature -- Status report

	is_retrievable: BOOLEAN = True
			-- Is `value' retrievable?

feature -- Setting

	set_value (a_value: like value)
			-- Set `value' with `a_value'.
		do
			value_internal := a_value
		ensure
			value_set: value_internal = a_value
		end

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_constant_value_retriever (Current)
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

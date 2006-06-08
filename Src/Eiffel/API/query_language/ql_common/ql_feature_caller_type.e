indexing
	description: "Object that represents type of feature caller"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_FEATURE_CALLER_TYPE

inherit
	QL_CONSTANT
		redefine
			name
		end

create
	make

feature{NONE} -- Initialization

	make (a_name: STRING; a_type: INTEGER_8) is
			-- Initialize `type' with `a_type'
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_type_valid: valid_type (a_type)
		do
			create name.make_from_string (a_name)
			type := a_type
		ensure
			name_attached: name /= Void
			name_correct: name.is_equal (a_name)
			type_set: type = a_type
		end

feature -- Access

	name: STRING
			-- Name of current caller

	type: INTEGER_8
			-- Type indicator

feature -- Status report

	valid_type (a_type: INTEGER_8): BOOLEAN is
			-- Is `a_type' valid?
		do
			Result := a_type = {DEPEND_UNIT}.is_in_assignment_flag or
					 a_type = {DEPEND_UNIT}.is_in_creation_flag or
					 a_type = 0
		ensure
			good_result:
				Result implies (
					 a_type = {DEPEND_UNIT}.is_in_assignment_flag or
					 a_type = {DEPEND_UNIT}.is_in_creation_flag or
					 a_type = 0)
		end

invariant
	type_valid: valid_type (type)

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

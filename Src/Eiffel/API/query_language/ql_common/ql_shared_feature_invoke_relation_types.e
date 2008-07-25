indexing
	description: "Feature caller types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_SHARED_FEATURE_INVOKE_RELATION_TYPES

feature -- Status_report

	is_caller_type_valid (a_caller_type: NATURAL_16): BOOLEAN is
			-- Is `a_caller_type' a valid caller type?
		do
			Result := a_caller_type = normal_caller_type or
					  a_caller_type = assigner_caller_type or
					  a_caller_type = creator_caller_type
		end

	is_callee_type_valid (a_callee_type: NATURAL_16): BOOLEAN is
			-- Is `a_callee_type' a valid callee type?
		do
			Result := a_callee_type = normal_callee_type or
					  a_callee_type = assigner_callee_type or
					  a_callee_type = creator_callee_type
		end

feature -- Access

	normal_caller_type, normal_callee_type: NATURAL_16 is
			-- Normal caller type
		do
			Result := 0
		end

	assigner_caller_type, assigner_callee_type: NATURAL_16 is
			-- Assigner caller type
		do
			Result := {DEPEND_UNIT}.is_in_assignment_flag
		end

	creator_caller_type, creator_callee_type: NATURAL_16 is
		 	-- Creator caller
		do
			Result := {DEPEND_UNIT}.is_in_creation_flag
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

indexing
	description: "Object that represents a class criterion which evaluates a number"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_NUM_CRI

inherit
	QL_CLASS_CRITERION

create
	make

feature{NONE} -- Initialization

	make (a_number_info: like number_info) is
			-- Initialize `number_info' with `a_number_info'.
		require
			a_number_info_attached: a_number_info /= Void
		do
			number_info := a_number_info
		ensure
			number_info_set: number_info = a_number_info
		end

feature -- Access

	number_info: QL_BOOL_NUM_BIN_INFO
			-- Number infomation which current uses to evaluate

feature -- Status report

	require_compiled: BOOLEAN is
			-- Does current criterion require a compiled item?
		do
			Result := True
			fixme ("Implement `require_compiled' in `number_info'.")
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN is
			-- Evaluate `a_item'.
		do
			if number_info.evaluatable (a_item) then
				number_info.evaluate (a_item)
				Result := number_info.value
			end
		end

invariant
	number_info_attached: number_info /= Void

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

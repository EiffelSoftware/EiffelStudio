indexing
	description: "[
			General response to a request from ised to workbench.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class RQST_HANDLER 

inherit

	IPC_SHARED

feature 

	execute is
			-- Execute Current action as 
			-- requested by ised.
		deferred
		end;

	request_type: INTEGER;
			-- Constant from IPC_SHARED defining current

	detail: STRING;
			-- Detail of Current. Can be a job number, a position...

feature -- Eiffel/C interface.

	pass_addresses is
			-- Pass addresses from Current to C.
		do
			rqst_handler_to_c (Current, request_type, $set)
		end;

	set (s: like detail) is
			-- Assign `s' to `detail'
		do
			detail := s
		end;

feature {NONE} -- external

	rqst_handler_to_c (a: like Current; i: like request_type; f: POINTER)  is
			-- Pass addresses to C.
		external
			"C"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

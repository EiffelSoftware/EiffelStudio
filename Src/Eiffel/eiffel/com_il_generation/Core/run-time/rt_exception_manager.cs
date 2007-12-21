/*
indexing
	description: "Interface for Eiffel exception manager."
	date: "$Date: 2007-03-20 19:44:05 +0800 (Tue, 20 Mar 2007) $"
	revision: "$Revision: 67392 $"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt"
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

*/


using System;
using System.Text;
using EiffelSoftware.Runtime.CA;

namespace EiffelSoftware.Runtime
{
    public interface RT_EXCEPTION_MANAGER
    {
        // Raise exception of `e_code'
        void internal_raise (int e_code, String msg);

        // Raise OLD_VIOLATION with original of ex.
        void internal_raise_old(Exception ex);

        // Implement ISE_RUNTIME.last_exception for backward compatibility.
        Exception last_exception();

        // Compute last exception, construct exception chain from the received exception
        // at beginning of catch block.
        Exception compute_last_exception(Exception ex);

        // This routine is to keep the same call depth as `raise' in EXCEPTION
        void throw_last_exception(Exception ex, bool for_once);
        
        // Exception codes
        // We do it by interface, so that the physical codes don't duplicate.
	    int Void_call_target();
        int No_more_memory();
        int Precondition();
        int Postcondition();
        int Floating_point_exception();
        int Class_invariant();
        int Check_instruction();
        int Routine_failure();
        int Incorrect_inspect_value();
        int Loop_variant();
        int Loop_invariant();
        int Signal_exception();
        int Rescue_exception();
        int External_exception();
        int Void_assigned_to_expanded();
        int Io_exception();
        int Operating_system_exception();
        int Retrieve_exception();   
        int Developer_exception();
        int Runtime_io_exception();
        int Com_exception();
        int Runtime_check_exception();
        int old_exception();
        int serialization_exception();
    }
}

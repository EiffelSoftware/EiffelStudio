/*
	description:	"SCOOP support."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2010, Eiffel Software."
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"Commercial license is available at http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Runtime.
			
			Eiffel Software's Runtime is free software; you can
			redistribute it and/or modify it under the terms of the
			GNU General Public License as published by the Free
			Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Runtime is distributed in the hope
			that it will be useful,	but WITHOUT ANY WARRANTY;
			without even the implied warranty of MERCHANTABILITY
			or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Runtime; if not,
			write to the Free Software Foundation, Inc.,
			51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

#ifndef _eif_scoop_h_
#define _eif_scoop_h_

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
	EIF_REFERENCE     target;       /* Target of a call */
	BODY_INDEX        body_index;   /* Routine to be called */
	EIF_NATURAL_32    count;        /* Number of arguments excluding target object */
	EIF_TYPED_VALUE * result;       /* Address of a result for queries */
	EIF_TYPED_VALUE   argument [1]; /* Arguments excluding target object */
} call_data;

rt_public void eif_log_call (int static_type_id, int feature_id, uint16 current_pid, call_data * data);
rt_public void eif_log_callp (int origin, int offset, uint16 current_pid, call_data * data);

#ifdef __cplusplus
}

#endif

#endif	/* _eif_scoop_h_ */


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
			 Telephone /R805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

/*
doc:<file name="scoop.c" header="eif_scoop.h" version="$Id$" summary="SCOOP support.">
*/

#include "rt_assert.h"
#include "rt_globals.h"
#include "rt_struct.h"
#include "rt_wbench.h"


#ifdef WORKBENCH
rt_public void eif_log_call (int s, int f, EIF_SCP_PID p, call_data * a)
{
	BODY_INDEX body_id;
	EIF_REFERENCE t = eif_access (a -> target);

	CHECK("Target attached", t);
	CBodyId(body_id,Routids(s)[f],Dtype(t));
	a -> body_index = body_id;
	RTS_TCB(scoop_task_add_command,p,RTS_PID(t),body_id,a,EIFNULL);
}
 
rt_public void eif_log_callp (int s, int f, EIF_SCP_PID p, call_data * a)
{
	BODY_INDEX body_id;
	EIF_REFERENCE t = eif_access (a -> target);

	CHECK("Target attached", t);
	body_id = desc_tab[s][Dtype(t)][f].body_index;
	a -> body_index = body_id;
	RTS_TCB(scoop_task_add_command,p,RTS_PID(t),body_id,a,EIFNULL);
}
 
rt_public void eif_try_call (call_data * a)
{
	uint32            pid = 0; /* Pattern id of the frozen feature */
	EIF_NATURAL_32    i;
	EIF_NATURAL_32    n;
	BODY_INDEX        body_id = a -> body_index;
	EIF_TYPED_VALUE * v;

		/* Push arguments to the evaluation stack */
	for (n = a -> count, i = 0; i < n; i++) {
		v = iget ();
		* v = a -> argument [i];
		if (v -> type == SK_REF) {
			v -> it_r = eif_access (v -> it_r);
		}
	}
		/* Push current to the evaluation stack */
	v = iget ();
	v -> it_r = eif_access (a -> target);
	v -> type = SK_REF;
		/* Make a call */
	if (egc_frozen [body_id]) {		/* We are below zero Celsius, i.e. ice */
		pid = (uint32) FPatId(body_id);
		(pattern[pid].toc)(egc_frozen[body_id]); /* Call pattern */
	} else {
		/* The proper way to start the interpretation of a melted feature is to call `xinterp'
		 * in order to initialize the calling context (which is not done by `interpret').
		 * `tagval' will therefore be set, but we have to resynchronize the registers anyway.
		 */
		xinterp(MTC melt[body_id], 0);
	}
		/* Save result of a call */
	v = a -> result;
	if (v) {
		* v = * opop ();
	}
}
#endif

/*
doc:</file>
*/

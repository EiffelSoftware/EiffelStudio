/*
	description:	"Definitions for a set of EIF_SCP_PID identifiers."
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 2014-2015, Eiffel Software."
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
*/

#ifndef _rt_identifier_set_h_
#define _rt_identifier_set_h_

#include "eif_portable.h"
#include "eif_posix_threads.h"

#ifdef __cplusplus
extern "C" {
#endif

/*
doc:	<struct name="rt_identifier_set" export="shared">
doc:		<summary> A bounded synchronized queue for SCOOP processor identifiers (PIDs). </summary>
doc:		<field name="area" type="EIF_SCP_PID*"> A pointer to an array containing the elements. </field>
doc:		<field name="capacity" type="size_t"> The total capacity of the 'area' array. </field>
doc:		<field name="count" type="size_t"> The number of valid PIDs in the queue. </field>
doc:		<field name="start" type="size_t"> The index to the first PID in the queue. </field>
doc:		<field name="lock" type="EIF_MUTEX_TYPE*"> The mutex used to protect the queue from concurrent access. </field>
doc:		<field name="is_empty_condition" type="EIF_COND_TYPE*"> The condition variable used by consumers when the queue is empty. </field>
doc:	</struct>
*/
struct rt_identifier_set {
	EIF_SCP_PID* area;
	size_t capacity;
	size_t count;
	size_t start;

	EIF_MUTEX_TYPE* lock;
	EIF_COND_TYPE* is_empty_condition;
};

extern int rt_identifier_set_init (struct rt_identifier_set* self, size_t a_capacity);
extern void rt_identifier_set_deinit (struct rt_identifier_set* self);
extern void rt_identifier_set_extend (struct rt_identifier_set* self, EIF_SCP_PID pid);
extern void rt_identifier_set_consume (struct rt_identifier_set* self, EIF_SCP_PID* result);
extern EIF_BOOLEAN rt_identifier_set_try_consume (struct rt_identifier_set* self, EIF_SCP_PID* result);

#ifdef __cplusplus
}
#endif

#endif /* _rt_identifier_set_h_ */

/*
	description:	"Separate types processing."
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

#ifndef _eif_separate_h_
#define _eif_separate_h_

/*
 * Object status:
 * EIF_IS_DIFFERENT_PROCESSOR (o1, o2) - tells if o1 and o2 run on different processors
 */
#define EIF_IS_DIFFERENT_PROCESSOR(o1,o2) EIF_FALSE

/*
 * Processor:
 * RTS_PA(o) - associate a fresh processor with an object o
 */
#define RTS_PA(o)

/*
 * Request chain:
 * RTS_RC(p)   - create a request chain for the processor identified by object p
 * RTS_RD(p)   - delete a request chain for the processor identified by object p
 * RTS_RS(p,s) - add a supplier s to the request chain of the processor identified by object p
 * RTS_RW(p)   - wait until all the suppliers are ready in the request chain of the processor identified by object p
 * The only valid sequence of calls is
 *      RTS_RC (RTS_RS)* [RTS_RW] RTS_RD
 */
#define RTS_RC(p)
#define RTS_RD(p)
#define RTS_RS(p,s)
#define RTS_RW(p)

/*
 * Separate call:
 * RTS_CF(c,t,f,a,r) - call a function with an address f on a target t with current object c and arguments a and result r
 * RTS_CP(c,t,f,a)   - call a procedure with an address f on a target t with current object c and arguments a
 */
#define RTS_CF(c,t,f,a,r)
#define RTS_CP(c,t,f,a)

/*
 * Separate call arguments:
 * RTS_AC(n,t,a) - allocate container a that can hold n arguments for target t
 * RTS_AA(v,n,a) - register argument v corresponding to field f of type t at position n in a
 */
#define RTS_AC(n,t,a)
#define RTS_AA(v,f,t,n,a)

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
}

#endif

#endif	/* _eif_separate_h_ */


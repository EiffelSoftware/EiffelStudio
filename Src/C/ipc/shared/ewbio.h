/*
	description: "[
			Fixed communication file descriptors used by processes who (sic)
			wish to have a direct pipeline (sic) with ised.
			]"
	date:		"$Date$"
	revision:	"$Revision$"
	copyright:	"Copyright (c) 1985-2006, Eiffel Software."
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

#ifndef _ewbio_h_
#define _ewbio_h_

/* The following two file descriptors, also known as ewbin and ewbout are
 * arbitrary entries in the file table which are expected to be pre-set when
 * the aplication wants to speak to its parent.
 * It is REALLY important to have the file number for ewbout lesser than the
 * file number used by ewbin, due to the way pipes are opened in the parent.
 * NOTE: do not use low-level numbers like 4/3, since some shells use those
 * descriptors to initialize non-standard redirections (ksh for instance has
 * file #3 redirected on /dev/null and #4 is also defined, although I do not
 * know what for--RAM).
 */

#define EWBIN	8		/* Process reads from here */
#define EWBOUT	7		/* And writes to there */

#endif


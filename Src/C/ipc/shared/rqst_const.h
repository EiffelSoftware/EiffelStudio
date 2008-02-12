/*
	description: "Constants shared with class REQUEST_CONST on the Eiffel side."
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

#ifndef _rqst_const_h_
#define _rqst_const_h_

/* Request types */
/* Don't forget to update u_Request array in rqst_idrs.c. */
#define EIF_OPAQUE			1		/* Opaque data request */
#define ACKNLGE				2		/* Acknowledgment (positive/negative) */
#define TRANSFER			3		/* Data transfer via daemon */
#define HELLO				4		/* Application's handshake with ewb */
#define STOPPED				5		/* Stop notification from app -> ewb */
#define NOTIFIED			6		/* Notification/event data request (no answer is needed) */
#define INSPECT				7		/* Object inspection */
#define DUMP_THREADS		8		/* Send the threads */
#define DUMP_STACK			9		/* A general stack dump request */
#define DUMP_VARIABLES		10		/* Send the locals and the arguments of a feature on the call stack */
#define DUMPED				11		/* A dumped stack item */
#define MOVE				12		/* Change active routine pointer */
#define BREAK				13		/* Add/delete breakpoint */
#define RESUME				14		/* Resume execution */
#define QUIT				15		/* Application must die immediately */
#define CMD					16		/* Run a shell command (for ised) */
#define APPLICATION			17		/* Start up application (for ised) */
#define KPALIVE				18		/* Dummy request to keep connection alive */
#define ASYNCMD				19		/* Run command asynchronously */
#define ASYNACK				20		/* Status of the asynchronous job */
#define DEAD				21		/* Application is dead */
#define LOAD				22		/* Load byte code information */
#define BYTECODE			23		/* Byte code transfer */
#define KILL				24		/* Kill application asynchronously */
#define ADOPT				25		/* Adopt object */
#define ACCESS				26		/* Access object through hector */
#define WEAN				27		/* Wean adopted object */
#define ONCE				28		/* Once routines inspection */
#define EWB_INTERRUPT		29		/* Debugger asking interruption of application*/
#define APP_INTERRUPT		30		/* Application wondering if it has to stop */
#define INTERRUPT_OK		31		/* Application must stop its execution */
#define INTERRUPT_NO		32		/* Application can resume execution */
#define SP_LOWER			33		/* Bounds for special objects inspection */
#define METAMORPHOSE		34		/* Convert the top-level item in the operational stack from a basic type to a reference */
#define APP_INTERRUPT_FLAG	35		/* Application sends the address of its interruption flag to daemon */
#define EWB_NEWBREAKPOINT	36		/* Application sends the address of its interruption flag to daemon */
#define MODIFY_LOCAL		37		/* `ec' asks the æpplication to change the value of a local variable */
#define MODIFY_ATTR			38		/* `ec' asks the application to change the value of an object attribute */
#define DYNAMIC_EVAL		39		/* `ec' asks the application to execute a given feature on a given object */
#define APPLICATION_CWD		40		/* Send current directory to launch application */
#define OVERFLOW_DETECT		41		/* Specify the stack overflow management: set a depth at which the application raises an exception */
#define CHANGE_THREAD		42		/* Thread id used for inspection and other */

#define EWB_SET_ASSERTION_CHECK 43	/* Change assertion checking on the application being debugged */
#define CLOSE_DBG 			44		/* Close ecdbgd */
#define SET_IPC_PARAM 		45		/* set IPC parameters value (pid, timeout in seconds, ...) */
#define CLEAR_BREAKPOINTS 	46		/* Clear breakpoints table */
#define LAST_EXCEPTION	 	47		/* Get last_exception object */
#define APPLICATION_ENV		48		/* Send current env to launch application */
#define NEW_INSTANCE		49		/* Create new instance of class */
#define RT_OPERATION		50		/* Invoke an `RT_EXTENSION' operation */

#define MAX_REQUEST_TYPE 	50		/* To update with new value of max request type. */


/* Acknowledgments codes */
#define AK_OK			0       /* Everything is ok */
#define AK_ERROR		1       /* General negative acknowledgment */
#define AK_PROTO		2		/* Protocol inconsistency (should not happen) */

/* Inspect types */
#define IN_ADDRESS		0		/* Object at given address */
#define IN_LOCAL		1		/* Local variable by number */
#define IN_ARG			2		/* Argument by number */
#define IN_CURRENT		3		/* Current */
#define IN_RESULT		4		/* Result */
#define IN_H_ADDR		5		/* Object at given hector address */
#define IN_BIT_ADDR		6		/* Bit object at given address */
#define IN_STRING_ADDR	7		/* String object at given address */

/* Once inspection types */
#define OUT_CALLED				0	/* Check whether once routine has been called         */
#define OUT_INDEX				2	/* Ask for ONCE index for BODY_INDEX                  */
#define OUT_DATA_PER_THREAD		3	/* Ask for ONCE data .. ie: status, result, exception */
#define OUT_DATA_PER_PROCESS	4	/* Ask for ONCE data .. ie: status, result, exception */

#define OUT_ONCE_PER_THREAD		0 /* Asked Once is per thread */
#define OUT_ONCE_PER_PROCESS	1 /* Asked Once is per process */

/* RT_EXTENSION access constants related to IPC `RT_OPERATION' request */
#define RQST_RTOP_OPTION				0
#define RQST_RTOP_EXEC_REPLAY			1
#define RQST_RTOP_DUMP_OBJECT			2
#define RQST_RTOP_OBJECT_STORAGE_SAVE	3
#define RQST_RTOP_OBJECT_STORAGE_LOAD	4

/* Special object inspection */
#define DEFAULT_SLICE	50		/* Default maximum number of items to be sent */

#endif


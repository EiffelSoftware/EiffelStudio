/*

 #####    ####    ####    #####           ####    ####   #    #   ####    #####
 #    #  #    #  #          #            #    #  #    #  ##   #  #          #
 #    #  #    #   ####      #            #       #    #  # #  #   ####      #
 #####   #  # #       #     #            #       #    #  #  # #       #     #
 #   #   #   #   #    #     #            #    #  #    #  #   ##  #    #     #
 #    #   ### #   ####      #   #######   ####    ####   #    #   ####      #

	Constants shared with class REQUEST_CONST on the Eiffel side.
*/

#ifndef _rqst_const_h_
#define _rqst_const_h_

/* Request types */
#define EIF_OPAQUE		1		/* Opaque data request */
#define ACKNLGE			2		/* Acknowledgment (positive/negative) */
#define TRANSFER		3		/* Data transfer via daemon */
#define HELLO			4		/* Application's handshake with ewb */
#define STOPPED			5		/* Stop notification from app -> ewb */
#define INSPECT			6		/* Object inspection */
#define DUMP			7		/* A general stack dump request */
#define DUMPED			8		/* A dumped stack item */
#define MOVE			9		/* Change active routine pointer */
#define BREAK			10		/* Add/delete breakpoint */
#define RESUME			11		/* Resume execution */
#define QUIT			12		/* Application must die immediately */
#define CMD				13		/* Run a shell command (for ised) */
#define APPLICATION		14		/* Start up application (for ised) */
#define KPALIVE			15		/* Dummy request to keep connection alive */
#define ASYNCMD			16		/* Run command asynchronously */
#define ASYNACK			17		/* Status of the asynchronous job */
#define DEAD			18		/* Application is dead */
#define LOAD			19		/* Load byte code information */
#define BYTECODE		20		/* Byte code transfer */
#define KILL			21		/* Kill application asynchronously */
#define ADOPT			22		/* Adopt object */
#define ACCESS			23		/* Access object through hector */
#define WEAN			24		/* Wean adopted object */
#define ONCE			25		/* Once routines inspection */
#define EWB_INTERRUPT	26		/* Debugger asking interruption of application*/
#define APP_INTERRUPT	27		/* Application wondering if it has to stop */
#define INTERRUPT_OK	28		/* Application must stop its execution */
#define INTERRUPT_NO	29		/* Application can resume execution */
#define SP_LOWER		30		/* Bounds for special objects inspection */
#define METAMORPHOSE		31		/* Convert the top-level item in the operational stack from a basic type to a reference */
#define APP_INTERRUPT_FLAG	32	/* Application sends the address of its interruption flag to daemon */
#define EWB_NEWBREAKPOINT	33	/* Application sends the address of its interruption flag to daemon */
#define MODIFY_LOCAL	34		/* `ec' asks the æpplication to change the value of a local variable */
#define MODIFY_ATTR		35		/* `ec' asks the application to change the value of an object attribute */
#define DYNAMIC_EVAL	36		/* `ec' asks the application to execute a given feature on a given object */
#define DUMP_VARIABLES	37		/* Send the locals and the arguments of a feature on the call stack */
#define APPLICATION_CWD	38		/* Send current directory to launch application */

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
#define OUT_CALLED		0		/* Check whether once routine has been called */
#define OUT_RESULT		1		/* Ask for result of already called once func */

/* Special object inspection */
#define DEFAULT_SLICE	50		/* Default maximum number of items to be sent */

#endif


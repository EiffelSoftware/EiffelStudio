/*

 #####   ######   ####   #    #  ######   ####    #####          #    #
 #    #  #       #    #  #    #  #       #          #            #    #
 #    #  #####   #    #  #    #  #####    ####      #            ######
 #####   #       #  # #  #    #  #            #     #     ###    #    #
 #   #   #       #   #   #    #  #       #    #     #     ###    #    #
 #    #  ######   ### #   ####   ######   ####      #     ###    #    #

*/

#ifndef _request_h_
#define _request_h_

#include "rqst_const.h"
#include "stack.h"

/*
 * Data structures used by the requests
 */

typedef struct {
	int op_type;
	int op_cmd;
	long op_size;
} Opaque;

#define op_first	op_type
#define op_second	op_cmd
#define op_third	op_size

/* Acknowledgment codes and object inspection codes defined in rqst_const.h */

typedef struct {			/* Acknowledgment */
	int ak_type;			/* General type of acknowledgment */
} Acknlge;

typedef struct {			/* Position in program execution flow */
	char *wh_name;			/* Feature name */
	long wh_obj;			/* Object address (can't use (char *) with XDR) */
	int wh_origin;			/* Where feature comes from */
	int wh_type;			/* Dynamic type of Current */
	long wh_offset;			/* Offset within byte code (-1 if none) */
} Where;

typedef struct {			/* Stopping notification */
	Where st_where;			/* Where we are now */
	int st_why;				/* Why did we stop? */
	char *st_tag;			/* Exception tag, if appropriate */
} Stop;

typedef struct dump Dump;	/* Structure returned by dumps */

/* General protocol request structure. Each time a new structure is added, we
 * need to write an XDR serializing routine for it, and we have to update the
 * XDR routine for the following request.
 */

/* Request types with specific information carried in structure:
 *	OPAQUE		1		Opaque data request
 *	ACKNLGE		2		Acknowledgment (positive/negative)
 *	TRANSFER	3		Data transfer via daemon
 *	HELLO		4		Application's handshake with ewb
 *	STOPPED		5		Stop notification from app -> ewb
 *	INSPECT		6		Object inspection
 *	DUMP		7		A general stack dump request
 *	DUMPED		8		A dumped stack item
 *	MOVE		9		Change active routine pointer
 *	BREAK		10		Add/delete breakpoint
 *	RESUME		11		Resume execution
 *	QUIT		12		Application must die immediately
 *	CMD			13		Run a shell command (for ised)
 *	APPLICATION	14		Start up application (for ised)
 *	KPALIVE		15		Dummy request to keep connection alive
 *	ASYNCMD		16		Run command asynchronously
 *	ASYNACK		17		Status of the asynchronous job
 */

typedef struct {			/* General client request format */
	int rq_type;			/* Union's discriminent */
	union {
		Acknlge rqu_ack;		/* Acknowledgment (positive/negative) */
		Dump rqu_dump;			/* A dumped stack item */
		Opaque rqu_opaque;		/* Opaque parameters for request */
		Stop rqu_stop;			/* Stop information */
		Where rqu_where;		/* Position within program */
	} rqu;
} Request;

#define rq_ack			rqu.rqu_ack
#define rq_dump			rqu.rqu_dump
#define rq_opaque		rqu.rqu_opaque
#define rq_stop			rqu.rqu_stop
#define rq_where		rqu.rqu_where

#endif

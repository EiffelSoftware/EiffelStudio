/*
 * eif_logging.h:	Eiffel Logging Cluster Platform dependant stub library
 *
 * Revision:		$Revision$
 * Date:			$Date$
 *
 * Copyright:		(C) 2010 by ITPassion Ltd, Eiffel Software and others
 */

#ifndef eif_logging_h
#define eif_logging_h

/* System include files */
#include <eif_config.h>
#include <eif_macros.h>

#ifdef EIF_WINDOWS
# include "eif_eventlog_messages.h"

	/* Log Options */
# define EIF_LOGGING_PID			0
# define EIF_LOGGING_CONS			0
# define EIF_LOGGING_ODELAY			0
# define EIF_LOGGING_NDELAY			0
# define EIF_LOGGING_NOWAIT			0

	/* Log facilities */
# define EIF_LOGGING_KERN			0
# define EIF_LOGGING_USER			0
# define EIF_LOGGING_MAIL			0
# define EIF_LOGGING_DAEMON			0
# define EIF_LOGGING_AUTH			0
# define EIF_LOGGING_SYSLOG			0
# define EIF_LOGGING_LPR			0
# define EIF_LOGGING_NEWS			0
# define EIF_LOGGING_UUCP			0
# define EIF_LOGGING_CRON			0
# define EIF_LOGGING_AUTHPRIV		0
# define EIF_LOGGING_FTP			0
# define EIF_LOGGING_LOCAL0			0
# define EIF_LOGGING_LOCAL1			0
# define EIF_LOGGING_LOCAL2			0
# define EIF_LOGGING_LOCAL3			0
# define EIF_LOGGING_LOCAL4			0
# define EIF_LOGGING_LOCAL5			0
# define EIF_LOGGING_LOCAL6			0
# define EIF_LOGGING_LOCAL7			0
	/* See LOG_FACILITY_CONST for details */
# define EIF_LOGGING_APP_EVENT_LOG	1
# define EIF_LOGGING_SEC_EVENT_LOG	2
# define EIF_LOGGING_SYS_EVENT_LOG	4


extern void eif_logging_close_log(void);
extern EIF_BOOLEAN eif_logging_open_log(const char *id, int op, int fa);
extern void eif_logging_write_log(int priority, const char *msg);

/* Probably more Unix derivatives deserve to be included here... */

#elif defined(EIF_OS_LINUX)
# include <syslog.h>

	/* Log Priorities */
# define EIF_LOGGING_EMERGENCY		LOG_EMERG
# define EIF_LOGGING_ALERT			LOG_ALERT
# define EIF_LOGGING_CRITICAL		LOG_CRIT
# define EIF_LOGGING_ERROR			LOG_ERR
# define EIF_LOGGING_WARNING		LOG_WARNING
# define EIF_LOGGING_NOTICE			LOG_NOTICE
# define EIF_LOGGING_INFORMATION	LOG_INFO
# define EIF_LOGGING_DEBUG			LOG_DEBUG

	/* Log Options */
# define EIF_LOGGING_PID			LOG_PID
# define EIF_LOGGING_CONS			LOG_CONS
# define EIF_LOGGING_ODELAY			LOG_ODELAY
# define EIF_LOGGING_NDELAY			LOG_NDELAY
# define EIF_LOGGING_NOWAIT			LOG_NOWAIT

	/* Log facilities */
# define EIF_LOGGING_KERN			LOG_KERN
# define EIF_LOGGING_USER			LOG_USER
# define EIF_LOGGING_MAIL			LOG_MAIL
# define EIF_LOGGING_DAEMON			LOG_DAEMON
# define EIF_LOGGING_AUTH			LOG_AUTH
# define EIF_LOGGING_SYSLOG			LOG_SYSLOG
# define EIF_LOGGING_LPR			LOG_LPR
# define EIF_LOGGING_NEWS			LOG_NEWS
# define EIF_LOGGING_UUCP			LOG_UUCP
# define EIF_LOGGING_CRON			LOG_CRON
# define EIF_LOGGING_AUTHPRIV		LOG_AUTHPRIV
# define EIF_LOGGING_FTP			LOG_FTP
# define EIF_LOGGING_LOCAL0			LOG_LOCAL0
# define EIF_LOGGING_LOCAL1			LOG_LOCAL1
# define EIF_LOGGING_LOCAL2			LOG_LOCAL2
# define EIF_LOGGING_LOCAL3			LOG_LOCAL3
# define EIF_LOGGING_LOCAL4			LOG_LOCAL4
# define EIF_LOGGING_LOCAL5			LOG_LOCAL5
# define EIF_LOGGING_LOCAL6			LOG_LOCAL6
# define EIF_LOGGING_LOCAL7			LOG_LOCAL7

extern void eif_logging_close_log(void);
extern EIF_BOOLEAN eif_logging_open_log(const char *id, int op, int fa);
extern void eif_logging_write_log(int priority, const char *msg);

#elif defined(EIF_UNIX)
#error "This is unix!"
#else
#error "Your platform is not supported, sofar!"
#endif

#endif /* eif_logging_h */

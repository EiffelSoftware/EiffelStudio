#ifndef _CONCURRENT_ERRMSG_
#define _CONCURRENT_ERRMSG_

#ifdef __cplusplus
extern "C" {
#endif
		
/* the following several macros are used to display request info */
#define GET_CMD_MSG1	"\n%d/%d Got command %s "
#define GET_CMD_MSG2	" OID:%d, CLASS:%s, FEATURE:%s, ACK:%d "
#define GET_CMD_MSG3	" PARA#:%d\n"
#define GET_DATA_MSG1	"%d/%d Para type: %d, len: %d, "


/* In the following, we classify the error messages into 4 catalogues:
 * o Prompt message
 * o Implementation Error Message
 *   This kind of error messages are most likely(even not surely) caused 
 *   by our implementation, so they can be used to debug concurrent 
 *   Eiffel's C-library.
 * o Application Error Message
 *   This kind of error messages are caused by user's application or 
 *   configure file.
 * o General Error Message
 *   This kind of error messages can be caused by both debug(s) in 
 *   concurrent Eiffel's C-library and user's application.
*/

/*--------------------------------------------------------*/
/*     Prompt Message From SERVER.c                       */
/*--------------------------------------------------------*/

#define CURPROMPT9	" RESERVE_SEP_OBJ "
#define CURPROMPT10	" ACKNOWLEDGE_TO_RESERVE_SEP_OBJ "	
#define CURPROMPT11	" REJECT_TO_RESERVE_SEP_OBJ "	
#define CURPROMPT12	" REGISTER_FIRST_FROM_PARENT "	
#define CURPROMPT13	" REGISTER "	
#define CURPROMPT14	" REGISTER_ACK "	
#define CURPROMPT15	" REGISTER_ACK_WITH_ROOT_OID "	
#define CURPROMPT16	" UNREGISTER "	
#define CURPROMPT17	" RELEASE "	
#define CURPROMPT18	" QUERY_RESULT "	
#define CURPROMPT19	" ACKNOWLEDGE_FOR_PROCEDURE "	
#define CURPROMPT20	" MIDDLE_RESULT_OF_IMPORTATION "	
#define CURPROMPT21	" CREATE_SEP_OBJ "	
#define CURPROMPT22	" CREATION_FEATURE_PARAMETER "	
#define CURPROMPT23	" END_OF_REQUEST "	
#define CURPROMPT24	" CONNECTION_FROM_SEP_CHILD "
#define CURPROMPT25	" INFORMATION_FROM_SEP_CHILD "
#define CURPROMPT26	" MESSAGE_ACK "
#define CURPROMPT27	" EXECUTE_PROCEDURE "
#define CURPROMPT28	" EXECUTE_QUERY "
#define CURPROMPT29	" QUERY_RESULT_ACK "
#define CURPROMPT30	" REPORT_ERROR "
#define CURPROMPT31	" STOP_EXECUTION "
#define CURPROMPT32	" START_SEP_OBJ_OK "
#define CURPROMPT33	" EXIT_OK "
#define CURPROMPT34	" NOT_DEFINED "
#define CURPROMPT35	" UNKNOWN COMMAND CODE(%d) "
#define CURPROMPT36	"\n*************** Error Message of Running Concurrent Application ***************\n"
#define CURPROMPT37	"\n*******************************************************************************\n"

/*--------------------------------------------------------*/
/*     Error Message From SERVER.c                        */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR1	"    Expect REGISTER_ACK but got %s (in 'create_sep_obj'). "
#define CURIMPERR2	"    Expect %s but got %s (in `%s')."
#define CURIMPERR3	"    Expect REGISTER_ACK_WITH_ROOT_OID but got %s (in 'remote_server')."
#define CURIMPERR4	"    Expect REGISTER/REGISTER_FIRST_FROM_PARENT/SEP_CHILD/SEP_CHILD_INFO\nbut got %s (in 'wait_sep_child')\n-- caused by the crash of the new-born separate child object."

#define CURIMPERR26	"    The object(whose Dtype is %d) is not a separate object(whose Dtype is: %d)."

/* The following are application error messages */
#define CURAPPERR1  "    Error in reserving separate object. Expect ACKNOWLEDGE_TO_RESERVE_SEP_OBJ\nor REJECT_TO_RESERVE_SEP_OBJ but got %s \n--maybe caused by the crash of other separate object(s)."
#define CURAPPERR2	"    Crash happened in child processor(s) of the current processor(%s)."
#define CURAPPERR3	"    One of the current processor's client/servers is dead(%s)\n--got unexpected command %s."
#define CURAPPERR4	"    After ACCEPT get command %s  para_number: %d\n-- caused by the crash of other separate object(s)."
#define CURAPPERR5	"    The index(%d) for Remote Server exceeds \nthe number of remote servers specified in configure file(%d)."
#define CURAPPERR6	"    The remote server name(%s) does not exist in configure file."
#define CURAPPERR7	"    Crash happened in a new-born separate child object."
#define CURAPPERR8	"    A Client Separate Object is dead(maybe killed by user)."
#define CURAPPERR9	"    Check your configure file to make sure that the directorys are correctly set."
#define CURAPPERR10	"    A Child Separate Object is dead(maybe killed by user)(%s)."
#define CURAPPERR11	"    No error occurs on the processor so far. Crash happens on other processor(s)."
#define CURAPPERR12	"    Invalid connection to parent."
#define CURAPPERR38	"    Try to apply feature/attribute to Void separate object."


/* The following are error messages whose causes are not clear  */
#define CURERR1		"    More space(%d bytes) is necessary for class name;\nor one of the current processor's server is dead(which causes an incorrect class name length)."
#define CURERR2		"    More space(%d bytes) is necessary for feature name;\nor one of the current processor's server is dead(which causes an incorrect class name length)."
#define CURERR3		"    Receive Unknown Parameter Data Type: %d."
#define CURERR4		"    Try to Send Unknown Parameter Data Type: %d."
#define CURERR5		"    A UNREGISTER make a reserved client destroyed \n-- maybe caused by the crash of other separate object(s)!"
#define CURERR17	"    The parent processor asked the local processor to terminate."
#define CURERR18	"    Got REPORT_ERROR message from <%s, %d> but there is no entry in child list."
#define CURERR19	"    Got EXIT_OK message from <%s, %d> but there is no entry in child list."
#define CURERR20	"    Network exception happened on the local processor."
#define CURERR21	"    Network exception happened on the parent of the local processor."
#define CURERR22	"    Network exception happened on the child(ren) of the local processor."


/*--------------------------------------------------------*/
/*     Prompt Message From CONCURRENCY.c                  */
/*--------------------------------------------------------*/

#define CURPROMPT1	"------------------------------ Configure Table --------------------------------\n"
#define CURPROMPT2	"Remote Servers:\n"
#define CURPROMPT3	"\nNet Work Resources:\n"
#define CURPROMPT4	"  In Group <%s>:\n"
#define CURPROMPT5	"\nCursor is on \n<%s, %d, %s, %s>\nof group <%s> with count: %d.\n"
#define CURPROMPT6	"\nInvalid Cursor. \n"
#define CURPROMPT7	"\nDefault Port for External Server: %d;   Default Instance: %d\n"
#define CURPROMPT8	"-------------------------------------------------------------------------------\n"

/*--------------------------------------------------------*/
/*     Error Message From CONCURRENCY.c                   */
/*--------------------------------------------------------*/

/* The following are implementation error messages */

/* The following are application error messages */
#define CURAPPERR13 "    Open configure file <%s> fail."	
#define CURAPPERR14 "    Syntax Error in configure file around line:\n%s\n-- Key word 'default' is expected!"
#define CURAPPERR15 "    Syntax error in configure file's DEFAULT part: unexpected end of file."
#define CURAPPERR16 "    Syntax error in configure file's DEFAULT part around line:\n%s"
#define CURAPPERR17 "    Syntax error in configure file's DEFAULT part around line:\n%s\n-- expect default value(s) for 'port'/'instance'."
#define CURAPPERR18 "    Syntax error in configure file's DEFAULT part: unexpected end of file.\n-- expect 'end' for DEFAULT part."
#define CURAPPERR19 "    Syntax error after configure file's DEFAULT part around line:\n%s\n-- end of file is expected."
#define CURAPPERR20 "    Syntax error: your configure file defines such a remote server \n<'%s' on host '%s' with port %d>.\n-- host name can't be empty, port number must be positive."
#define CURAPPERR21 "    Syntax error: your configure file defines such a host \n<'%s' in directory '%s' with capability %d>.\n-- both host name and directory can't be empty."
#define CURAPPERR22 "    Syntax error: your configure file defines all hosts unavailable(their capabilities are all less than 1)\n-- expect at least one host's capability to be greater than 0."
#define CURAPPERR23 "    Syntax error in configure file's EXTERNAL part around line: \n%s\n-- expect only key word 'external' in the line to begin the EXTERNAL part."
#define CURAPPERR24 "    Syntax error in configure file's EXTERNAL part around line: \n%s"
#define CURAPPERR25 "    Syntax error in configure file's EXTERNAL part around line: \n%s\n-- expect 'end'."
#define CURAPPERR26 "    Syntax error in configure file's CREATION part around line:\n%s\n-- expect only key word 'creation' in the line to begin the CREATION part."
#define CURAPPERR27 "    Syntax error in configure file's CREATION part around line:\n%s\n-- expect `:' for level name or `end' to terminate the CREATION part."
#define CURAPPERR28 "    Syntax error in configure file's CREATION part around line:\n%s\n-- expect only key word 'system' in the line."
#define CURAPPERR29 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect host name quoted in '\"'."
#define CURAPPERR30 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect host name."
#define CURAPPERR31 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect port number/directory."
#define CURAPPERR32 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect directory."
#define CURAPPERR33 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect at least one host in each group."
#define CURAPPERR34 "    Syntax error in configure file's CREATION part around line: \n%s\n-- expect 'end'."
#define CURAPPERR35 "    Syntax error in configure file for <%s>: %s\n-- executable file's name should be FULL name(from root)."
#define CURAPPERR36 "    Syntax error in configure file for <%s>: %s\n-- executable file's name should not be empty."
#define CURAPPERR37 "    Syntax Error in configure file around line:\n%s\n-- Key word `external' or `default' or nothing is expected!"

#define CURAPPERR39	"    Host <%s> does not exist in group <%s> or its capacity is less than 1."
#define CURAPPERR40	"    Group <%s> does not exist in configure table."
#define CURAPPERR41	"    Group <%s> does not contain a host whose capacity is greater than 0."
#define CURAPPERR42 "    Syntax error in configure file's CREATION part: expect at least one group."
#define CURAPPERR43 "    Invalid cursor of configure table. The configure table is empty."

/* The following are error messages whose causes are not clear  */



/*--------------------------------------------------------*/
/*     Error Message From REF_TABLE.c                     */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR5	"    Try to clean up proxy from imported object table but it does not exist.."
#define CURIMPERR6	"    Receive RELEASE but there is no corresponding exported object."
#define CURIMPERR7	"    Received REGISTER but there is no corresponding exported object."
#define CURIMPERR8	"    Received UNREGISTER but there is no corresponding exported object."

/* The following are application error messages */

/* The following are error messages whose causes are not clear  */




/*--------------------------------------------------------*/
/*     Error Message From SUBS.c                          */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR9	"    Error happened when get host name(%s)."
#define CURIMPERR18	"    Error happened when get host name--name is long than buffer."
#define CURIMPERR10	"    Error happened when get current directory(%s)."
#define CURIMPERR11	"    Error happened when get user name(%s)."
#define CURIMPERR12	"    Error happened when send signal to parent process\n-- parent process crashed or the parameters were not correct(%s)."
#define CURIMPERR13	"    Error happened when connect to a network server<%s, %d>(%s)."
#define CURIMPERR14	"    Error happened when Set Up Client with <%s, %d>\n-- increase the try times(default:%d)(%s)."
#define CURIMPERR19	"    Can't find an entry for host with address `%ld' in host table(%s)."
#define CURIMPERR20	"    Can't find an entry for host with name `%s' in host table(%s)."
#define CURIMPERR21	"    Can't find an entry for local host `%s' in host table(s)."
#define CURIMPERR22	"    Can't allocate socket!\n-- Maybe system resources are exhausted(%s)!"
#define CURIMPERR23	"    Can't create server for a separate object!\n-- Maybe system resources(socket) are exhausted(%s)!"
#define CURIMPERR24	"    Error happened when accepts from network(%s)."

/* The following are application error messages */

/* The following are error messages whose causes are not clear  */
#define CURERR6		"    Error happened when  read data from network\n-- maybe other separate object crashed or was killed by user. "		
#define CURERR10	"    Error happened when Set Up Client with DAEMON<%s, %d>\nMake sure that the Daemon is up or increase the try times(default:%d)."



/*--------------------------------------------------------*/
/*     Error Message From CONSTANT.h                      */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR15	"    Fail in eif_malloc memory(%s)!"
#define CURIMPERR16	"    Expect ACK_FOR_PROCEDURE/QUERY_RESULT but got %s!"

/* The following are application error messages */

/* The following are error messages whose causes are not clear  */
#define CURERR7 	"    Invalid number of parameters to start the concurrent application\n-- Correct format is: executable init parameters_of_the_creation_feature_of_root_obj(if_any)."
#define CURERR8 	"    The first parameter of service file must be `init'(used by user to start\n up application) or `creation'(used by system)."
#define CURERR9 	"    The following error occurs when connect with SCOOP DAEMON on host <%s>.\nPlease make sure that the SCOOP DAEMON is up and using the corresponding port number(%d)."	
#define CURERR11 	"    The following error occurs when send request to SCOOP DAEMON on host <%s>."
#define CURERR12 	"    The following error occurs when get message from SCOOP DAEMON on host <%s>."
	




/*--------------------------------------------------------*/
/*     Error Message From  IDLE.c                         */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR17 	"    Expect REGISTER/REGISTER_FIRST_FROM_PARENT but got %s (in 'idle_usage')."


/*--------------------------------------------------------*/
/*     Error Message From  SEP_CALL.c                     */
/*--------------------------------------------------------*/

/* The following are error messages whose causes are not clear  */
#define CURERR13	"    Error in separate_call. Got %s."	
#define CURERR14	"    Error happened when execute separate feature/attribute `%s'\nof `%s'."
#define CURERR15	"    Attribute %s is not found in class %s."
#define CURERR16	"    Not implemented type(0x%x) of separate attribute."
#define CURERR24	"    Can't find feature %s(in class %s)'s pattern ID."


/*--------------------------------------------------------*/
/*     Error Message From : sep_obj.c                     */
/*--------------------------------------------------------*/

/* The following are implementation error messages */
#define CURIMPERR25	"    No memory to create Eiffel separate object proxy."

/* The following are error messages whose causes are not clear  */
#define CURERR23	"    Can't make network connection with host %s at port %d."


/*--------------------------------------------------------*/
/*     Error Message From                                 */
/*--------------------------------------------------------*/

/* The following are prompt messages */
/*
#define CURPROMPT38
*/

/* The following are implementation error messages */
/*
#define CURIMPERR27	
*/

/* The following are application error messages */
/*
#define CURAPPERR44
*/

/* The following are error messages whose causes are not clear  */
/*
#define CURERR25	
*/
			
#ifdef __cplusplus
}
#endif

#endif

#include "net.h"
#include "curextern.h"

void extend_string(MY_STRING *my_s, char *str) {
/* the extended `str' must be a STRING terminated with '\0'. */
	char *tmp;
	if (my_s->size - my_s->used > (long)strlen(str)) {
		strcpy(my_s->info + my_s->used, str);
		my_s->used += strlen(str);
	}
	else {
		my_s->size = my_s->size + strlen(str) + constant_memory_increment;
		tmp = (char *)malloc(my_s->size);
		valid_memory(tmp);
		if (my_s->info) 
			strcpy(tmp, my_s->info);
		strcpy(tmp+my_s->used, str);
		my_s->used += strlen(str);
		if (my_s->info) 
			free(my_s->info);
		my_s->info = tmp;
	}
}

void extend_string_with_length(MY_STRING *my_s, char *str, long len) {
/* the extended `str' may not be a STRING terminated with '\0'. */
	char *tmp;
	if (my_s->size - my_s->used > len) {
		memcpy(my_s->info + my_s->used, str, len);
		my_s->used += len;
	}
	else {
		my_s->size = my_s->size + len + constant_memory_increment;
		tmp = (char *)malloc(my_s->size);
		valid_memory(tmp);
		if (my_s->info && my_s->used) 
			memcpy(tmp, my_s->info, my_s->used);
		memcpy(tmp+my_s->used, str, len);
		my_s->used += len;
		if (my_s->info) 
			free(my_s->info);
		my_s->info = tmp;
	}
}

	
/*---------------------------------------------*/
/*                                             */
/* The  following is used by Concurrent Eiffel */
/*                                             */
/*---------------------------------------------*/
#ifdef tCONCURRENT_EIFFEL
rt_private void cur_print_top();		/* Prints top value of the stack for Concurrency*/

/* Strings used as separator for Eiffel stack dumps */
rt_private char *cur_retried =
"\n===============================================================================";
rt_private char *cur_failed =
"\n-------------------------------------------------------------------------------";
rt_private char *cur_branch_enter =
"\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ entering level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
rt_private char *cur_branch_exit =
"\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ back to level %d ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";

void get_call_stack() {
    char buf[200];
    if (echmem & MEM_FSTK) {
        extend_string(&_concur_call_stack, "\nDue to a lack of memory, the sequence is incomplete near the end");
    }
    if (echmem & MEM_FULL) {
        if (echmem & MEM_FSTK) {
            extend_string(&_concur_call_stack, "\nMoreover, an 'out of memory' may have led to an untrustworthy stack");
        } else {
            extend_string(&_concur_call_stack, ".\nHowever, an 'out of memory' occurred and might have spoilt the stack");
        }
    }
    if (echmem & MEM_PANIC) {
        extend_string(&_concur_call_stack, "\nNB: The raised panic may have induced completely inconsistent information");
    }
    echmem |= MEM_PANIC;
    (void) backtrack();

    /* Dump the Eiffel exception trace stack once a system failure has occurred .
     * Due to the upside-down nature of this stack, we need to use the 'st_bot'
     * field of the xstack structure.
     */

    /* Initializes the eif_trace structure's field st_bot correctly. It is the
     * current bottom of the stack, which appears to be the topmost exception
     * to be printed by this dumping routine...
     */
    eif_trace.st_bot = eif_trace.st_hd->sk_arena;   /* Very first item */
   eif_trace.st_cur = eif_trace.st_hd;             /* Is now where bottom is */
    eif_trace.st_end = eif_trace.st_cur->sk_end;

    /* Print header of history table */
    extend_string(&_concur_call_stack, cur_failed);
    sprintf(buf, "\n%-19.19s %-22.22s %-29.29s %-6.6s",
        "Class / Object", "Routine", "Nature of exception", "Effect");
    extend_string(&_concur_call_stack, buf);

    extend_string(&_concur_call_stack, cur_failed);

    /* Print body of history table. A little look-ahead is necessary, in order
     * to give meaningful routine names and effects (retried, rescued, cur_failed).
     */

    except.previous = 0;        /* Previous exception code */
    cur_recursive_dump(0);          /* Recursive dump, starting at level 0 */

}

cur_recursive_dump(level)
register1 int level;
{
    char buf[200];
    /* Prints the stack trace of a given level. Whenever a new level is reached ,
     * we call us recursively, hence the name of the routine. The exception
     * structure is saved (on the C stack) before entering in the recursion.
     * While the calling stack cannot be inconsistant (otherwise it's a panic),
     * the exception stack may well be, in case we ran out of memory.
     */

    struct ex_vect *trace;      /* Call on top of the stack */

    for (
        find_call(), trace = eif_trace.st_bot;
        trace != eif_trace.st_top;
        trace = eif_trace.st_bot
    ) {
        except.code = trace->ex_type;   /* Record exception code */
        except.tag = (char *) 0;        /* No tag by default */

        switch (trace->ex_type) {
        case EN_ILVL:                   /* Entering new level */
            /* The stack may end with such a beast, so detect this and return
             * if we reached the last item in the stack.
             */
            (void) exnext();            /* Skip pseudo-vector "New level" */
            if (exend())
                return;                 /* Exit if at the end of the stack */
            sprintf(buf, cur_branch_enter, trace->ex_lvl);
            extend_string(&_concur_call_stack, buf);
            extend_string(&_concur_call_stack, cur_failed);
            recursive_dump(level + 1);  /* Dump the new level */
            sprintf(buf, cur_branch_exit, level);
            extend_string(&_concur_call_stack, buf);
            extend_string(&_concur_call_stack, cur_failed);
            find_call();                /* Restore global exception structure */
            break;
        case EN_OLVL:                   /* Exiting a level */
            (void) exnext();            /* Skip pseudo-vector "Exit level" */
            return;                     /* Recursion level decreases */
            /* NOTREACHED */
        case EN_RES:                    /* Resumption attempt */
        case EN_FAIL:                   /* Routine call */
        case EN_RESC:                   /* Exception in rescue */
            cur_print_top();                /* Print exception trace */
            find_call();                /* Look for new enclosing call */
            break;
        case EN_SIG:                    /* Signal received */
            except.tag = signame(trace->ex_sig);
            cur_print_top();
            break;
        case EN_SYS:                    /* Operating system error */
        case EN_IO:                     /* I/O error */
            except.tag = error_tag(trace->ex_errno);
            cur_print_top();
            break;
        case EN_CINV:                   /* Class invariant violated */
            except.obj_id = trace->ex_oid;  /* Do we need this? */
            /* Fall through */
        case EN_PRE:                    /* Precondition violated */
            except.tag = trace->ex_name;
            cur_print_top();
            find_call();                /* Restore correct object ID */
            break;
        case EN_BYE:
        case EN_FATAL:
            except.tag = echtg;         /* Tag for panic or fatal error */
            cur_print_top();
            break;
        default:
            except.tag = trace->ex_name;
            cur_print_top();
        }
    }
}

rt_private void cur_print_top()
{
    /* Prints the exception trace described by the top frame of the exception
     * stack and the exception context built.
     * The exception tag is limited to 26 characters, the class name to 19 and
     * the routine name to 22 characters. These should be #defined--RAM, FIXME.
     */

    char cur_buf[200];
    char buf[30];               /* To pre-compute the (From orig) string */
    char code = except.code;    /* Exception's code */
    struct ex_vect *top;        /* Top of stack */

    /* Do not print anything if the retry flag is on and the previous exception
     * was not not a routine failure nor a resumption attempt cur_failed. Indeed,
     * the exception that led to a retry has already been printed and we do
     * not want to see two successive 'retry' lines.
     * Similarily, a rescued routine fails, and is not 'rescued' at the end
     * of the rescue clause.
     */
    if (
        except.retried &&           /* Call has been retried */
        except.previous != 0 &&     /* Something has been already printed */
        except.previous != EN_FAIL && except.previous != EN_RES
    ) {
        (void) exnext();        /* Remove the top */
        return;                 /* We already printed the retry line */
    }

    except.previous = code;     /* Update previous exception code */

    if (except.tag)
        sprintf(buf, "%.28s:", except.tag);
    else
        buf[0] = '\0';

    if (except.from >= 0)
        if (except.obj_id) {
            int obj_dtype = Dtype(except.obj_id);

            if (obj_dtype>=0 && obj_dtype < scount) {
                sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
                    Class(except.obj_id), except.rname, buf);
                extend_string(&_concur_call_stack, cur_buf);
            }
            else {
                sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
                    "Invalid object", except.rname, buf);
                extend_string(&_concur_call_stack, cur_buf);
            }
        }
        else {
            sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
                "Invalid object", except.rname, buf);
            extend_string(&_concur_call_stack, cur_buf);
        }
    else {
        sprintf(cur_buf, "\n%-19.19s %-22.22s %-29.29s",
            "RUN-TIME", except.rname, buf);
        extend_string(&_concur_call_stack, cur_buf);
    }

    /* There is no need to compute the origin of a routine if it is the same
     * as the current class. To detect this, we do pointer comparaison to
     * statically allocated strings (faster than a strcmp).
     * As a matter of style, the macros 'Class', 'System' etc... are not
     * all uppercased because there is no side effect, and they could be
     * functions--RAM.
     */

    buf[0] = '\0';

    if (except.from >= 0)
        if (except.obj_id) {
            if (except.from != Dtype(except.obj_id))
                sprintf(buf, "(From %.15s)", Origin(except.from));
        } else
            sprintf(buf, "(From %.15s)", Origin(except.from));

    sprintf(cur_buf, "\n<%08X>          %-22.22s %-29.29s ",
        except.obj_id, buf, exception_string(code));
    extend_string(&_concur_call_stack, cur_buf);

    /* Start panic effect when we reach the EN_BYE record */
    if (code == EN_BYE)
        echval = EN_BYE;

    /* Start fatal effect when we reach the EN_FATAL record */
    if (code == EN_FATAL)
        echval = EN_FATAL;

    (void) exnext();            /* Can safely be removed */


    /* Here is an informal discussion about the "Effect" keywords which may
     * appear in the stack trace: "Retry" is the last exception that occurred
     * before 'retry' was reached. Similarily, "Rescue" signals the last
     * exception after entering in a rescue clause. "Pass" signals exceptions
     * which are not directly followed by a call in the trace. In effect, they
     * raise an exception somewhere but do not 'fail'. "Fail" appears everywhere
     * else, unless it is the last exception, in which case we "Exit"--RAM.
     */

    if (echval == EN_BYE) {     /* A run-time panic was raised */
        if (except.last)
            extend_string(&_concur_call_stack, cur_failed); /* Good bye! */
        else {
            sprintf(cur_buf, "Panic%s", cur_failed);   /* Panic propagation */
            extend_string(&_concur_call_stack, cur_buf);
        }
        return;
    } else if (echval == EN_FATAL) {
        if (except.last) {
            sprintf(cur_buf, "Bye%s", cur_failed); /* Good bye! */
            extend_string(&_concur_call_stack, cur_buf);
        }
        else {
            sprintf(cur_buf, "Fatal%s", cur_failed);   /* Fatal propagation */
            extend_string(&_concur_call_stack, cur_buf);
        }
        return;
    } else if (except.last) {                       /* Last record => exit */
        sprintf(cur_buf, "Exit%s", cur_failed);
        extend_string(&_concur_call_stack, cur_buf);
        return;
    } else if (code == EN_FAIL || code == EN_RES) {
        if (except.retried) {
            sprintf(cur_buf, "Retry%s", cur_retried);
            extend_string(&_concur_call_stack, cur_buf);
        }
        else if (except.rescued) {
            sprintf(cur_buf, "Rescue%s", cur_failed);
            extend_string(&_concur_call_stack, cur_buf);
        }
        else {
            sprintf(cur_buf, "Fail%s", cur_failed);
            extend_string(&_concur_call_stack, cur_buf);
        }
        return;
    }

    /* We need some lookhead to exactely print retry or rescue once. We want
     * to print a "retry" or "rescue" if and only if the next record in the
     * stack (pointed at by 'top') is a retry or routine record.
     */

    top = eif_trace.st_bot;     /* Look ahead */
    code = top->ex_type;


    if (code == EN_FAIL || code == EN_RES) {
        if (except.retried) {
            sprintf(cur_buf, "Retry%s", cur_retried);
            extend_string(&_concur_call_stack, cur_buf);
        }
        else {
            sprintf(cur_buf, "Fail%s", cur_failed);
            extend_string(&_concur_call_stack, cur_buf);
        }
    } else {
        sprintf(cur_buf, "Pass%s", cur_failed);
        extend_string(&_concur_call_stack, cur_buf);
    }
}

#endif


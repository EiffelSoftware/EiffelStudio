#include "except.c"

#ifdef TEST

/* This section implements a set of tests for the exception mechanism.
 * It should not be regarded as a model of C programming :-).
 * To run this, compile the file with -DTEST.
 */

#undef TEST
#undef DEBUG
#undef Size
#undef References
#undef Dispose

#define Size(x)			40
#define References(x)	2
#define Dispose(x)		((void (*)()) 0)
#define stack_allocate	gc_stack_allocate
#define stack_extend	gc_stack_extend

#define DEBUG 0			/* So that we get debugging routines/tests */
#define lint			/* Avoid definition of rcsid */
#include "malloc.c"
#include "garcol.c"
#include "local.c"
#include "sig.c"
#include "timer.c"
#include "urgent.c"

rt_private struct stack hec_stack;
/*rt_private char *(**ecreate)(); FIXME: SEE EIF_PROJECT.C */

#include "eif_macros.h"


/* Classes held in the pseudo-test system (these have to be statically allocated
 * strings as the dumping of the exception stack does address comparaison).
 */
char c0[] = "LONG_CLASS_NAME";
char c1[] = "FIRST";
char c2[] = "SECOND";
char c3[] = "THIRD";
char c4[] = "FOURTH";
char c5[] = "FIFTH";

/* Array used to fake a real system (with class names, routine names and
 * origins for each routine.
 */
rt_private struct test test_system[] = {
	{ c0, "root", c0 },					/* 0 */
	{ c1, "first_routine", c1 },		/* 1 */
	{ c2, "second_routine", c1 },		/* 2 */
	{ c3, "third_routine", c2 },		/* 3 */
	{ c4, "fourth_routine", c3 },		/* 4 */
	{ c5, "fifth_routine", c4 },		/* 5 */
	{ c5, "called_by_invariant", c5 },	/* 6 */
	{ c4, "called_by_rescue", c4 },		/* 7 */
	{ c3, "called_by_check", c3 },		/* 8 */
	{ c2, "called_by_loop_var", c2 },	/* 9 */
};

/* Routines used to simulate the Eiffel system */
rt_private void t_root(void);
rt_private void t_first_routine(void);
rt_private void t_second_routine(void);
rt_private void t_third_routine(void);
rt_private void t_fourth_routine(void);
/*
rt_private void t_fifth_routine(void);
*/
rt_private void t_called_by_check();	/* %%zs undefined */
rt_private Signal_t emergency(int sig);

rt_public main(void)
{
	/* Tests for the exception mechanism */

	initsig();
	esig[3] = t_fourth_routine;
	t_root();
	exit(0);
}

rt_private void t_root(void)
{
	RTEX; RTED;

	RTEA(0, 0, 0);
	RTEJ;
	t_first_routine();
	exok();

rescue:
	trapsig(emergency);
	esfail();
}

rt_private void t_first_routine(void)
{
	RTEX;

	RTEA("first_routine", 1, 1);
	RTCT("Assertion_will_fail", EX_PRE);
	t_second_routine();
	if (0)
		RTCK;
	else
		RTCF;
	RTEE;
}

rt_private void t_second_routine(void)
{
	RTEX; RTED;
	int time = 1;

	RTEA("second_routine", 2, 2);
	RTEJ;
		(time == 1) ? "first" : "second");
	RTCT("Number 1", EX_PRE);
	if (1)
		RTCK;
	else
		RTCF;
	RTCT("Check_will_fail", EX_CHECK);
	RTCF;
	RTEE;

rescue:
	RTEU;
	if (time == 1) {
		time++;
		RTER;
	}
	t_third_routine();
	RTEF;
}

rt_private void t_third_routine(void)
{
	RTEX;

	RTEA("third_routine", 3, 3);

	RTCT("Signal sent in postcond", EX_POST);
	kill(getpid(), 3);
	RTCK;
	RTEE;
}

rt_private void t_fourth_routine(void)
{
	RTEX;

	RTEA("fourth_routine", 4, 4);

	RTCT("Postcondition_will_fail", EX_POST);
	eraise("Ensure_it_fails", EN_LINV);
	RTCF;
	RTEE;
}

rt_private Signal_t emergency(int sig)
{
	exit(2);
}

#endif



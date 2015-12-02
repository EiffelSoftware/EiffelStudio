
/* Need to define some macros to make the code compile... */
#define EIF_THREADS
#define EIF_LINUXTHREADS
#define _GNU_SOURCE

#include <sys/types.h>
#include "rt_min_unit.c"

#include "message_channel.c"
#include "posix_threads.c"
#include "timer.c"

/* Stub implementations,
 * needed to resolve symbols at link stage. */
void* eiffel_malloc (size_t b) {
	return malloc (b);
}
void eiffel_free (void* ptr) {
	free (ptr);
}
Signal_t (*rt_signal (int sig, Signal_t (*handler)(int)))(int)
{
        return signal(sig, handler);
}
void eif_enter_eiffel_code () {}
void eif_exit_eiffel_code () {}
int volatile eif_is_gc_collecting = 0;
void eif_synchronize_for_gc () {}
void rt_request_gc_cycle (int* fingerprint) {}
void eif_panic (char* msg) {}
void rt_mark_call_data (MARKER marking, struct eif_scoop_call_data* call) {}

/*
 * Data structures.
 */

struct rt_processor {
	int pid;
};

struct thread_args {
	int iterations;
	struct rt_message_channel* chan;
};

/* Thread main routines. */
static void* produce_dirty (void* a_args)
{
	struct thread_args* args = a_args;

	for (int i=0; i<args->iterations; ++i) {
		rt_message_channel_send (args->chan, SCOOP_MESSAGE_DIRTY, NULL, NULL, NULL);
	}
	rt_message_channel_send (args->chan, SCOOP_MESSAGE_UNLOCK, NULL, NULL, NULL);
	return 0;
}

/*
 * Setup routines
 */

static struct rt_message_channel global_channel;
static struct rt_message_channel* channel;

static void setup (void)
{
	channel = &global_channel;
	rt_message_channel_init (channel, 512);
}

static void cleanup (void)
{
	rt_message_channel_deinit (channel);
}


/*
 * Test routines.
 */

static void test_sequential (void)
{
	const int count = 10000;
	int i = 0;
	for (i=0; i<count; ++i) {
		struct rt_processor* my_proc = malloc (sizeof (struct rt_processor));
		my_proc->pid = i;
		rt_message_channel_send (channel, SCOOP_MESSAGE_RESULT_READY, my_proc, NULL, NULL);
	}

	for (i=0; i<count; ++i) {
		struct rt_message received;
		rt_message_channel_receive (channel, &received);
		mu_assert ("correct_message_type", received.message_type == SCOOP_MESSAGE_RESULT_READY);
		mu_assert ("correct_processor", received.sender->pid == i);
		mu_assert ("correct_call_data", received.call == NULL);
		free (received.sender);
	}
}


static void test_concurrent_no_data (void)
{
	const int count = 1000000;
	struct rt_message received;
	pthread_t producer;
	struct thread_args args;

	args.iterations = count;
	args.chan = channel;

	pthread_create (&producer, NULL, produce_dirty, &args);

	for (int i=0; i<count; ++i) {
		rt_message_channel_receive (channel, &received);
		mu_assert ("correct_message", received.message_type == SCOOP_MESSAGE_DIRTY);
	}

	rt_message_channel_receive (channel, &received);
	mu_assert ("correct_message", received.message_type == SCOOP_MESSAGE_UNLOCK);

	pthread_join (producer, NULL);
}

/*
 * Test suite definition and main().
 */

static mu_function_t my_tests [] = {
	test_sequential,
	test_concurrent_no_data,
	NULL
};

MU_MAIN_SETUP (my_tests, setup, cleanup)

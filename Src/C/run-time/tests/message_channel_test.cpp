
/* Need to define some macros to make the code compile... */

#define EIF_USE_STD_MUTEX
#define EIF_USE_STD_ATOMIC
#define EIF_USE_STD_SHARED_PTR

#define EIF_ENTER_C
#define EIF_EXIT_C
#define RTGC

#define rt_mark_call_data(x,y)

#include "rt_min_unit.c"
#include "message_channel.cpp"

#include <thread>

/*
 * Stub implementations.
 */

class processor {
public:
	processor (int _pid): pid(_pid) {}
	int pid;
};

/* Thread main routines. */

static void produce_dirty (int n, struct rt_message_channel* a_channel)
{
	for (int i=0; i<n; ++i) {
		rt_message_channel_send (a_channel, SCOOP_MESSAGE_DIRTY, NULL, NULL);
	}
	rt_message_channel_send (a_channel, SCOOP_MESSAGE_UNLOCK, NULL, NULL);
}

/*
 * Setup routines
 */

static rt_message_channel global_channel;
static rt_message_channel* channel;

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
	for (int i=0; i<count; ++i) {
		processor* my_proc = new processor (i);
		rt_message_channel_send (channel, SCOOP_MESSAGE_RESULT_READY, my_proc, NULL);
	}

	for (int i=0; i<count; ++i) {
		rt_message received;
		rt_message_channel_receive (channel, &received);
		mu_assert ("correct_message_type", received.message_type == SCOOP_MESSAGE_RESULT_READY);
		mu_assert ("correct_processor", received.sender->pid == i);
		mu_assert ("correct_call_data", received.call == NULL);
		delete received.sender;
	}
}


static void test_concurrent_no_data (void)
{
	const int count = 10000;
	rt_message received;

	std::thread producer (produce_dirty, count, channel);

	for (int i=0; i<count; ++i) {
		rt_message_channel_receive (channel, &received);
		mu_assert ("correct_message", received.message_type == SCOOP_MESSAGE_DIRTY);
	}

	rt_message_channel_receive (channel, &received);
	mu_assert ("correct_message", received.message_type == SCOOP_MESSAGE_UNLOCK);

	producer.join();
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

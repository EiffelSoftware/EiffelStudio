
#ifndef __EWG_CALLBACK_LIBRARY__
#define __EWG_CALLBACK_LIBRARY__

typedef void (*sample_callback_type) (void* pdata, int a_event_type);

// make `sample_callback_type' receive events.
void register_callback (sample_callback_type a_callback, void* pdata);

// make all registered callbacks receive an event
void trigger_event (int a_event_type);

struct function_table
{
  int (*callme) (int, int);
};

struct function_table* get_function_table (void);

#endif

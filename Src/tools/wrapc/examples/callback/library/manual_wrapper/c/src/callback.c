
#include <callback.h>
#include <stdlib.h>

typedef struct callback_list* pcallback_list;
struct callback_list
{
	 sample_callback_type callback;
	 void* pdata;
	 pcallback_list next_item;
};

pcallback_list plist = NULL;

void register_callback (sample_callback_type a_callback, void* pdata)
{
	 pcallback_list a_list;
	 if (plist == NULL)
	 {
		  // create new list and add `a_callback'.
		  plist = (pcallback_list) malloc (sizeof (struct callback_list));
		  a_list = plist;
	 }
	 else
	 {
		  a_list = plist;
		  // go to end of list and add callback
		  while (a_list->next_item != NULL)
		  {
			   a_list = a_list->next_item;
		  }
		  a_list->next_item = (pcallback_list) malloc (sizeof (struct callback_list));
		  a_list = a_list->next_item;
	 }
	 a_list->callback = a_callback;
	 a_list->pdata = pdata;
	 a_list->next_item = NULL;
}


void trigger_event (int a_event_type)
{
	 pcallback_list a_list = plist;
	 if (a_list != NULL)
	 {
		  do
		  {
			   a_list->callback (a_list->pdata, a_event_type);
			   a_list = a_list->next_item;
		  } while (a_list != NULL);
	 }
}

int some_callme (int a, int b)
{
	 return a + b;
}

struct function_table some_function_table = {some_callme};

struct function_table* get_function_table (void)
{
	 return &some_function_table;
}

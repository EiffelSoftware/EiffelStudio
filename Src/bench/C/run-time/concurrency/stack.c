#include "eif_net.h"
#include "eif_curextern.h"

void extend_string(MY_STRING *my_s, char *str) {
/* the extended `str' must be a STRING terminated with '\0'. */
	char *tmp;
	if (my_s->size - my_s->used > (long)strlen(str)) {
		strcpy(my_s->info + my_s->used, str);
		my_s->used += strlen(str);
	}
	else {
		my_s->size = my_s->size + strlen(str) + constant_memory_increment;
		tmp = (char *)eiffel_malloc(my_s->size);
		valid_memory(tmp);
		if (my_s->info) 
			strcpy(tmp, my_s->info);
		strcpy(tmp+my_s->used, str);
		my_s->used += strlen(str);
		if (my_s->info) 
			eiffel_free(my_s->info);
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
		tmp = (char *)eiffel_malloc(my_s->size);
		valid_memory(tmp);
		if (my_s->info && my_s->used) 
			memcpy(tmp, my_s->info, my_s->used);
		memcpy(tmp+my_s->used, str, len);
		my_s->used += len;
		if (my_s->info) 
			eiffel_free(my_s->info);
		my_s->info = tmp;
	}
}

	

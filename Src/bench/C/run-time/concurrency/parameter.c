
/*****************************************************************
    In the C-programs, we use EIF_OBJECT and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "eif_net.h"
#include "eif_curextern.h"

EIF_INTEGER adjust_array(arr, old_size, size)
PARAMETER **arr;
EIF_INTEGER old_size;
EIF_INTEGER size;
{
/* adjust parameter array so that it can hold at least "size"
 * parameters.
*/
	EIF_INTEGER i;

	if (size > old_size) {
		free_parameter_array(*arr, old_size); /* eif_free old */
		*arr = (PARAMETER *)eif_malloc(size * sizeof(PARAMETER));
		valid_memory(*arr);
		for(i=0; i<size; i++) /* initialization */
			(*arr)[i].str_len = 0;	
		return size;
	}
	return old_size;
}

/*
adjust_parameter_array(size)
EIF_INTEGER size;
{
	EIF_INTEGER i;

	if (size > _concur_paras_size) {
		free_parameter_array(_concur_paras, _concur_paras_size); 
		_concur_paras = (PARAMETER *)eif_malloc(size * sizeof(PARAMETER));
		valid_memory(_concur_paras);
		_concur_paras_size = size;
		for(i=0; i<_concur_paras_size; i++) 
			_concur_paras[i].str_len = 0;	
	}
}
*/

void free_parameter_array(ary, size)
PARAMETER *ary;
EIF_INTEGER size;
{
/* not only eif_free the space occurred by the array, but also 
 * the space allocated to each cell to store string data.
*/
	EIF_INTEGER i;
	
	for(i=0; i<size; i++) {
		if (ary[i].str_len)
		/* there is a string buffer in the cell, eif_free it */
			eif_free(ary[i].str_val);
	}
	eif_free(ary);
}


void set_str_val_into_parameter(para, str)
PARAMETER * para;
char *str;
{
/* Assign a String to an item of request's parameter array */

	if (str == NULL) {
	/* use a negative buffer length to indicate NULL string,
	 * and set the string value into EMPTY string.
	*/
		if (para->str_len)
			para->str_len = - abs(para->str_len);
		else {
			para->str_len = - constant_min_str_len;
			para->str_val = (char *)eif_malloc(constant_min_str_len);
			valid_memory(para->str_val);
		}
		(para->str_val)[0] = '\0';
	}
	else {
		if (para->str_len < 0)
			para->str_len = - para->str_len;
		if (para->str_len <= (int)(strlen(str))) {
		/* if the string buffer is not big enough, adjust it */
			if (para->str_len)
				eif_free(para->str_val);
			para->str_len = strlen(str) + 1 ;
			if (para->str_len < constant_min_str_len)
				para->str_len = constant_min_str_len ;
			para->str_val = (char *)eif_malloc(para->str_len);
			valid_memory(para->str_val);
		}
		strcpy(para->str_val, str);
	}
	return;
}



/*****************************************************************
    In the C-programs, we use EIF_OBJ and char * to indicate
direct(also called raw or unprotected) address; use EIF_REFERENCE
to indicate indirect(also called Eiffel or protected) address.
*****************************************************************/

#include "net.h"
#include "curextern.h"

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
		free_parameter_array(*arr, old_size); /* free old */
		*arr = (PARAMETER *)malloc(size * sizeof(PARAMETER));
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
		_concur_paras = (PARAMETER *)malloc(size * sizeof(PARAMETER));
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
/* not only free the space occured by the array, but also 
 * the space allocated to each cell to store string data.
*/
	EIF_INTEGER i;
	
	for(i=0; i<size; i++) {
		if (ary[i].str_len)
		/* there is a string buffer in the cell, free it */
			free(ary[i].str_val);
	}
	free(ary);
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
			para->str_val = (char *)malloc(constant_min_str_len);
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
				free(para->str_val);
			para->str_len = strlen(str) + 1 ;
			if (para->str_len < constant_min_str_len)
				para->str_len = constant_min_str_len ;
			para->str_val = (char *)malloc(para->str_len);
			valid_memory(para->str_val);
		}
		strcpy(para->str_val, str);
	}
	return;
}

EIF_POINTER get_c_format_of_eif_string(obj, field_name)
EIF_OBJ obj;
char *field_name;
{
/* get the C-string format of an Eiffel object's STRING field. */
	EIF_OBJ tmp_str;
	
	tmp_str = eif_field((obj), field_name, EIF_REFERENCE);
	return (eif_strtoc)((tmp_str));
}

/*
char *eif_str_to_c_str(eif_str)
EIF_OBJ eif_str;
{
--  get the C-string format of an Eiffel STRING object 
	EIF_FN_POINTER c_to_c;
	
	c_to_c = eif_fn_ref("to_c", str_dtype);
	return (c_to_c)((eif_str));
}
*/

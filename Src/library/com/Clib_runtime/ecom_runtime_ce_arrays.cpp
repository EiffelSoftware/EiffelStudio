//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1999.
//
//  File:		ecom_runtime_ce_arrays.c
//
//  Contents:	Runtime conversion functions from C to Eiffel 
//				
//--------------------------------------------------------------------------

#include "ecom_runtime_c_e.h"

//--------------------------------------------------------------------------

EIF_OBJECT ecom_runtime_ce::ccom_create_array (char * element_name, EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Create `dim_count' dimmensional array
{
	EIF_OBJECT eif_lower_indeces, eif_element_count, result;
	EIF_TYPE_ID type_id, int_array_id;
	EIF_PROCEDURE make, put;
	char * array_name;
	int i, element_name_lenth;
	EIF_INTEGER * lower_indeces;
	
	if (dim_count <= 0)
	{
		result = NULL;
	}
	else if (dim_count == 1)
	{
		element_name_lenth = strlen (element_name);
		array_name = (char *)malloc (9 + element_name_lenth);
		strcpy (array_name, "");
		strcat (array_name, "ARRAY [");
		strcat (array_name, element_name);
		strcat (array_name, "]");
		type_id = eif_type_id (array_name);
		free (array_name);
		make = eif_procedure ("make", type_id);
		result = eif_create (type_id);
		make (eif_access (result), 1, *element_count);
	}	
	else
	{
		// Create array of lower indeces
		int_array_id = eif_type_id ("ARRAY [INTEGER]");
		make = eif_procedure ("make", int_array_id);
		eif_lower_indeces = eif_create (int_array_id);
		make (eif_access (eif_lower_indeces), 1, dim_count);
		
		lower_indeces = (EIF_INTEGER *) calloc (dim_count, sizeof (EIF_INTEGER));
		for ( i = 0; i < dim_count; i++)
			lower_indeces [i] = 1;
		
		eif_make_from_c (eif_access (eif_lower_indeces), lower_indeces, dim_count, EIF_INTEGER);
		free (lower_indeces);
		
		// Create array of element counts
		eif_element_count = eif_create (int_array_id);
		make (eif_access (eif_element_count), 1, dim_count);
		
		eif_make_from_c (eif_access (eif_element_count), element_count, dim_count, EIF_INTEGER);
		
		// Create array
		element_name_lenth = strlen (element_name);
		array_name = (char *)malloc (14 + element_name_lenth);
		strcpy (array_name, "");
		strcat (array_name, "ECOM_ARRAY [");
		strcat (array_name, element_name);
		strcat (array_name, "]");
		type_id = eif_type_id (array_name);
		free (array_name);
		make = eif_procedure ("make", type_id);
		result = eif_create (type_id);
		make (eif_access (result), dim_count, eif_access (eif_lower_indeces), eif_access (eif_element_count));
	}
	return result;
};
//--------------------------------------------------------------------------

int ecom_runtime_ce::ccom_flat_index (int dim_count, int * element_count, int * index)

// In assumption that multidimmensional array is contiguous
// calculate flattened index from arrayed_index
{
	int result, inter_dim;
	int i, j;
			
	result = 0;
	for (i = 0; i < dim_count; i++)
	{
		inter_dim = 1;
		for (j = i + 1; j < dim_count; j++)
		{
			inter_dim = inter_dim * element_count[j];
		}
		result = result + index[i] * inter_dim;
	}
	return result;
};
//--------------------------------------------------------------------------

int ecom_runtime_ce::ccom_next_index (int dim_count, int * element_count, int * index)

// Generate next index
// Returns 0 if ther is no next index, i.e. array is traversed.
// Otherwise returns 1.
{
	int result, i;
	result = 0;
	i = dim_count - 1;
			
	while ((result == 0) && (i >= 0))
	{
		if (index[i] < element_count[i] - 1)
		{
			index[i] = index[i] + 1;
			result = 1;
		}
		else
		{
			index[i] = 0;
			i = i - 1;
		}
	}
	return result;
};
//-----------------------------------------------------------------------------

int ecom_runtime_ce::ccom_element_number (EIF_INTEGER dim_count, EIF_INTEGER * element_count)

// Calculate total number of elements in array
{
	int result, i;
	
	result = 1;
	for (i = 0; i < dim_count; i++)
	{
		result = result * element_count[i];
	}
	return result;
};
//-----------------------------------------------------------------------------

int ecom_runtime_ce::ccom_safearray_next_index (EIF_INTEGER dim_count, 
			EIF_INTEGER * lower_indeces, EIF_INTEGER * upper_indeces, EIF_INTEGER * index)

// Generate next index
// Returns 0 if ther is no next index, i.e. array is traversed.
// Otherwise returns 1.
{
	int result, i;
	result = 0;
	i = dim_count - 1;
			
	while ((result == 0) && (i >= 0))
	{
		if (index[i] < upper_indeces[i])
		{
			index[i] = index[i] + 1;
			result = 1;
		}
		else
		{
			index[i] = lower_indeces [i];
			i = i - 1;
		}
	}
	return result;
};
//--------------------------------------------------------------------------


//--------------------------------------------------------------------------


//--------------------------------------------------------------------------


//--------------------------------------------------------------------------

	
	
//--------------------------------------------------------------------------
	
	
	
//--------------------------------------------------------------------------



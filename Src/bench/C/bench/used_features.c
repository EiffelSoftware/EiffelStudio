#include <stdio.h>


char** used_features;

int size;


void init_table (int nb_classes)
{
	size = nb_classes + 1;
#ifdef DEBUG
	printf ("creating main table of size %d\n",size);
#endif
	used_features=(char**) malloc (size*sizeof(char*));
	memset ((void *) used_features, 0, size * sizeof (char *));
#ifdef DEBUG
	printf ("table created\n");
#endif
}


void init_sub_table (int class_id, int nb_feature_id)
{
	int size_of_bool_table;
#ifdef DEBUG
	printf ("initialising sub table for class %d, feature %d\n",class_id,nb_feature_id);
#endif
	size_of_bool_table = nb_feature_id / 8 + 1;
	used_features [class_id] = (char*) malloc (size_of_bool_table);
	memset ((void *) used_features [class_id],0, size_of_bool_table);
#ifdef DEBUG
	printf ("table created\n");
#endif
}


void clear_all ()
{
	int i;
#ifdef DEBUG
	printf ("clearing all\n");
#endif
	for (i=0; i<size; i++){
#ifdef DEBUG
		printf ("freeing subtable %d...",i);
#endif
		if (used_features [i]) 
			free (used_features [i]);
#ifdef DEBUG
		printf ("done\n");
#endif
	}
#ifdef DEBUG
	printf ("freeing main table...");
#endif
	free (used_features);
#ifdef DEBUG
	printf ("done\n");
	printf ("all cleared\n");
#endif
}
	

void set_feature_treated (int class_id, int  feature_id)
{
	int index;
	char value;
#ifdef DEBUG
	printf ("inserting feature %d of class %d\n", feature_id, class_id);
#endif
	index = feature_id / 8;
	value = 1 << (feature_id & 7);
	used_features [class_id][index] |= value;
#ifdef DEBUG
	printf ("feature inserted\n");
#endif
}


char is_treated (int class_id, int feature_id)
{
	int index;
	char value;
#ifdef DEBUG
	printf ("reading feature %d of class %d\n", feature_id, class_id);
#endif
	index = feature_id / 8;
	value = 1 << (feature_id & 7);
#ifdef DEBUG
	printf ("feature red\n");
#endif
	return ((used_features [class_id][index] & value) ? 1 : 0 );
}


/*
void main ()
{
	init_table (4);
	init_sub_table (2,98);
	set_feature_treated (2,22);
	printf ("utilisation de la feature: %d\n",is_treated(2,21));
	clear_all;
}
*/	

	



void init_table (int nb_classes);
/* initialise the table of used features */
/* arguments: number of classes of the system */


void init_sub_table (int class_id, int nb_feature_id);
/* initialise the subtable correponding to a class */
/* arguments: id of the class, id of the feature */

void clear_all ();
/* free all the structures */

void set_feature_treated (int class_id, int  feature_id);
/* put the flag corresponding to the feature number 
   feature_id in the class class_id */

char is_treated (int class_id, int feature_id);
/* give a boolean saying if the feature has been treated */




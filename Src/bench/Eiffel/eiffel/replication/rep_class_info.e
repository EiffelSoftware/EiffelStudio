-- Hash table indexed by written_in where the s_rep_name_list
-- has been formulated

class REP_CLASS_INFO 

inherit

	LINKED_LIST [S_REP_NAME_LIST]
		rename
			make as ll_make
		end;
	IDABLE
		undefine
			twin
		end;

creation

	make

feature 

	id: INTEGER;

	set_id (i:INTEGER) is
		do
			id := i
		end;

	make (class_id: INTEGER) is
		require
			valid_arg1: class_id > 0;
		do
			ll_make;
			id := class_id;
		end;

end

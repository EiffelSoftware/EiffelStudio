class USED_TABLE 

inherit

	SEARCH_TABLE [INTEGER]
		rename
			make as search_table_make
		end;
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end

creation

	make
	
feature 

	make is
			-- Creation of the array
		do
			search_table_make (System.body_id_counter.total_count);
		end;

end

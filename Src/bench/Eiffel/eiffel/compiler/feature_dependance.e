class FEATURE_DEPENDANCE

inherit

	SORTED_SET [DEPEND_UNIT]
		rename
			make as sorted_set_make,
			wipe_out as sorted_set_wipe_out
		end;
	SORTED_SET [DEPEND_UNIT]
		redefine
			make, wipe_out
		select
			make, wipe_out
		end;

creation

	make

feature

	suppliers: SORTED_SET [INTEGER];
		-- Ids of the suppliers for the feature

	add_supplier (a_class_id: INTEGER) is
		do
			suppliers.add (a_class_id)
		end;

	make is 
		do
			sorted_set_make;
			!!suppliers.make;
		end;

	wipe_out is 
		do
			sorted_set_wipe_out;
			suppliers.wipe_out;
		end;

end

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
			-- Set of all the syntactical suppliers of the feature

	add_supplier (a_class: CLASS_C) is
			-- Add the class to the list of suppliers
		require
			good_argument: a_class /= Void
		do
			suppliers.add (a_class.id)
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

feature -- Debug

	trace is
		do
			from
				start
			until
				after
			loop
				item.trace;
				forth
			end;
		end;

end

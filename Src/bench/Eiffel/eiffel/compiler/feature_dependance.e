class FEATURE_DEPENDANCE

inherit

	SORTED_SET [DEPEND_UNIT]
		rename
			make as sorted_set_make,
			wipe_out as sorted_set_wipe_out,
			twin as basic_twin
		end;
	SORTED_SET [DEPEND_UNIT]
		redefine
			make, wipe_out, twin
		select
			make, wipe_out, twin
		end;
	SHARED_WORKBENCH
		undefine
			twin
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

	twin: like Current is
		do
			Result := basic_twin;
			Result.set_suppliers (suppliers.twin);
		end;

	set_suppliers (new_suppliers: like suppliers) is
		do
			suppliers := new_suppliers
		end;

feature -- Incrementality

	has_removed_id: BOOLEAN is
			-- One of thesuppliers has been removed from the system?
		do
			from
				suppliers.start
			until
				suppliers.after or else Result
			loop
				if System.class_of_id (suppliers.item) = Void then
					Result := True
				end;
				suppliers.forth
			end;
			from
				start
			until
				after or else Result
			loop
				if System.class_of_id (item.id) = Void then
					Result := True
				end;
				forth
			end;
		end;

feature -- Debug

	trace is
		do
			io.error.putstring("Suppliers%N");
			from
				suppliers.start
			until
				suppliers.after
			loop
				io.error.putstring ("Supplier id: ");
				io.error.putint (suppliers.item);
				io.error.new_line;
				suppliers.forth
			end;
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

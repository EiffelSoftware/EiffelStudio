class FEATURE_DEPENDANCE

inherit

	TWO_WAY_SORTED_SET [DEPEND_UNIT]
		rename
			make as sorted_set_make,
			wipe_out as sorted_set_wipe_out,
			copy as basic_copy
		end
	TWO_WAY_SORTED_SET [DEPEND_UNIT]
		redefine
			make, wipe_out, copy
		select
			make, wipe_out, copy
		end
	SHARED_WORKBENCH
		undefine
			copy
		end
	COMPILER_EXPORTER
		redefine
			copy
		end

creation

	make

feature

	suppliers: TWO_WAY_SORTED_SET [CLASS_ID]
			-- Set of all the syntactical suppliers of the feature

	add_supplier (a_class: CLASS_C) is
			-- Add the class to the list of suppliers
		require
			good_argument: a_class /= Void
		do
			suppliers.extend (a_class.id)
		end;

	make is 
		do
			sorted_set_make
			compare_objects
			!!suppliers.make
			suppliers.compare_objects
		end;

	wipe_out is 
		do
			sorted_set_wipe_out
			suppliers.wipe_out
		end;

	copy (other: like Current) is
		do
			basic_copy (other)
			set_suppliers (clone (suppliers))
		end

	set_suppliers (new_suppliers: like suppliers) is
		do
			suppliers := new_suppliers
		end;

	feature_name: STRING
			-- name of the feature for which we have the dependances
	
	set_feature_name (name: STRING) is
		do
			feature_name := name
		end

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
				suppliers.item.trace;
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

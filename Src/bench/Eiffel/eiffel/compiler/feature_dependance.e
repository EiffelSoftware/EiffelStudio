class FEATURE_DEPENDANCE

inherit

	TWO_WAY_SORTED_SET [DEPEND_UNIT]
		redefine
			make, wipe_out, copy, is_equal
		end
	SHARED_WORKBENCH
		undefine
			copy, is_equal
		end
	COMPILER_EXPORTER
		redefine
			copy, is_equal
		end

creation

	make

feature

	suppliers: TWO_WAY_SORTED_SET [INTEGER]
			-- Set of all the syntactical suppliers of the feature

	add_supplier (a_class: CLASS_C) is
			-- Add the class to the list of suppliers
		require
			good_argument: a_class /= Void
		do
			suppliers.extend (a_class.class_id)
		end;

	make is 
		do
			Precursor {TWO_WAY_SORTED_SET}
			compare_objects
			create suppliers.make
		end;

	wipe_out is 
		do
			Precursor {TWO_WAY_SORTED_SET}
			suppliers.wipe_out
		end;

	copy (other: like Current) is
		do
			Precursor {TWO_WAY_SORTED_SET} (other)
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

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := active = other.active and then after = other.after and then
						before = other.before and then count = other.count and then
						feature_name = other.feature_name and then
						first_element = other.first_element and then
						last_element = other.last_element and then
						object_comparison = other.object_comparison and then
						sublist = other.sublist
			Result := Result and then equal (suppliers, other.suppliers)
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
				if System.class_of_id (item.class_id) = Void then
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

indexing

	description: 
		"AST representation for the supplier type set of a class.";
	date: "$Date$";
	revision: "$Revision$"

class SUPPLIERS_AS

inherit

	AST_EIFFEL
		redefine
			pass_address
		end

creation

	make

feature {NONE} -- Initialization

	set is 
			-- Yacc/Eiffel interface
		do
		end; 

feature -- Properties

	supplier_ids: TWO_WAY_SORTED_SET [ID_AS];
			-- Set of supplier class names

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Do nothing.
		do
		end;

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		local
			o_supplier_ids: like supplier_ids
		do
			o_supplier_ids := other.supplier_ids
			if supplier_ids.count = o_supplier_ids.count then
					-- Same count and subset means equal
				Result := supplier_ids.is_subset (o_supplier_ids)
			end
		end

feature {NONE}

	make is
		do
			!!supplier_ids.make;
			supplier_ids.compare_objects
		end;

	insert_supplier_id (id: ID_AS) is
			-- Insert a new supplier name in `supplier_ids', if
			-- not already present.
		require
			good_argument: id /= Void
		do
			supplier_ids.extend (id);
		end; 

feature {COMPILER_EXPORTER}

	pass_address (n: INTEGER) is
			-- Yacc/Eiffel interface
		do
			c_get_address (n, $Current, $make);
			c_get_set_put ($insert_supplier_id);
		end;

feature {NONE} -- Externals

	c_get_set_put (ptr: POINTER) is
		external
			"C"
		end;

end -- class SUPPLIERS_AS

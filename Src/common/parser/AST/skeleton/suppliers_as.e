indexing

	description: "Abstract description for the supplier type set of a class.";
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

feature

	supplier_ids: TWO_WAY_SORTED_SET [ID_AS];
			-- Set of supplier class names

	make is
		do
			!!supplier_ids.make;
		end;

	pass_address (n: INTEGER) is
			-- Yacc/Eiffel interface
		do
			c_get_address (n, $Current, $make);
			c_get_set_put ($insert_supplier_id);
		end;

	insert_supplier_id (id: ID_AS) is
			-- Insert a new supplier name in `supplier_ids', if
			-- not already present.
		require
			good_argument: id /= Void
		do
			supplier_ids.extend (id);
		end; 

	set is 
			-- Yacc/Eiffel interface
		do
			-- Do nothing
		end; -- set

feature {NONE} -- Externals

	c_get_set_put (ptr: POINTER) is
		external
			"C"
		end;

end -- class SUPPLIERS_AS

indexing

	description:
			"Abstract description for the supplier type set of a %
			%class. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class SUPPLIERS_AS_B

inherit

	SUPPLIERS_AS
		redefine
			supplier_ids, insert_supplier_id
		end;

	AST_EIFFEL_B
		undefine
			pass_address
		end

creation

	make

feature

	supplier_ids: TWO_WAY_SORTED_SET [ID_AS_B];
			-- Set of supplier class names

	insert_supplier_id (id: ID_AS_B) is
			-- Insert a new supplier name in `supplier_ids', if
			-- not already present.
		require else
			good_argument: id /= Void
		do
			supplier_ids.extend (id);
		end; 

end -- class SUPPLIERS_AS_B

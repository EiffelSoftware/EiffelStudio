indexing

	description:
			"Abstract description for the supplier type set of a %
			%class. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class SUPPLIERS_AS

inherit
	AST_EIFFEL

creation
	make, initialize

feature {AST_FACTORY} -- Initialization

	initialize is
			-- Create a new SUPPLIERS AST node.
		do
			!! supplier_ids.make
			supplier_ids.compare_objects
		end

feature {NONE} -- Initialization

	make is
		do
			!!supplier_ids.make
			supplier_ids.compare_objects
		end

feature -- Attributes

	supplier_ids: TWO_WAY_SORTED_SET [ID_AS]
			-- Set of supplier class names

	insert_supplier_id (id: ID_AS) is
			-- Insert a new supplier name in `supplier_ids', if
			-- not already present.
		require else
			good_argument: id /= Void
		do
			supplier_ids.extend (id)
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

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Do nothing.
		do
		end

end -- class SUPPLIERS_AS

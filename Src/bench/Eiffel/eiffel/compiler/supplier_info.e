-- Description of a supplier

class
	SUPPLIER_INFO 

inherit
	SHARED_WORKBENCH

creation

	make

feature 

	supplier_id: INTEGER;
			-- Supplier

	supplier: CLASS_C is
			-- Corresponding class of id `supplier_id'
		do
			Result := System.class_of_id (supplier_id)
		end

	occurrence: INTEGER;
			-- Occurrence of the supplier in the class

	set_occurrence (i: INTEGER) is
			-- Assign `i' to `occurrence'.
		do
			occurrence := i;
		end;

	make (cl_id: like supplier_id) is
			-- Initialization
		require
			good_argument: cl_id > 0
		do
			supplier_id := cl_id
			occurrence := 1
		end;

	add_occurrence is
			-- Increment `occurrence' of 1.
		do
			occurrence := occurrence + 1;
		end;

	remove_occurrence is
			-- Decrement `occurrence' of 1.
		require
			good_occurrence: occurrence >= 1;
		do
			occurrence := occurrence - 1;
		end;

end

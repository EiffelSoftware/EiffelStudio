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

	occurence: INTEGER;
			-- Occurence of the supplier in the class

	set_occurence (i: INTEGER) is
			-- Assign `i' to `occurence'.
		do
			occurence := i;
		end;

	make (cl_id: like supplier_id) is
			-- Initialization
		require
			good_argument: cl_id > 0
		do
			supplier_id := cl_id
			occurence := 1
		end;

	add_occurence is
			-- Increment `occurence' of 1.
		do
			occurence := occurence + 1;
		end;

	remove_occurence is
			-- Decrement `occurence' of 1.
		require
			good_occurence: occurence >= 1;
		do
			occurence := occurence - 1;
		end;

end

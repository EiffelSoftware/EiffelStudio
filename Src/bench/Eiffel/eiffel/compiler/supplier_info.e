-- Description of a supplier

class SUPPLIER_INFO 

creation

	make

feature 

	supplier: CLASS_C;
			-- Supplier

	occurence: INTEGER;
			-- Occurence of the supplier in the class

	set_occurence (i: INTEGER) is
			-- Assign `i' to `occurence'.
		do
			occurence := i;
		end;

	make (cl: like supplier) is
			-- Initialization
		require
			good_argument: cl /= Void
		do
			supplier := cl;
			occurence := 1;
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

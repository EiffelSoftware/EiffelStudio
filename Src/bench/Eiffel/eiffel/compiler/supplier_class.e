class SUPPLIER_CLASS

inherit

	ANY
		redefine
			is_equal
		end

creation

	make

feature -- Attributes

	supplier: CLASS_C;
			-- Supplier class

	supplier_name: STRING;
			-- Supplier name 
			--| Could be different of `supplier.name' because
			--| of renamings of LACE

	make (c: CLASS_C; s: STRING) is
			-- Initialization
		require
			good_argument1: c /= Void;
			good_argument2: s /= Void;
		do
			supplier := c;
			supplier_name := s;
		end;

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current ?
		do
			Result := supplier = other.supplier;
		end;

invariant

	supplier_exists: supplier /= Void;
	supplier_name_exists: supplier_name /= Void;

end

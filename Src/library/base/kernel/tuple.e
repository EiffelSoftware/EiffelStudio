-- Experimental TUPLE class. Do not modify!
-- Indexing clauses and comments will not
-- be provided until design is finished.

class   TUPLE

inherit
	ARRAY [ANY]
		rename
			make as array_make
		end

creation
	make

feature -- Creation

	make is

		do
			array_make (1, eif_gen_count ($Current))
		end

feature {NONE} -- Implementation

	eif_gen_count (obj : POINTER) : INTEGER is
		-- Number of generic parameters of `Currentï.
		external
			"C | %"eif_gen_conf.h%""
		end

end -- class TUPLE


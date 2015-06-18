note
	description: "Example application that shows how Gaussian elimination can be solved with futures."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	GAUSS_APPLICATION

create
	make

feature -- Predefined matrices.

	normal_matrix: ARRAY [ARRAY [DOUBLE]]
		attribute
			Result :=
				<<
				<<  2,  1, -1,  8 >>,
				<< -3, -1,  2, -11>>,
				<< -2,  1,  2, -3 >>
				>>
		end

	last_row_zero: ARRAY [ARRAY [DOUBLE]]
		attribute
			Result :=
				<<
				<< 1,  3,  1,  9 >>,
				<< 1,  1, -1,  1 >>,
				<< 3, 11, 5,  35 >>
				>>
		end

	zero_pivot: ARRAY [ARRAY [DOUBLE]]
		attribute
			Result :=
				<<
				<< 0,  2,  3,  4 >>,
				<< 1,  1,  1,  2 >>,
				<< 3,  3,  1,  0 >>
				>>
		end

	singular_matrix: ARRAY [ARRAY [DOUBLE]]
		attribute
			Result :=
				<<
				<< 1,  1,  1,  2 >>,
				<< 1,  1,  1,  3 >>,
				<< 1,  1,  1,  4 >>
				>>
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			system: FUTURE_GAUSS_ELIMINATION
		do
			create system.make_from_array (normal_matrix)

			print ("Starting Gaussian Elimination example...%N")
			print ("Linear equation system to be solved:%N%N")
			print (system)

			system.solve

			print ("%NResult:%N%N")
			print (system)
			print ("%N")
		end

end

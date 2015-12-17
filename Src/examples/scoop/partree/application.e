note
	description: "scoopex1 application root class"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization

	make
		do
			tree_stuff
		end

	list_size: INTEGER = 5

	tree_stuff
			--
		local
			list: SPECIAL [INTEGER]
		do
			create list.make_filled (0, list_size)
			tree_stuff_imp (list)
		end

	tree_stuff_imp (a_list: separate SPECIAL [INTEGER])
		local
			lefty, righty: separate ADDER_LEAF
			i: INTEGER
			tre: ADDER_BRANCH
			l_function: FUNCTION [INTEGER, INTEGER, INTEGER]
		do


			from i := 0 until i >= list_size loop
				a_list [i] := i
				i := i + 1
			end

			create lefty.make (a_list)
			create righty.make (a_list)
			create tre.make (lefty,righty)

			tre.compute (0)
			print (tre.comp_result)

			l_function := agent (x,y: INTEGER): INTEGER
					do Result := x + y end

			tre.compute_agents (0, agent addf, l_function)
			print (tre.comp_result)
		end

	addf (x: INTEGER): INTEGER
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000000)
			Result := x + 1
		end

	make_c (a_x, a_y: separate S): separate CONC
		do
			create Result.make (a_x,a_y)
		end

	run_both (c1, c2: separate CONC)
		do
			c1.f
			c2.f
		end

end

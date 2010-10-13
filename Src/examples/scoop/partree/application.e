indexing
	description : "scoopex1 application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

create
	make

feature {NONE} -- Initialization
	make
		do
			tree_stuff
		end

	list_size : INTEGER = 5

	tree_stuff
		local
			lefty, righty : attached separate ADDER_LEAF
			list : SPECIAL [INTEGER]
			i : INTEGER
			tre : ADDER_BRANCH
		do
			create list.make (list_size)

			from i := 0 until i >= list_size loop
				list [i] := i
				i := i + 1
			end

			create lefty.make (list)
			create righty.make (list)
			create tre.make (lefty,righty)
			
			tre.compute (0)
			print (tre.comp_result)

			tre.compute_agents (0, agent addf,
				agent (x,y : INTEGER) : INTEGER 
					do Result := x + y end)
			print (tre.comp_result)
		end
	
	addf (x : INTEGER) : INTEGER
		do
			(create {EXECUTION_ENVIRONMENT}).sleep (1000000000)
			Result := x + 1
		end


	make_c (a_x, a_y : attached separate S) : attached separate CONC
		do
			create Result.make (a_x,a_y)
		end

	run_both (c1, c2 : attached separate CONC)
		do
			c1.f
			c2.f
		end

end

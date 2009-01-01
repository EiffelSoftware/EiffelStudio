indexing
	description	: "System's root class"

class
	TEST

create
	make 

feature -- Initialization
	
	
	make is
		do
		end
	
	tests_simple is
		local
			f1: FUNCTION [ANY, TUPLE, INTEGER]
			f2: FUNCTION [ANY, TUPLE [STRING, STRING], STRING]
			p1: PROCEDURE [ANY, TUPLE]
			p2: PROCEDURE [ANY, TUPLE [STRING, STRING]]
		do
		end
	
		
	test_agents_on_attributes_and_externals is
		do
			print ("Externals, we expect 100 and get: " + (agent get_a_c_int).item ([]).out)
			io.new_line			
		end

	a: INTEGER
	
	frozen get_a_c_int: INTEGER is
		external
			"C inline"
		alias
			"[
				return 100
			]"
		end

	test_procedure_with_locals is
		local
			p: PROCEDURE [ANY, TUPLE [INTEGER, STRING]]
		do
		end
		
	test_sortable_array is
		local
			a_int: I_SORTABLE_ARRAY [INTEGER]
			a_string: I_SORTABLE_ARRAY [STRING]
		do
		end
		

end -- class ROOT_CLASS


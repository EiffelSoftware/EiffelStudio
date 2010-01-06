indexing
	description	: "System's root class"

class
	TEST

create
	make 

feature -- Initialization
	
	
	make is
		do
			print ("Simple tests:%N")
			tests_simple
			
			print ("Function: %N")
			test_function_hard
			
			print ("Exceptions in inline functions:%N")
			test_func_exception
			
			print ("Exceptions in inline procedures:%N")
			test_proc_exception
			
			print ("Agents on attributes and externals:%N")
			test_agents_on_attributes_and_externals
			
			print ("Locals in inline agents:%N")
			test_procedure_with_locals

			print ("Sortable array:%N")
			test_sortable_array
			
			agent_on_parameter (Current)

			print ("END%N")
		end
	
	tests_simple is
		local
			f1: FUNCTION [ANY, TUPLE, INTEGER]
			f2: FUNCTION [ANY, TUPLE [STRING, STRING], STRING]
			p1: PROCEDURE [ANY, TUPLE]
			p2: PROCEDURE [ANY, TUPLE [STRING, STRING]]
		do
			f1 := agent: INTEGER
				do
					Result := 100
				end
			print (f1.item ( []).out)
			io.new_line
			print ("Checkpoint 1%N")
			
			f2 := agent (s1, s2: STRING): STRING
				do
					Result := s1 + s2
				end
			print (f2.item ( ["Hello", "World"]).out)
			io.new_line
			print ("Checkpoint 2%N")
			
			p1 := agent 
				do
					print ("p1 called%N")
				end
			p1.apply
			print ("Checkpoint 3%N")

			p2 := agent (s1, s2: STRING)
				do
					print ("p2 called with: " + s1 + " and " + s2 + "%N")
				end
			p2.set_operands ( ["Hello", "World"])
			p2.apply
			print ("Checkpoint 4%N")				
		end
	
	test_function_hard is
		do
			print (
				(agent: FUNCTION [ANY, TUPLE [STRING], STRING]
							do
								Result := (agent (s1, s2: STRING): STRING
									do
										Result := s1 + "_" + s2
									end ("inner", ?))
							end).item ( []).item (["outer"])
			)
			io.new_line
		end
		
	test_func_exception is
		local
			done: BOOLEAN
		do
			if not done then
				print (
					(agent (s: STRING): STRING
						do
							Result := s + ""	--violation if s = Void!
						end).item ( [Void]))
						
				print ("No violation...%N")
			end
		rescue
			print ("Got violation. Ok%N")
			done := True
			retry
		end

	test_proc_exception is
		local
			done: BOOLEAN
		do
			if not done then
				(agent (s: STRING)
					do
						print (s + "")	--violation if s = Void!
					end).apply
						
				print ("No violation...%N")
			end
		rescue
			print ("Got violation. Ok%N")
			done := True
			retry
		end
		
	test_agents_on_attributes_and_externals is
		do
			a := 100
			print ("Attributes, we expect 100 and get: " + (agent a).item ([]).out)
			io.new_line
			
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
			p := agent (a_1, a_2: INTEGER; a_3, a_4: STRING) 
				require 
					a_1 > 0 and a_2 > 0
				local
					l_1, l_2: INTEGER
					l_3, l_4: STRING
				do
					l_1 := a_1
					l_2 := a_2
					l_3 := a_3
					l_4 := a_4
					print ("l_1: " + l_1.out + "%N")
					print ("l_2: " + l_2.out + "%N")
					print ("l_3: " + l_3 + "%N")
					print ("l_4: " + l_4 + "%N")
				end (10, ?, "hallo", ?)
				
			p.set_operands ( [20, "welt"])
			p.apply
		end
	
	test_sortable_array is
		local
			a_int: I_SORTABLE_ARRAY [INTEGER]
			a_string: I_SORTABLE_ARRAY [STRING]
		do
			create a_int.make (1, 5)
			a_int.put (3, 1)
			a_int.put (1, 2)
			a_int.put (20, 3)
			a_int.put (10, 4)
			a_int.put (100, 5)
			a_int.sort
			a_int.do_all (agent (item: INTEGER) do print (item.out + "%N") end)
			io.new_line
			create a_string.make (1, 4)
			a_string. put("wow", 1)
			a_string. put("aba", 2)
			a_string. put("dudu", 3)
			a_string. put("1", 4)
			a_string.sort
			a_string.do_all (agent (item: STRING) do print (item  + "%N") end)
			io.new_line
		end

	agent_on_parameter (c: TEST) is
		do
			(agent c.f).call ([])
		end

	f is
		do
			print ("hallo from agent created in agent_on_parameter%N")
		end
		

end -- class TEST


indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	LINKED_LIST [STRING]
		redefine make end

create make

feature
	
	neutral (ni: INTEGER) is do end

	make is
		local
			a1: A [INTEGER]
			a2: A [STRING]
		do
			neutral ($MELT6)
			create a1
			io.new_line

			a1.f1 (1)
			io.new_line
			a1.f2 (2)
			create a2
			io.new_line
			a2.f1 ("3")
			io.new_line
			a2.f2 ("4")

			io.new_line

			a1.receive_f (
				(agent (i: INTEGER; g: INTEGER): INTEGER 
					do
						Result := i + g
					end), 10, 90)

			a1.receive_p (
				(agent (i: INTEGER; g: INTEGER)
					do
						print ("got: " + i.out + ", " + g.out)
					end), 10, 90)

			a2.receive_f (
				(agent (i: INTEGER; g: STRING): STRING
					do
						Result := i.out + g
					end), 10, "91")

			a2.receive_p (
				(agent (i: INTEGER; g: STRING)
					do
						print ("got: " + i.out + ", " + g)
					end), 10, "91")

			io.new_line

			receive_a (a2)

			io.new_line

			print ("List count: ")
			print ((agent count).item ([]))
			io.new_line;
			extend ("str1")
			(agent extend).call (["String"])
			print ("List count2: ")
			print ((agent count).item ([]))
			io.new_line
			gen_caller (["String"], (agent extend))
			gen_caller ([], agent start)
			print ((agent item.out).item ([]))
			io.new_line
			
			print (gen_item (["STRING"], agent (s: STRING): STRING do Result := s end))

				-- To satisfy the postcondition of LINKED_LIST.
			wipe_out
		end

	receive_a (a: A[STRING]) is
		do
			print ("receive_a%N")
			(agent a.receive_p).call(
				[
				(agent (i: INTEGER; g: STRING)
					do
						print ("got: " + i.out + ", " + g)
						neutral ($MELT7)
					end), 
				10, "92"])
			io.new_line;
			(agent {A [STRING]}.receive_p).call (
				[
				a,
				(agent (i: INTEGER; g: STRING)
					do
						print ("got: " + i.out + ", " + g)
						neutral ($MELT8)
					end), 
				10, "92"])
		end

	gen_caller (t: TUPLE; p: PROCEDURE [ANY, TUPLE]) is
		local
			l_p: PROCEDURE [ANY, TUPLE]
		do
			neutral ($MELT9)
			l_p := p
			if l_p.valid_operands (t) then
				p.call (t)
				l_p.call (t)
			end
		end

	gen_item (t: TUPLE; p: FUNCTION [ANY, TUPLE, STRING]): STRING is
		local
			l_f: FUNCTION [ANY, TUPLE, STRING]
		do
			neutral ($MELT10)
			l_f := p
			if l_f.valid_operands (t) then
				p.call (t)
				Result := p.item (t)
			end
		end

end

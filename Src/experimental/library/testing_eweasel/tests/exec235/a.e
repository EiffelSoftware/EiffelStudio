indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	A [G]

feature
	neutral (i: INTEGER) is do end

	f1 (a_g: G) is
		do
			neutral ($MELT1)
			io.new_line;
			(agent p).call ([a_g])
		end

	f2 (a_g: G) is
		do
			neutral ($MELT2)
			io.new_line;
			(agent (a_g2: G) 
				do 
					print (a_g2.out) 
					io.new_line
				end).call ([a_g])
		end

	p (a_g: G) is
		do
			neutral ($MELT3)
			io.new_line
			print (a_g.out)
			io.new_line
		end

	receive_f (a_f: FUNCTION [ANY, TUPLE [INTEGER, G], G]; a1: INTEGER; a2: G) is
		local
			t: TUPLE [INTEGER, G]
		do
			neutral ($MELT4)
			t := [a1, a2]
			print (a_f.item ([a1, a2]).out)
			io.new_line
			print (a_f.item (t).out)
			io.new_line
			a_f.call ([a1, a2])
			print (a_f.last_result)
			a_f.call (t)
			print (a_f.last_result)
			io.new_line
		end

	receive_p (a_p: PROCEDURE [ANY, TUPLE [INTEGER, G]]; a1: INTEGER; a2: G) is
		local
			t: TUPLE [INTEGER, G]
		do
			neutral ($MELT5)
			t := [a1, a2]
			a_p.call ([a1, a2])
			io.new_line
			a_p.call (t)
			io.new_line
		end


end

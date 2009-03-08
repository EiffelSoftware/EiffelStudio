class
	TEST

create
	make

feature

	make is
		local
			o: SYSTEM_OBJECT
			r_64: REAL_64
			r_32: REAL_32
			i_64: INTEGER_64
			i_32: INTEGER_32
			i_16: INTEGER_16
			i_8: INTEGER_8
			n_64: NATURAL_64
			n_32: NATURAL_32
			n_16: NATURAL_16
			n_8: NATURAL_8
			b: BOOLEAN
			p: POINTER
		do
			o := r_64
			if not attached {REAL_64} o as v then
				print ("Failure%N")
			end
			o := r_32
			if not attached {REAL_32} o as v then
				print ("Failure%N")
			end
			o := i_64
			if not attached {INTEGER_64} o as v then
				print ("Failure%N")
			end
			o := i_32
			if not attached {INTEGER_32} o as v then
				print ("Failure%N")
			end
			o := i_16
			if not attached {INTEGER_16} o as v then
				print ("Failure%N")
			end
			o := i_8
			if not attached {INTEGER_8} o as v then
				print ("Failure%N")
			end
			o := n_64
			if not attached {NATURAL_64} o as v then
				print ("Failure%N")
			end
			o := n_32
			if not attached {NATURAL_32} o as v then
				print ("Failure%N")
			end
			o := n_16
			if not attached {NATURAL_16} o as v then
				print ("Failure%N")
			end
			o := n_8
			if not attached {NATURAL_8} o as v then
				print ("Failure%N")
			end
			o := b
			if not attached {BOOLEAN} o as v then
				print ("Failure%N")
			end
			o := p
			if not attached {POINTER} o as v then
				print ("Failure%N")
			end
		end

end


--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make
feature
	make is 
		do 
			sub1
			io.new_line
			sub2
		end
	
	x: INTEGER
	
	sub1 is 
		do 
			$INSTRUCTION
			try_integer_8 (i8)
			try_integer_8 (i16.to_integer_8)
			try_integer_8 (i64.to_integer_8)
			try_integer_8 (i.to_integer_8)
			try_integer_8 (r.rounded.to_integer_8)
			try_integer_8 (d.rounded.to_integer_8)
			
			try_integer_16 (i8)
			try_integer_16 (i16)
			try_integer_16 (i64.to_integer_16)
			try_integer_16 (i.to_integer_16)
			try_integer_16 (r.rounded.to_integer_16)
			try_integer_16 (d.rounded.to_integer_16)
			
			try_integer_64 (i8)
			try_integer_64 (i16)
			try_integer_64 (i64)
			try_integer_64 (i)
			try_integer_64 (r.rounded)
			try_integer_64 (d.rounded)
			
			try_integer (i8)
			try_integer (i16)
			try_integer (i64.to_integer)
			try_integer (i)
			try_integer (r.rounded.to_integer)
			try_integer (d.rounded.to_integer)
			
			try_real (i8)
			try_real (i16)
			try_real (i64)
			try_real (i)
			try_real (r)
			try_real (d.truncated_to_real)
			
			try_double (i8)
			try_double (i16)
			try_double (i64)
			try_double (i)
			try_double (r)
			try_double (d)
		end

	sub2 is 
		do 
			$INSTRUCTION
			(agent try_integer_8).call ([i8])
			(agent try_integer_8).call ([i16.to_integer_8])
			(agent try_integer_8).call ([i64.to_integer_8])
			(agent try_integer_8).call ([i.to_integer_8])
			(agent try_integer_8).call ([r.rounded.to_integer_8])
			(agent try_integer_8).call ([d.rounded.to_integer_8])
			
			(agent try_integer_16).call ([i8.to_integer_16])
			(agent try_integer_16).call ([i16])
			(agent try_integer_16).call ([i64.to_integer_16])
			(agent try_integer_16).call ([i.to_integer_16])
			(agent try_integer_16).call ([r.rounded.to_integer_16])
			(agent try_integer_16).call ([d.rounded.to_integer_16])
			
			(agent try_integer_64).call ([i8.to_integer_64])
			(agent try_integer_64).call ([i16.to_integer_64])
			(agent try_integer_64).call ([i64])
			(agent try_integer_64).call ([i.to_integer_64])
			(agent try_integer_64).call ([r.rounded.to_integer_64])
			(agent try_integer_64).call ([d.rounded.to_integer_64])
			
			(agent try_integer).call ([i8.to_integer])
			(agent try_integer).call ([i16.to_integer])
			(agent try_integer).call ([i64.to_integer])
			(agent try_integer).call ([i])
			(agent try_integer).call ([r.rounded.to_integer])
			(agent try_integer).call ([d.rounded.to_integer])
			
			(agent try_real).call ([i8.to_real])
			(agent try_real).call ([i16.to_real])
			(agent try_real).call ([i64.to_real])
			(agent try_real).call ([i.to_real])
			(agent try_real).call ([r])
			(agent try_real).call ([d.truncated_to_real])
			
			(agent try_double).call ([i8.to_double])
			(agent try_double).call ([i16.to_double])
			(agent try_double).call ([i64.to_double])
			(agent try_double).call ([i.to_double])
			(agent try_double).call ([r.to_double])
			(agent try_double).call ([d])
		end
	try_integer_8 (n: INTEGER_8) is
		do
			print (n); io.new_line
		end
	
	try_integer_16 (n: INTEGER_16) is
		do
			print (n); io.new_line
		end
	
	try_integer_64 (n: INTEGER_64) is
		do
			print (n); io.new_line
		end
	
	try_integer (n: INTEGER) is
		do
			print (n); io.new_line
		end
	
	try_real (n: REAL) is
		do
			print (n); io.new_line
		end
	
	try_double (n: DOUBLE) is
		do
			print (n); io.new_line
		end
	
	i8: INTEGER_8 is 64
	i16: INTEGER_16 is 64
	i64: INTEGER_64 is 64
	i: INTEGER is 64
	r: REAL is 
		do 
			Result := {REAL_32} 64.0
		end
	d: DOUBLE is 64.0
end

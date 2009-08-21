
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	TEST1 [INTEGER, REAL, DOUBLE]
		
creation
	make
feature

	make is
		do
			initialize
			
			io.put_string ("%NSection 1%N")
			print (i1); io.new_line
			print (i2); io.new_line
			print (i3); io.new_line
			print (r1); io.new_line
			print (r2); io.new_line
			print (r3); io.new_line
			print (d1); io.new_line
			print (d2); io.new_line
			print (d3); io.new_line
			
			io.put_string ("%NSection 2%N")
			io.put_integer (i1); io.new_line
			io.put_integer (i2); io.new_line
			io.put_integer (i3); io.new_line
			io.put_integer (r1.rounded); io.new_line
			io.put_integer (r1.truncated_to_integer); io.new_line
			io.put_integer (r1.floor); io.new_line
			io.put_integer (r1.ceiling); io.new_line
			io.put_integer (r2.rounded); io.new_line
			io.put_integer (r2.truncated_to_integer); io.new_line
			io.put_integer (r2.floor); io.new_line
			io.put_integer (r2.ceiling); io.new_line
			io.put_integer (r3.rounded); io.new_line
			io.put_integer (r3.truncated_to_integer); io.new_line
			io.put_integer (r3.floor); io.new_line
			io.put_integer (r3.ceiling); io.new_line
			io.put_integer (d1.rounded); io.new_line
			io.put_integer (d1.truncated_to_integer); io.new_line
			io.put_integer (d1.truncated_to_real.rounded); io.new_line
			io.put_string ("%NSection 3%N")
			io.put_integer (d1.floor); io.new_line
			io.put_integer (d1.ceiling); io.new_line
			io.put_integer (d2.rounded); io.new_line
			io.put_integer (d2.truncated_to_integer); io.new_line
			io.put_integer (d2.truncated_to_real.rounded); io.new_line
			io.put_integer (d2.floor); io.new_line
			io.put_integer (d2.ceiling); io.new_line
			io.put_integer (d3.rounded); io.new_line
			io.put_integer (d3.truncated_to_integer); io.new_line
			io.put_integer (d3.truncated_to_real.rounded); io.new_line
			io.put_integer (d3.floor); io.new_line
			io.put_integer (d3.ceiling); io.new_line
			
			io.put_string ("%NSection 4%N")
			io.put_real (i1); io.new_line
			io.put_real (i2); io.new_line
			io.put_real (i3); io.new_line
			io.put_real (r1); io.new_line
			io.put_real (r2); io.new_line
			io.put_real (r3); io.new_line
			io.put_real (d1.truncated_to_real); io.new_line
			io.put_real (d2.truncated_to_real); io.new_line
			io.put_real (d3.truncated_to_real); io.new_line
			
			io.put_string ("%NSection 5%N")
			io.put_double (i1); io.new_line
			io.put_double (i2); io.new_line
			io.put_double (i3); io.new_line
			io.put_double (r1); io.new_line
			io.put_double (r2); io.new_line
			io.put_double (r3); io.new_line
			io.put_double (d1); io.new_line
			io.put_double (d2); io.new_line
			io.put_double (d3); io.new_line
			
			io.put_string ("%NSection 6%N")
			i := i1
			io.put_integer (i); io.new_line
			i := i2
			io.put_integer (i); io.new_line
			i := i3
			io.put_integer (i); io.new_line
			i := r1.rounded
			io.put_integer (i); io.new_line
			i := r2.rounded
			io.put_integer (i); io.new_line
			i := r3.rounded
			io.put_integer (i); io.new_line
			i := d1.rounded
			io.put_integer (i); io.new_line
			i := d2.rounded
			io.put_integer (i); io.new_line
			i := d3.rounded
			io.put_integer (i); io.new_line
			
			io.put_string ("%NSection 7%N")
			r := i1
			io.put_real (r); io.new_line
			r := i2
			io.put_real (r); io.new_line
			r := i3
			io.put_real (r); io.new_line
			r := r1
			io.put_real (r); io.new_line
			r := r2
			io.put_real (r); io.new_line
			r := r3
			io.put_real (r); io.new_line
			r := d1.truncated_to_real
			io.put_real (r); io.new_line
			r := d2.truncated_to_real
			io.put_real (r); io.new_line
			r := d3.truncated_to_real
			io.put_real (r); io.new_line
			
			io.put_string ("%NSection 8%N")
			d := i1
			io.put_double (d); io.new_line
			d := i2
			io.put_double (d); io.new_line
			d := i3
			io.put_double (d); io.new_line
			d := r1
			io.put_double (d); io.new_line
			d := r2
			io.put_double (d); io.new_line
			d := r3
			io.put_double (d); io.new_line
			d := d1
			io.put_double (d); io.new_line
			d := d2
			io.put_double (d); io.new_line
			d := d3
			io.put_double (d); io.new_line
			
			io.put_string ("%NSection 9%N")
			io.put_integer (i_to_i (i1)); io.new_line
			io.put_integer (i_to_i (i2)); io.new_line
			io.put_integer (i_to_i (i3)); io.new_line
			io.put_integer (i_to_i (r1.rounded)); io.new_line
			io.put_integer (i_to_i (r2.rounded)); io.new_line
			io.put_integer (i_to_i (r3.rounded)); io.new_line
			io.put_integer (i_to_i (d1.rounded)); io.new_line
			io.put_integer (i_to_i (d2.rounded)); io.new_line
			io.put_integer (i_to_i (d3.rounded)); io.new_line
			
			io.put_string ("%NSection 10%N")
			io.put_real (i_to_r (i1)); io.new_line
			io.put_real (i_to_r (i2)); io.new_line
			io.put_real (i_to_r (i3)); io.new_line
			io.put_real (i_to_r (r1.rounded)); io.new_line
			io.put_real (i_to_r (r2.rounded)); io.new_line
			io.put_real (i_to_r (r3.rounded)); io.new_line
			io.put_real (i_to_r (d1.rounded)); io.new_line
			io.put_real (i_to_r (d2.rounded)); io.new_line
			io.put_real (i_to_r (d3.rounded)); io.new_line
			
			io.put_string ("%NSection 11%N")
			io.put_double (i_to_d (i1)); io.new_line
			io.put_double (i_to_d (i2)); io.new_line
			io.put_double (i_to_d (i3)); io.new_line
			io.put_double (i_to_d (r1.rounded)); io.new_line
			io.put_double (i_to_d (r2.rounded)); io.new_line
			io.put_double (i_to_d (r3.rounded)); io.new_line
			io.put_double (i_to_d (d1.rounded)); io.new_line
			io.put_double (i_to_d (d2.rounded)); io.new_line
			io.put_double (i_to_d (d3.rounded)); io.new_line
			
			io.put_string ("%NSection 12%N")
			io.put_integer (r_to_i (i1)); io.new_line
			io.put_integer (r_to_i (i2)); io.new_line
			io.put_integer (r_to_i (i3)); io.new_line
			io.put_integer (r_to_i (r1)); io.new_line
			io.put_integer (r_to_i (r2)); io.new_line
			io.put_integer (r_to_i (r3)); io.new_line
			io.put_integer (r_to_i (d1.truncated_to_real)); io.new_line
			io.put_integer (r_to_i (d2.truncated_to_real)); io.new_line
			io.put_integer (r_to_i (d3.truncated_to_real)); io.new_line
			
			io.put_string ("%NSection 13%N")
			io.put_real (r_to_r (i1)); io.new_line
			io.put_real (r_to_r (i2)); io.new_line
			io.put_real (r_to_r (i3)); io.new_line
			io.put_real (r_to_r (r1)); io.new_line
			io.put_real (r_to_r (r2)); io.new_line
			io.put_real (r_to_r (r3)); io.new_line
			io.put_real (r_to_r (d1.truncated_to_real)); io.new_line
			io.put_real (r_to_r (d2.truncated_to_real)); io.new_line
			io.put_real (r_to_r (d3.truncated_to_real)); io.new_line
			
			io.put_string ("%NSection 14%N")
			io.put_double (r_to_d (i1)); io.new_line
			io.put_double (r_to_d (i2)); io.new_line
			io.put_double (r_to_d (i3)); io.new_line
			io.put_double (r_to_d (r1)); io.new_line
			io.put_double (r_to_d (r2)); io.new_line
			io.put_double (r_to_d (r3)); io.new_line
			io.put_double (r_to_d (d1.truncated_to_real)); io.new_line
			io.put_double (r_to_d (d2.truncated_to_real)); io.new_line
			io.put_double (r_to_d (d3.truncated_to_real)); io.new_line
			
			io.put_string ("%NSection 15%N")
			io.put_integer (d_to_i (i1)); io.new_line
			io.put_integer (d_to_i (i2)); io.new_line
			io.put_integer (d_to_i (i3)); io.new_line
			io.put_integer (d_to_i (r1)); io.new_line
			io.put_integer (d_to_i (r2)); io.new_line
			io.put_integer (d_to_i (r3)); io.new_line
			io.put_integer (d_to_i (d1)); io.new_line
			io.put_integer (d_to_i (d2)); io.new_line
			io.put_integer (d_to_i (d3)); io.new_line
			
			io.put_string ("%NSection 16%N")
			io.put_real (d_to_r (i1)); io.new_line
			io.put_real (d_to_r (i2)); io.new_line
			io.put_real (d_to_r (i3)); io.new_line
			io.put_real (d_to_r (r1)); io.new_line
			io.put_real (d_to_r (r2)); io.new_line
			io.put_real (d_to_r (r3)); io.new_line
			io.put_real (d_to_r (d1)); io.new_line
			io.put_real (d_to_r (d2)); io.new_line
			io.put_real (d_to_r (d3)); io.new_line
			
			io.put_string ("%NSection 17%N")
			io.put_double (d_to_d (i1)); io.new_line
			io.put_double (d_to_d (i2)); io.new_line
			io.put_double (d_to_d (i3)); io.new_line
			io.put_double (d_to_d (r1)); io.new_line
			io.put_double (d_to_d (r2)); io.new_line
			io.put_double (d_to_d (r3)); io.new_line
			io.put_double (d_to_d (d1)); io.new_line
			io.put_double (d_to_d (d2)); io.new_line
			io.put_double (d_to_d (d3)); io.new_line
			
			io.put_string ("%NSection 18%N")
			io.put_integer (int_to_int (i1)); io.new_line
			io.put_integer (int_to_int (i2)); io.new_line
			io.put_integer (int_to_int (i3)); io.new_line
			io.put_integer (int_to_int (r1.rounded)); io.new_line
			io.put_integer (int_to_int (r2.rounded)); io.new_line
			io.put_integer (int_to_int (r3.rounded)); io.new_line
			io.put_integer (int_to_int (d1.rounded)); io.new_line
			io.put_integer (int_to_int (d2.rounded)); io.new_line
			io.put_integer (int_to_int (d3.rounded)); io.new_line
			
			io.put_string ("%NSection 19%N")
			io.put_real (real_to_real (i1)); io.new_line
			io.put_real (real_to_real (i2)); io.new_line
			io.put_real (real_to_real (i3)); io.new_line
			io.put_real (real_to_real (r1)); io.new_line
			io.put_real (real_to_real (r2)); io.new_line
			io.put_real (real_to_real (r3)); io.new_line
			io.put_real (real_to_real (d1.truncated_to_real)); io.new_line
			io.put_real (real_to_real (d2.truncated_to_real)); io.new_line
			io.put_real (real_to_real (d3.truncated_to_real)); io.new_line
			
			io.put_string ("%NSection 20%N")
			io.put_double (double_to_double (i1)); io.new_line
			io.put_double (double_to_double (i2)); io.new_line
			io.put_double (double_to_double (i3)); io.new_line
			io.put_double (double_to_double (r1)); io.new_line
			io.put_double (double_to_double (r2)); io.new_line
			io.put_double (double_to_double (r3)); io.new_line
			io.put_double (double_to_double (d1)); io.new_line
			io.put_double (double_to_double (d2)); io.new_line
			io.put_double (double_to_double (d3)); io.new_line
			
		end

	initialize is
		do
			i2 := i1
			r2 := r1
			d2 := d1
		end

	i_to_i (n: INTEGER): INTEGER is
		do
			Result := n
		end

	i_to_r (n: INTEGER): REAL is
		do
			Result := n
		end

	i_to_d (n: INTEGER): DOUBLE is
		do
			Result := n
		end

	r_to_i (n: REAL): INTEGER is
		do
			Result := n.rounded
		end

	r_to_r (n: REAL): REAL is
		do
			Result := n
		end

	r_to_d (n: REAL): DOUBLE is
		do
			Result := n
		end

	d_to_i (n: DOUBLE): INTEGER is
		do
			Result := n.rounded
		end

	d_to_r (n: DOUBLE): REAL is
		do
			Result := n.truncated_to_real
		end

	d_to_d (n: DOUBLE): DOUBLE is
		do
			Result := n
		end

	i1: INTEGER is 123456789
	i2: INTEGER
	i3: INTEGER is
		do
			Result := i2
		end
	
	r1: REAL is 3.514
	r2: REAL
	r3: REAL is
		do
			Result := r2
		end
	
	d1: DOUBLE is 3.514159625678901
	d2: DOUBLE
	d3: DOUBLE is
		do
			Result := d2
		end

	i: INTEGER
	r: REAL
	d: DOUBLE

end

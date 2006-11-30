class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
			b: $B
		do
			io.put_string ("create a     : "); create a;     io.put_new_line
			io.put_string ("a := a       : "); a := a;       io.put_new_line
			io.put_string ("a ?= a       : "); a ?= a;       io.put_new_line
			io.put_string ("fa (a)       : "); fa (a);       io.put_new_line
			io.put_string ("create {$B} a : "); create {$B} a; io.put_new_line
			io.put_string ("a := a       : "); a := a;       io.put_new_line
			io.put_string ("a ?= a       : "); a ?= a;       io.put_new_line
			io.put_string ("fa (a)       : "); fa (a);       io.put_new_line
			io.put_string ("create {$B} b : "); create {$B} b; io.put_new_line
			io.put_string ("a := b       : "); a := b;       io.put_new_line
			io.put_string ("a ?= b       : "); a ?= b;       io.put_new_line
			io.put_string ("fa (b)       : "); fa (b);       io.put_new_line
			io.put_string ("create {$B} b : "); create {$B} b; io.put_new_line
			io.put_string ("b := b       : "); b := b;       io.put_new_line
			io.put_string ("b ?= b       : "); b $A b;       io.put_new_line
			io.put_string ("fb (b)       : "); fb (b);       io.put_new_line
		end

feature {NONE} -- Implementation

	fa (a: A) is
		do
		end

	fb (b: $B) is
		do
		end

end
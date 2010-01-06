class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			a: A
			b: $B
			t: TEST
			z: BOOLEAN
		do
			io.put_string ("create a     : "); create a;     io.put_new_line
			io.put_string ("a := a       : "); a := a;       io.put_new_line
			io.put_string ("a ?= a       : "); a ?= a;       io.put_new_line
			io.put_string ("t ?= a       : "); t ?= a;       io.put_new_line
			io.put_string ("fa (a)       : "); fa (a);       io.put_new_line
			io.put_string ("attached a   : "); z := attached a as x; io.put_new_line
			io.put_string ("attached {A}a: "); z := attached {A} a as x; io.put_new_line
			io.put_string ("attached {TEST}a: "); z := attached {TEST} a as x; io.put_new_line
			io.put_string ("create {$B} a : "); create {$B} a; io.put_new_line
			io.put_string ("a := a       : "); a := a;       io.put_new_line
			io.put_string ("a ?= a       : "); a ?= a;       io.put_new_line
			io.put_string ("t ?= a       : "); t ?= a;       io.put_new_line
			io.put_string ("fa (a)       : "); fa (a);       io.put_new_line
			io.put_string ("attached a   : "); z := attached a as x; io.put_new_line
			io.put_string ("attached {A}a: "); z := attached {A} a as x; io.put_new_line
			io.put_string ("attached {TEST}a: "); z := attached {TEST} a as x; io.put_new_line
			io.put_string ("create {$B} b : "); create {$B} b; io.put_new_line
			io.put_string ("a := b       : "); a := b;       io.put_new_line
			io.put_string ("a ?= b       : "); a ?= b;       io.put_new_line
			io.put_string ("t ?= b       : "); t ?= b;       io.put_new_line
			io.put_string ("fa (b)       : "); fa (b);       io.put_new_line
			io.put_string ("attached b   : "); z := attached b as x; io.put_new_line
			io.put_string ("attached {A}b: "); z := attached {A} b as x; io.put_new_line
			io.put_string ("attached {TEST}b: "); z := attached {TEST} b as x; io.put_new_line
			io.put_string ("create {$B} b : "); create {$B} b; io.put_new_line
			io.put_string ("b := b       : "); b := b;       io.put_new_line
			io.put_string ("b ?= b       : "); b ?= b;       io.put_new_line
			io.put_string ("b ?= a       : "); b ?= a;       io.put_new_line
			io.put_string ("fb (b)       : "); fb (b);       io.put_new_line
			io.put_string ("attached b   : "); z := attached b as x; io.put_new_line
			io.put_string ("attached {$B}b: "); z := attached {$B} b as x; io.put_new_line
			io.put_string ("attached {$B}a: "); z := attached {$B} a as x; io.put_new_line
		end

feature {NONE} -- Implementation

	fa (a: A) is
		do
		end

	fb (b: $B) is
		do
		end

end
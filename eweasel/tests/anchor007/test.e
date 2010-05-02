class TEST

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make

feature {NONE} -- Creation

	default_create
		do
			create a1
			create a2
			create a3
			create a4
			create a5
		end

	make
		local
			i1: like {ARRAY [TEST]}.item.f.is_less.io
			i2: like {A [ARRAY [like Current], TEST]}.twin.g.item.f.is_less.io
			i3: like {A [ARRAY [TEST], TEST]}.twin.h.f.is_less.io
			i4: like {B [TEST]}.twin.g.plus.io
			i5: like {B [TEST]}.twin.h.f.is_less.io
			x: ANY
		do
			default_create
			create i1
			i1.put_string ("TEST1: OK")
			i1.put_new_line
			create i2
			i2.put_string ("TEST2: OK")
			i2.put_new_line
			create i3
			i3.put_string ("TEST3: OK")
			i3.put_new_line
			create i4
			i4.put_string ("TEST4: OK")
			i4.put_new_line
			create i5
			i5.put_string ("TEST5: OK")
			i5.put_new_line
			a1.put_string ("TEST6: OK")
			a1.put_new_line
			a2.put_string ("TEST7: OK")
			a2.put_new_line
			a3.put_string ("TEST8: OK")
			a3.put_new_line
			a4.put_string ("TEST9: OK")
			a4.put_new_line
			a5.put_string ("TEST10: OK")
			a5.put_new_line
			x := create {A [like f, A [B [POINTER], BOOLEAN]]}.make
			x := create {B [A [B [POINTER], BOOLEAN]]}.make
			x := create {B [A [B [POINTER], BOOLEAN]]}.make_b
		end

feature {NONE} -- Test

	f: detachable COMPARABLE

	a1: like {ARRAY [TEST]}.item.f.is_less.io
	a2: like {A [ARRAY [like Current], TEST]}.twin.g.item.f.is_less.io
	a3: like {A [ARRAY [TEST], TEST]}.twin.h.f.is_less.io
	a4: like {B [TEST]}.twin.g.plus.io
	a5: like {B [TEST]}.twin.h.f.is_less.io

end

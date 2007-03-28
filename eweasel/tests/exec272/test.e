class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		local
			aa: A [ANY]
			ai: A [INTEGER]
			ba: B [ANY]
			ci: C [INTEGER]
			cx: C [X]
			x: X
		do
			create aa
			aa.put ("abc")
			io.put_string (aa.item.out)
			io.put_new_line
			ai ?= aa
			io.put_boolean (ai = Void)
			io.put_new_line
			create {A [INTEGER]} aa
			aa.put (123)
			io.put_string (aa.item.out)
			io.put_new_line
			ai ?= aa
			io.put_integer (ai.item)
			io.put_new_line
			create {C [INTEGER]} ba.make (1)
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			io.put_string (ba.f (2).out)
			io.put_new_line
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			io.put_string (ba.g (3).out)
			io.put_new_line
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			ci ?= ba
			io.put_string (ci.h.out)
			io.put_new_line
			io.put_string (ci.i.out)
			io.put_new_line
			io.put_string (ci.f (4).out)
			io.put_new_line
			io.put_string (ci.h.out)
			io.put_new_line
			io.put_string (ci.i.out)
			io.put_new_line
			io.put_string (ci.g (5).out)
			io.put_new_line
			io.put_string (ci.h.out)
			io.put_new_line
			io.put_string (ci.i.out)
			io.put_new_line
			x.put (6)
			create {C [X]} ba.make (x)
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			x.put (7)
			io.put_string (ba.f (x).out)
			io.put_new_line
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			x.put (8)
			io.put_string (ba.g (x).out)
			io.put_new_line
			io.put_string (ba.h.out)
			io.put_new_line
			io.put_string (ba.i.out)
			io.put_new_line
			cx ?= ba
			io.put_string (cx.h.out)
			io.put_new_line
			io.put_string (cx.i.out)
			io.put_new_line
			x.put (9)
			io.put_string (cx.f (x).out)
			io.put_new_line
			io.put_string (cx.h.out)
			io.put_new_line
			io.put_string (cx.i.out)
			io.put_new_line
			x.put (10)
			io.put_string (cx.g (x).out)
			io.put_new_line
			io.put_string (cx.h.out)
			io.put_new_line
			io.put_string (cx.i.out)
			io.put_new_line
		end

end
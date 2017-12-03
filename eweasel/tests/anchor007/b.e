class B [G -> {detachable ANY} create default_create end]
inherit
	A [INTEGER_8, G]

create
	make,
	make_b

feature {NONE} -- Creation

	make_b
		do
			io.put_string ("{B}.like a: " + (create {like a}).generating_type.name + "%N")
			io.put_string ("{B}.like a.g: " + (create {like a.g}).generating_type.name + "%N")
			io.put_string ("{B}.like a.h: " + (create {like a.h}).generating_type.name + "%N")
			io.put_string ("{B}.like b.g: " + (create {like b.g}).generating_type.name + "%N")
			io.put_string ("{B}.like b.h: " + (create {like b.h}).generating_type.name + "%N")
			create a
			create ag
			create ah
			create bg
			create bh
			io.put_string ("{B}.a: " + a.generating_type.name + "%N")
			io.put_string ("{B}.ag: " + ag.generating_type.name + "%N")
			io.put_string ("{B}.ah: " + ah.generating_type.name + "%N")
			io.put_string ("{B}.bg: " + bg.generating_type.name + "%N")
			io.put_string ("{B}.bh: " + bh.generating_type.name + "%N")
		end
	
end
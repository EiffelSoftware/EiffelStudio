class A [G, H -> {detachable ANY} create default_create end]

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
		end

	make
		do
			io.put_string ("{A}.like a: " + (create {like a}).generating_type + "%N")
			io.put_string ("{A}.like a.g: " + (create {like a.g}).generating_type + "%N")
			io.put_string ("{A}.like a.h: " + (create {like a.h}).generating_type + "%N")
			io.put_string ("{A}.like b.g: " + (create {like b.g}).generating_type + "%N")
			io.put_string ("{A}.like b.h: " + (create {like b.h}).generating_type + "%N")
			create a
			create ag
			create ah
			create bg
			create bh
			io.put_string ("{A}.a: " + a.generating_type + "%N")
			io.put_string ("{A}.ag: " + ag.generating_type + "%N")
			io.put_string ("{A}.ah: " + ah.generating_type + "%N")
			io.put_string ("{A}.bg: " + bg.generating_type + "%N")
			io.put_string ("{A}.bh: " + bh.generating_type + "%N")
		end
	
feature -- Access

	g: detachable G
	h: detachable H
	a: detachable A [H, like b.g] note option: stable attribute end
	ag: like a.g note option: stable attribute end
	ah: like a.h note option: stable attribute end
	b: detachable B [H]
	bg: like b.g note option: stable attribute end
	bh: like b.h note option: stable attribute end

end
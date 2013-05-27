class TEST
create
	make

feature

	make
		local
			mem: MEMORY
		do
			create mem
			allocate
			mem.full_collect
			usage
		end

	allocate
		local
			t: TYPE [detachable ANY]
		do
			t := {detachable LIST [detachable TEST]}
		end

	usage
		local
			t: TYPE [detachable ANY]
		do
			t := {detachable LIST [detachable TEST]}
			io.put_string (t.name)
			io.put_new_line
		end
end

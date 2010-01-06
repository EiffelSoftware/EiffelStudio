class
	TEST

create
	make

feature -- Initialization

	make is
			-- Tests
		local
			l_stream: SYSTEM_STREAM
		do
			l_stream := ({TEST}).to_cil.assembly.get_manifest_resource_stream ("document.dat")
			print (l_stream /= Void)
			print ("%N")
		end

end

class TEST
create
	make

feature {NONE}
	
	make
		do
			create test1.make (create {TEST1})
			io.put_boolean (test1.is_po_quoted)
		end


	test1: PROXY_TEST1

end


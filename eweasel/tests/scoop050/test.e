note
	description: "Test if lock passing happens for queries without any arguments."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_shared: separate ANY
			l_supplier: separate SUPPLIER
		do
			create l_shared
			create l_supplier.make (l_shared)

			execute_test (l_shared, l_supplier)
			print ("OK: No deadlock occurred.%N")
		end

feature -- Basic operations

	execute_test (l_shared: separate ANY; l_supplier: separate SUPPLIER)
			-- Call a query on `l_supplier'.
		local
			l_sync: INTEGER
		do
			l_sync := l_shared.out.count
			l_sync := l_supplier.perform_query
		end

end

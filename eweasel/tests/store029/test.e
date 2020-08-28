class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
--			test (True)
			test (False)
		end

	test (a_store: BOOLEAN)
		local
			bb: BB
			zz: ZZ [DOUBLE, INTEGER]
		do
			create zz.make
			if a_store then
				zz.attr1.force (5.0, 1)
				zz.store_by_name ("zz.store")
			else
				zz ?= zz.retrieve_by_name ("zz.store")
			end
		end

end

class
	TEST

create
	make

feature {NONE} -- Initialization

	make
		do
			f
		end

	f
			-- Run application.
		require
			Result /= Void
		do
			Result.do_nothing
		ensure
			Result /= Void
		end

invariant
	Result /= Void

end

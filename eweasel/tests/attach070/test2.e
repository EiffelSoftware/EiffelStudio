class TEST

inherit
	A
		redefine
			f1, f2, f3, f4, f5, f6
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			f1; f2; f3; f4; f5; f6
		end

feature {NONE} -- Test

	f1
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f2
		require else
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f3
		require else
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f4
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f5
		require else
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f6
		require else
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

end

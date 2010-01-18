class TEST

inherit
	A
		redefine
			f1, f2, f3, f4, f5, f6, f7, f8, f9, f10
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		do
			f1; f2; f3; f4; f5; f6; f7; f8; f9; f10
		end

feature {NONE} -- Test

	f1
		require else
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f2
		require else
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f3
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f4
		require else
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f5
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f6
		require else
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f7
		require else
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f8
		require else
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f9
		require else
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f10
		require else
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

end

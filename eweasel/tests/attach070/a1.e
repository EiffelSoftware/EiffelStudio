class A

feature {NONE} -- Test

	f1
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f2
		require
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
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f5
		require
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f6
		require
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f7
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f8
		require
			True
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f9
		require
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f10
		require
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

feature {NONE} -- Access

	a: detachable STRING note option: stable attribute end
			-- Data

end

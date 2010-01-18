class A

feature {NONE} -- Test

	f1
		require
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f2
		require
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f3
		require
			False
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f4
		require
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f5
		require
			a /= Void
		do
			create a.make_empty
		rescue
			a.do_nothing
		end

	f6
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

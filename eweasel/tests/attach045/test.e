class
	TEST

inherit
	A
		rename
			ff3 as ff2,
			fp3 as fp2
		redefine
			ff1,
			ff2,
			fp1,
			fp2
		end

create
	make

feature {NONE} -- Creation

	make
			-- Run tests.
		do
		end

feature {NONE} -- Tests

	f (a: attached ANY)
		do
		end

	ff1 (a: detachable ANY)
		require else
			a /= Void
		do
			f (a)
		end

	ff2 (a: detachable ANY)
		require else
			a /= Void
		do
			f (a)
		end

	fp1 (a: detachable ANY)
		do
			f (a)
		end

	fp2 (a: detachable ANY)
		do
			f (a)
		end

end
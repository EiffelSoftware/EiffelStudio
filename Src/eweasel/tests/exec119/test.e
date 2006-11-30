
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature

	make is
		do
			g
		end;

	f (i: INTEGER; s: STRING) is
		local
			exc: EXCEPTIONS
		do
			if i > 0 then
				f (i - 1, s)
			else
				create exc
				exc.raise (s)
			end
		end


	h (i: INTEGER) is
		local
			retried: BOOLEAN
			exc: EXCEPTIONS
		do
			if not retried then
				f (5, "TOTO%N")
			end
		rescue
			create exc
			if exc.is_developer_exception then
				print (exc.tag_name)
				retried := True
				retry
			end
		end

	g is
		local
			retried: BOOLEAN
			exc: EXCEPTIONS
		do
			if not retried then
				f (5, "TITI%N")
			end
		rescue
			create exc
			if exc.is_developer_exception then
				print (exc.tag_name)
				h (5)
				retried := True
				retry
			end
		end
end


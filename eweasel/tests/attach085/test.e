class TEST

inherit
	EXCEPTIONS

create
	make,
	creation_unqualified,
	creation_qualified,
	creation_loop,
	creation_retry,
	creation_if,
	creation_inspect,
	creation_inspect_else

feature {NONE} -- Attribute initialization

	make
		do
			die (0)
		end

	creation_unqualified
		do
			die (0)
		end

	creation_qualified
		do
			;(create {EXCEPTIONS}).die (0)
		end

	creation_loop
		do
			from
			until
				false
			loop
			end
		end

	creation_retry
		local
			t: TEST
		do
			die (0)
		rescue
			retry
			t := x
		end

	creation_if
		do
			if out ~ "TEST" then
				die (0)
			else
				die (0)
			end
		end

	creation_inspect
		do
			inspect
				out.count
			when 1 then
				die (0)
			end
		end

	creation_inspect_else
		do
			inspect
				out.count
			when 1 then
				die (0)
			else
				die (0)
			end
		end

feature {NONE} -- Result initialization

	result_unqualified: TEST
		do
			die (0)
		end

	result_qualified: TEST
		do
			;(create {EXCEPTIONS}).die (0)
		end

	result_loop: TEST
		do
			from
			until
				false
			loop
			end
		end

	result_retry: TEST
		local
			t: TEST
		do
			die (0)
		rescue
			retry
			t := Result
		end

	result_inspect: TEST
		do
			inspect
				out.count
			when 1 then
				die (0)
			end
		end

	result_inspect_else: TEST
		do
			inspect
				out.count
			when 1 then
				die (0)
			else
				die (0)
			end
		end

feature {NONE} -- Result initialization

	local_unqualified
		local
			t: TEST
		do
			die (0)
			x := t
		end

	local_qualified
		local
			t: TEST
		do
			;(create {EXCEPTIONS}).die (0)
			x := t
		end

	local_loop
		local
			t: TEST
		do
			from
			until
				false
			loop
			end
			x := t
		end

	local_retry
		local
			t: TEST
		do
			die (0)
		rescue
			retry
			x := t
		end

	local_inspect
		local
			t: TEST
		do
			inspect
				out.count
			when 1 then
				die (0)
			end
			x := t
		end

	local_inspect_else
		local
			t: TEST
		do
			inspect
				out.count
			when 1 then
				die (0)
			else
				die (0)
			end
			x := t
		end

feature -- Access

	x: TEST

end

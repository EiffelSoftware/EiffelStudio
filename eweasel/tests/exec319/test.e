class TEST

create
	make


feature {NONE} -- Creation

	make
			-- Run tests.
		do
				-- "All" loop expressions
			report (across data (<<>>) as c all c.item > 0 end)
			report (across data (<<>>) as c all c.item < 0 end)
			report (across data (<<5>>) as c all c.item > 0 end)
			report (not across data (<<-5>>) as c all c.item > 0 end)
			report (across data (<<1, 2, 3>>) as c all c.item > 0 end)
			report (not across data (<<-1, 2, 3>>) as c all c.item > 0 end)
			report (not across data (<<1, -2, 3>>) as c all c.item > 0 end)
			report (not across data (<<1, 2, -3>>) as c all c.item > 0 end)
			report (not across data (<<-1, -2, 3>>) as c all c.item > 0 end)
			report (not across data (<<-1, 2, -3>>) as c all c.item > 0 end)
			report (not across data (<<1, -2, -3>>) as c all c.item > 0 end)
			report (not across data (<<-1, -2, -3>>) as c all c.item > 0 end)
			report (across data (<<1, -2, -3>>) as c until c.item = -2 all c.item > 0 end)
			report (not across data (<<1, -2, -3>>) as c until c.item = -3 all c.item > 0 end)
			report (not across data (<<-1, -2, -3>>) as c until c.item = -2 all c.item > 0 end)
				-- "Some" loop expressions
			report (not across data (<<>>) as c some c.item > 0 end)
			report (not across data (<<>>) as c some c.item < 0 end)
			report (across data (<<5>>) as c some c.item > 0 end)
			report (not across data (<<-5>>) as c some c.item > 0 end)
			report (across data (<<1, 2, 3>>) as c some c.item > 0 end)
			report (across data (<<-1, 2, 3>>) as c some c.item > 0 end)
			report (across data (<<1, -2, 3>>) as c some c.item > 0 end)
			report (across data (<<1, 2, -3>>) as c some c.item > 0 end)
			report (across data (<<-1, -2, 3>>) as c some c.item > 0 end)
			report (across data (<<-1, 2, -3>>) as c some c.item > 0 end)
			report (across data (<<1, -2, -3>>) as c some c.item > 0 end)
			report (not across data (<<-1, -2, -3>>) as c some c.item > 0 end)
			report (not across data (<<-1, 2, -3>>) as c until c.item = -1 some c.item > 0 end)
			report (across data (<<-1, 2, -3>>) as c until c.item = -3 some c.item > 0 end)
			report (not across data (<<-1, -2, -3>>) as c until c.item = -3 some c.item > 0 end)
				-- Nested loop expressions
			report (across data2 (data (<<>>), data (<<1>>), data (<<1, 2, 3>>)) as c2
				all across c2.item as c all c.item > 0 end end
			)
			report (across data2 (data (<<>>), data (<<1>>), data (<<1, -2, 3>>)) as c2
				some across c2.item as c all c.item > 0 end end
			)
				-- Loops with assertions
			report (
				across
					data (<<6, 4, 2, 0>>) as c
				invariant
					c.item \\ 2 = 0
				until
					c.item = 0
				all
					c.item > 0
				variant
					c.item
				end
			)
				-- Loops with violated assertions
			report_violation (
				agent
					local
						b: BOOLEAN
					do
						b :=
							across
								data (<<6, 4, 1, 0>>) as c
							invariant
								c.item \\ 2 = 0
							until
								c.item = 0
							all
								c.item > 0
							end
					end
			)
			report_violation (
				agent
					local
						b: BOOLEAN
					do
						b :=
							across
								data (<<2, 1, 1>>) as c
							all
								c.item > 0
							variant
								c.item
							end
					end
			)
		end

feature {NONE} -- Conversion

	data (a: ARRAY [INTEGER]): ARRAY [INTEGER]
		require
			a_attached: a /= Void
		do
			Result := a
		ensure
			Result_attached: Result /= Void
		end

	data2 (a1, a2, a3: ARRAY [INTEGER]): ARRAY [ARRAY [INTEGER]]
		require
			a1_attached: a1 /= Void
			a2_attached: a2 /= Void
			a3_attached: a3 /= Void
		do
			create Result.make_filled (a1, 1, 3)
			Result.put (a2, 2)
			Result.put (a3, 3)
		ensure
			Result_attached: Result /= Void
		end

feature {NONE} -- Output

	count: NATURAL_8
			-- Number of tests executed so far

	report (b: BOOLEAN)
			-- Report that the current test is completed with result `b'.
		do
			count := count + 1
			io.put_string ("Test #")
			io.put_natural (count)
			io.put_string (": ")
			if b then
				io.put_string ("OK")
			else
				io.put_string ("FAILED")
			end
			io.put_new_line
		ensure
			count_incremented: count = old count + 1
		end

	report_violation (a: PROCEDURE [ANY, TUPLE])
		require
			a_attached: a /= Void
		local
			is_retried: BOOLEAN
		do
			if not is_retried then
				a.call (Void)
			end
			report (is_retried)
		rescue
			if not is_retried then
				is_retried := True
				retry
			end
		end

end

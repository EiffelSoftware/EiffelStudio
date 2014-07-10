class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make,
	make_with_resource

feature {NONE} -- Creation

	make
			-- Run test.
			-- Try to get a deadlock.
		local
			actors: ARRAYED_LIST [separate TEST]
			resources: ARRAYED_LIST [separate ANY]
			first_resource: separate ANY
			next_resource: separate ANY
			previous_resource: separate ANY
			i: INTEGER
			n: INTEGER
		do
			n := 10
			create actors.make (n)
			create first_resource
			previous_resource := first_resource
			across
				1 |..| (n - 1) as c
			loop
				create next_resource
				actors.extend (create {separate TEST}.make_with_resource (previous_resource, next_resource))
				previous_resource := next_resource
			end
			actors.extend (create {separate TEST}.make_with_resource (previous_resource, first_resource))
			across
				actors as c
			loop
				check attached c.item as a then
					run (a)
				end
			end
		end

	make_with_resource (r1, r2: separate ANY)
			-- Set `resource1' and `resource2' with `r1' and `r2' respectively.
		do
			resource1 := r1
			resource2 := r2
		ensure
			resource1 = r1
			resource2 = r2
		end

feature -- Access

	resource1, resource2: detachable separate ANY
			-- Objects to be used by several actors.

feature -- Test

	run (x: separate TEST)
			-- Call `x.execute'.
		do
			x.execute
		end

	execute
			-- Use `resource1' and `resource2' in that order without simultaneous synchronization.
		do
			check attached resource1 as r then
				use1 (r)
			end
		end

	use1 (r1: separate ANY)
			-- Make a synchronous call on `r1' and then on `resource2'.
		do
			r1.out.do_nothing
			sleep (1_000_000_000)
			check attached resource2 as r2 then
				use2 (r1, r2)
			end
		end

	use2 (r1, r2: separate ANY)
			-- Make a synchronous call on `r2'.
		do
			r2.out.do_nothing
		end

end

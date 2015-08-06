note
	description: "Test that there's no locking when a separate argument is expanded at runtime."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make, make_with_controller

feature {NONE} -- Initialization

	controller: separate TEST
			-- A controller to signal stop.

	make
			-- Run application.
		local
			eclass: ECLASS
			any: ANY
			runner: separate TEST
			terminator: separate TEST
		do
			create eclass
			any := eclass
			controller := Current

			create runner.make_with_controller (Current)
			separate runner as r do
				r.live (any)
			end

			print ("OK: Asynchronous Call%N")
			sleep (second)

			create terminator.make_with_controller (Current)
			separate terminator as t do
				t.terminate
			end

			print ("OK: Asynchronous Call%N")
		end


	make_with_controller (c: like controller)
		do
			controller := c
		end


feature -- Tests

	is_stopped: BOOLEAN

	stop
		do
			is_stopped := True
			print ("OK: Stopped%N")
		end

	terminate
		do
			separate controller as c do
				c.stop
			end
		end

	second: INTEGER_64 = 1_000_000_000

	live (an_obj: separate ANY)
		do
			from
			until
				controller_is_stopped (controller)
			loop
				sleep (second//10)
			end
		end

	controller_is_stopped (c: like controller): BOOLEAN
		do
			Result := c.is_stopped
		end
end

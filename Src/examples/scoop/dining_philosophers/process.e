indexing
	description: "The most general notion of process."
	author		: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski."
	reviewer	: "Benjamin Morandi"
	date		: "$Date: 18.05.2007$"
	revision	: "1.0.0"

deferred class PROCESS

feature -- Status report

	over: BOOLEAN
			-- Should execution terminate now?
		deferred
		end

feature -- Basic operations

	setup
			-- Prepare to execute process operations (default: nothing).
		do
		end

	step
			-- Execute basic process operations.
		deferred
		end

	wrapup
			-- Execute termination operations (default: nothing).
		do
		end

feature -- Process behaviour

	live
			-- Perform process lifecycle.
		do
			from
				setup
			until
				over
			loop
				step
			end
			wrapup
		end

end -- class PROCESS

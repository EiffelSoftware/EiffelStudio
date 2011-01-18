note
	description: "The most general notion of process."
	author: "Volkan Arslan, Yann Mueller, Piotr Nienaltowski"
	date: "$Date: 18.05.2007$"
	revision: "1.0.0"

deferred class
	PROCESS

feature {NONE} -- Status report

	over: BOOLEAN
			-- Should execution terminate now?
		deferred
		end

feature {NONE} -- Basic operations

	setup
		do
		end

	step
		deferred
		end

	wrapup
		do
		end

feature -- Process behaviour

	live
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

end

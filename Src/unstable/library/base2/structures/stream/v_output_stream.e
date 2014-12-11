note
	description: "Streams where values can be output one by one."
	author: "Nadia Polikarpova"
	model: off

deferred class
	V_OUTPUT_STREAM [G]

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		deferred
		end

feature -- Replacement

	output (v: G)
			-- Put `v' into the stream and move to the next position.
		note
			modify: off
		require
			not_off: not off
		deferred
		end

	pipe (input: V_INPUT_STREAM [G])
			-- Copy values from `input' until either `Current' or `input' is `off'.
		note
			modify: off, input__box
		require
			input_not_current: input /= Current
		do
			from
			until
				off or input.off
			loop
				output (input.item)
				input.forth
			end
		ensure
			off_effect: off or input.box.is_empty
		end

	pipe_n (input: V_INPUT_STREAM [G]; n: INTEGER)
			-- Copy `n' elements from `input'; stop if either `Current' or `input' is `off'.
		note
			modify: off, input__box
		require
			input_not_current: input /= Current
			n_non_negative: n >= 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > n or off or input.off
			loop
				output (input.item)
				input.forth
				i := i + 1
			end
		end

end

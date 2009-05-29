note
	description: "[
		Is used to redirect output from process and check if they have terminated successfully.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_OUTPUT_HANDLER

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			output := ""
		ensure
			max_size_is_positive: max_size >= 0
			output_attached: output /= Void
		end

feature -- Access

	output: STRING
			-- The output

	max_size: INTEGER
			-- The max size of the stored output

feature -- Status report

	has_successfully_terminated: BOOLEAN
			-- Checks if the process has terminated successfully
		deferred
		end

feature -- Operations

	handle_output (a_output: STRING)
			-- Handles the output
		require
			a_output_attached: a_output /= Void
		do
			add_output (a_output)
			internal_handle_output (a_output)
		end

feature {NONE} -- Implementation

	add_output (a_output: READABLE_STRING_8)
			-- Adds output and rezises if necessary.
		require
			a_output_attached: a_output /= Void
		do
			output := output + a_output
			if output.count > max_size then
				output.remove_head (output.count - max_size)
			end
		end

	internal_handle_output (a_output: STRING)
			-- Lets the effective class do what it wants with the output

		require
			a_output_attached: a_output /= Void
		deferred
		end

invariant
	max_size_is_positive: max_size > 0
	output_attached: output /= Void
end

--inherit
--	XS_OUTPUT_HANDLER

--create
--	make

--feature -- Status setting

--	internal_handle_output (a_output: READABLE_STRING_8)
--			-- <Precursor>

--		do
--		end

--feature -- Status report

--	has_successfully_terminated: BOOLEAN
--			-- <Precursor>
--		do
--		end

indexing
	description: "[
		Objects processing output retrieved from a system execution.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQA_SYSTEM_OUTPUT_PROCESSOR

feature {NONE} -- Initialization

	initialize_buffer
			-- Initialize `buffer' with expected line length.
		do
			create buffer.make (default_buffer_size)
		end

feature {NONE} -- Access

	buffer: !STRING
			-- Buffer containing current (partial) line retrieved from system.

feature {NONE} -- Status report

	is_line_wise: BOOLEAN
			-- Should output notification be per line?
			--
			-- Note: this can be changed while output is processed.

feature {NONE} -- Events

	on_new_character (a_character: CHARACTER)
			-- Called when `a_character' has been addended to `buffer'.
			--
			-- Note: if `a_character' is a new line character, buffer will be wiped out after
			--       `on_new_character' has returned.
		require
			not_line_wise: not is_line_wise
			buffer_not_empty: not buffer.is_empty
			a_character_is_last: buffer.item (buffer.count) = a_character
		do
		end

	on_new_line
			-- Called when `buffer' represents a complete read line last retrieved from process.
			--
			-- Note: `buffer' will be wiped out after `on_new_line' has returned.
			--
			-- Note: `on_new_line' is also called when process exits and `buffer' contains a partial line.
		require
			line_wise: is_line_wise
		do
		end

feature {EQA_SYSTEM_EXECUTION, EQA_SYSTEM_EXECUTION_PROCESS} -- Implementation

	append_output (a_output: !READABLE_STRING_8)
			-- Append `a_output' to `buffer' and notify `on_new_character' and `on_new_line' accordingly.
		local
			i: INTEGER
			c: CHARACTER
		do
			from
				i := 1
			until
				i > a_output.count
			loop
				c := a_output.item (i)
				if c /= '%R' then
					if c = '%N' and is_line_wise then
						on_new_line
						buffer.wipe_out
					else
						buffer.append_character (c)
						if not is_line_wise then
							on_new_character (c)
							if c = '%N' then
								buffer.wipe_out
							end
						end
					end
				end
				i := i + 1
			end
		end

	flush_buffer
			-- Process any remaining output in `buffer'.
		local
			i, l_count: INTEGER
		do
			if not buffer.is_empty and is_line_wise then
				on_new_line
				buffer.wipe_out
			end
		ensure
			buffer_empty: buffer.is_empty
		end

feature {NONE} -- Constants

	default_buffer_size: INTEGER
		do
			Result := 100
		end

invariant
	buffer_contains_no_new_lines: not (buffer.has ('%N') or buffer.has ('%R'))

end

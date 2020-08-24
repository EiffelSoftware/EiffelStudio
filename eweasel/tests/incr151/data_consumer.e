
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class DATA_CONSUMER

feature

	initialize
		do
			reset
		end

	reset
		do
			local_ok := True
			local_errors := Void
			local_warnings := Void
			end_of_input := False
		end

	in_initial_state: BOOLEAN
		deferred
		end

	explicit_name: STRING
			
	local_ok: BOOLEAN

	local_errors: STRING

	local_warnings: STRING

	end_of_input: BOOLEAN

end

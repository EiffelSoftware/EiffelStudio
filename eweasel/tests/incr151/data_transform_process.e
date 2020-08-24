
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class $PARENT_CLASS

inherit
	DATA_TRANSFORM
		redefine
			initialize, reset
		select
			reset
		end
	DATA_TRANSFORM
		rename
			reset as dt_reset
		redefine
			initialize
		end

$EXTRA

feature
	
	make is
		do
			output_capacity := Default_output_capacity
			error_capacity := Default_error_capacity
			dt_reset
		end

	initialize is
		do
			precursor
			create output_buffer.make (output_capacity)
			create error_buffer.make (error_capacity)
		end

	reset is
		do
			precursor
			eof_input := False
			eof_output := False
			eof_error := False
			eof_all := False
		end

feature

	in_initial_state: BOOLEAN

	Default_output_capacity: INTEGER is 65536

	Default_error_capacity: INTEGER is 4096

	eof_input: BOOLEAN

	eof_output: BOOLEAN
			
	eof_error: BOOLEAN
	
	eof_all: BOOLEAN

	status: INTEGER
	
end


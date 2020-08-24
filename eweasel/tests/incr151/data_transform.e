
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

deferred class DATA_TRANSFORM

inherit
	DATA_CONSUMER
		redefine
			reset, initialize
		end

feature

	output_buffer: STRING

	error_buffer: STRING

	output_capacity: INTEGER
			
	error_capacity: INTEGER
			
	output_consumer: DATA_CONSUMER

	error_consumer: DATA_CONSUMER

	immediate_error_propagation: BOOLEAN

	initialize
		do
			precursor 
			create output_buffer.make (output_capacity) 
			create error_buffer.make (error_capacity)
		end

	reset
		do
			precursor;
		end

end

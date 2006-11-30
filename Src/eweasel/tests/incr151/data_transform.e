
--| Copyright (c) 1993-2006 University of Southern California and contributors.
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

	initialize is
		do
			precursor
			!!output_buffer.make (output_capacity)
			!!error_buffer.make (error_capacity)
		end

	reset is
		do
			precursor;
		end

end

class SHARED_GENERATION

feature {NONE}

	gc_equal: STRING is " = "

	gc_comma: STRING is ", "

	gc_rparan_comma: STRING is ");"

	gc_rparan_semi_c: STRING is ");"

	gc_plus: STRING is " + "

	gc_star: STRING is " * "

	gc_if_l_paran: STRING is "if ("

	gc_lacc_else_r_acc: STRING is "} else {"

	gc_dtype: STRING is "dtype"

	gc_dtype_current: STRING is "Dtype(Current)"

	gc_upper_dtype_lparan: STRING is "Dtype("

	generation_buffer: GENERATION_BUFFER is
			-- String where all the generation will happen
			-- Default size is 600Ko, it will be resized when
			-- needed.
		once
			create Result.make (600000)
		end

	header_generation_buffer: GENERATION_BUFFER is
			-- String where all the generation for the header
			-- file will happen. Default size is 50Ko, it will
			-- be resized when needed.
		once
			create Result.make (50000)
		end

	Encoder: ENCODER is
			-- To generate encoded name for Eiffel features at the C level.
		once
			create Result
		end
	
end

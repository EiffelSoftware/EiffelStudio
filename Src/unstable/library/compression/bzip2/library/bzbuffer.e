class BZBUFFER

inherit
	BZLIB

	UTIL_EXTERNALS

feature

	compress_to_buffer (a_input, a_output: ARRAY[CHARACTER])
		require
			non_void_input: a_input /= Void
			data_available: a_input.count > 0
			non_void_output: a_output /= Void
		local
			len: CMEM_32
			l_arro: ANY
		do
			a_output.conservative_resize_with_default ('%U', 1, a_input.count + a_input.count // 100 + 600)
			len.from_integer (a_output.count)
			l_arro := a_output.to_c
			last_operation := BZ2_bzBuffToBuffCompress ($l_arro, len.to_external, $l_arro, a_input.count, 9, 0, 0)

			if last_operation = Ok then
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
			end
		end

	decompress_to_buffer (a_input, a_output: ARRAY[CHARACTER])
		require
			non_void_input: a_input /= Void
			data_available: a_input.count > 0
			non_void_output: a_output /= Void
		local
			len: CMEM_32
			l_arri: ANY
			l_arro: ANY
		do
			from
				len.from_integer (a_input.count)
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
				l_arro := a_output.to_c
				l_arri := a_input.to_c
				last_operation := BZ2_bzBuffToBuffDecompress ($l_arro, len.to_external, $l_arri, a_input.count, 0, 0)
			until
				last_operation /= Outbuff_full
			loop
				len.from_integer (a_output.count * 2)
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
				l_arro := a_output.to_c
				l_arri := a_input.to_c
				last_operation := BZ2_bzBuffToBuffDecompress ($l_arro, len.to_external, $l_arri, a_input.count, 0, 0)
			end -- loop

			if last_operation = Ok then
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
			end
		end

	compress_raw_to_buffer (a_input: POINTER; a_length: INTEGER; a_output: ARRAY[CHARACTER])
		require
			non_void_input: a_input /= default_pointer
			data_available: a_length > 0
			non_void_output: a_output /= Void
		local
			len: CMEM_32
			l_arr: ANY
		do
			a_output.conservative_resize_with_default ('%U', 1, a_length + a_length // 100 + 600)
			len.from_integer (a_output.count)
			l_arr := a_output.to_c
			last_operation := BZ2_bzBuffToBuffCompress ($l_arr, len.to_external, a_input, a_length, 9, 0, 0)

			if last_operation = Ok then
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
			end
		end

	decompress_raw_to_buffer (a_input: POINTER; a_length: INTEGER; a_output: ARRAY[CHARACTER])
		require
			non_void_input: a_input /= default_pointer
			data_available: a_length > 0
			non_void_output: a_output /= Void
		local
			len: CMEM_32
			l_arr: ANY
		do
			from
				len.from_integer (a_length)
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
				l_arr := a_output.to_c
				last_operation := BZ2_bzBuffToBuffDecompress ($l_arr, len.to_external, a_input, a_length, 0, 0)
			until
				last_operation /= Outbuff_full
			loop
				len.from_integer (a_output.count * 2)
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
				l_arr := a_output.to_c
				last_operation := BZ2_bzBuffToBuffDecompress ($l_arr, len.to_external, a_input, a_length, 0, 0)
			end -- loop

			if last_operation = Ok then
				a_output.conservative_resize_with_default ('%U', 1, len.to_integer)
			end
		end

end

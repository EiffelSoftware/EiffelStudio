indexing
	description: "Encoding conversion implementation on Unix"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_IMP

inherit
	ENCODING_I

	CODE_SETS

feature -- String encoding convertion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING): STRING_GENERAL is
			-- Convert `a_from_string' of `a_from_code_page' to a string of `a_to_code_page'.
		local
			l_managed_pointer: MANAGED_POINTER
			l_count, l_size, i: INTEGER
			l_pointer: POINTER
			l_out_count: INTEGER
			l_string: STRING_8
		do
			if four_byte_codesets.has (a_from_code_page) then
				l_pointer := string_32_to_pointer (a_from_string)
				l_count := (a_from_string.count) * 4
			elseif two_byte_codesets.has (a_from_code_page) then
				l_pointer := wide_string_to_pointer (a_from_string.as_string_32)
				l_count := (a_from_string.count) * 2
			else
				l_pointer := multi_byte_to_pointer (a_from_string.as_string_8)
				l_count := a_from_string.count
			end
			l_pointer := c_iconv (multi_byte_to_pointer (a_from_code_page), multi_byte_to_pointer (a_to_code_page), l_pointer, l_count, $l_out_count, $last_conversion_successful)
			if last_conversion_successful then
				if l_pointer /= Void then
					if four_byte_codesets.has (a_to_code_page) then
						Result := pointer_to_string_32 (l_pointer, l_out_count)
						if not Result.is_empty and then (Result.code (1) = 0xFEFF or else Result.code (1) = 0xFFFE) then
							Result := Result.substring (2, Result.count)
						end
					elseif two_byte_codesets.has (a_to_code_page) then
						Result := pointer_to_wide_string (l_pointer, l_out_count)
						if not Result.is_empty and then (Result.code (1) = 0xFEFF or else Result.code (1) = 0xFFFE) then
							Result := Result.substring (2, Result.count)
						end
					else
						Result := pointer_to_multi_byte (l_pointer, l_out_count)
					end
				else
					check
						l_pointer_not_void: l_pointer /= Void
					end
				end
			end
		end

feature -- Status report

	is_code_page_valid (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' valid?
		local
			l_pointer: POINTER
		do
			if a_code_page /= Void and then a_code_page /= Void then
				l_pointer := multi_byte_to_pointer (a_code_page)
				Result := is_codeset_convertable (l_pointer, l_pointer)
			end
		end

feature {NONE} -- Implementation

	string_32_to_pointer (a_string: STRING_32): POINTER is
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			new_size: INTEGER
			l_end_pos, l_start_pos: INTEGER
			l_managed_data: MANAGED_POINTER
		do
			l_start_pos := 1
			l_end_pos := a_string.count
			create l_managed_data.make ((l_end_pos + 1) * 4)
			nb := l_end_pos - l_start_pos + 1

			new_size := (nb + 1) * 4

			if l_managed_data.count < new_size  then
				l_managed_data.resize (new_size)
			end

			from
				i := 0
			until
				i = nb
			loop
				l_managed_data.put_natural_32 (a_string.code (i + l_start_pos), i * 4)
				i := i +  1
			end
			l_managed_data.put_natural_32 (0, i * 4)
			Result := l_managed_data.item
		end

	c_iconv (a_from_codeset, a_to_codeset: POINTER; a_str: POINTER; a_size: INTEGER; a_out_count: TYPED_POINTER [INTEGER]; a_b: TYPED_POINTER [BOOLEAN]): POINTER is
		external
			"C inline use <iconv.h>"
		alias
			"[
				size_t insize = 0;
				iconv_t cd;
				size_t nconv, avail, alloc;
				char *res, *tres, *wrptr, *inptr;
				
				insize = (size_t)$a_size;
				alloc = avail = insize + insize/4;
				*$a_b = 1;
				
				if (!(res = malloc(alloc))) {
					perror("malloc");
					*$a_b = 0;
					return NULL;
				}

				wrptr = res;   /* duplicate pointers because they */
				inptr = $a_str; /* get modified by iconv */

				cd = iconv_open ($a_to_codeset, $a_from_codeset);
				if (cd == (iconv_t)(-1)) {
					*$a_b = 0;
					perror("iconv_open");
					free(res);
					return NULL;
				}
				
				do {				
					nconv = iconv (cd, (const char **) &inptr, &insize, &wrptr, &avail); /*convertions */
					
					if (nconv == (size_t)(-1)) {
						if (errno == E2BIG) { /* need more room for result */							
							tres = realloc(res, alloc += 20);
							avail += 20;
							if (!tres) {
								perror("realloc");
								*$a_b = 0;
								break;
							}
							wrptr = tres + (wrptr - res);
							res = tres;
						}
						else if (errno == EILSEQ) {
							perror ("EILSEQ error. Input conversion stopped due to an input byte that does not belong to the input codeset");
							*$a_b = 0;
							break;
						}
						else if (errno == EINVAL){
							perror ("EINVAL error. Input conversion stopped due to an incomplete character or shift sequence at the end of the input buffer.");
							*$a_b = 0;
							break;
						}
						else if (errno == EBADF){
							perror ("EBADF error. The cd argument is not a valid open conversion descriptor.");
							*$a_b = 0;
							break;
						}
						else{
							perror ("Unexpected error.");
							*$a_b = 0;
							break;
						}
					}
				} while (insize);

				if (iconv_close(cd))
					perror("iconv_close");

				*$a_out_count = alloc - avail;
				
				return res;
			]"
		end

	is_codeset_convertable (a_from_codeset, a_to_codeset: POINTER): BOOLEAN is
			-- Is `a_from_codeset' and `a_to_codeset' convertable?
		external
			"C inline use <iconv.h>"
		alias
			"[
				iconv_t cd;
				cd = iconv_open ($a_to_codeset, $a_from_codeset);
				return (EIF_BOOLEAN) (cd != (iconv_t)(-1));
			]"
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

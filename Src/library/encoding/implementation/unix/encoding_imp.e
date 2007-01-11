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
				l_pointer := a_from_string.as_string_32.area.base_address
				l_count := a_from_string.count * 4
			elseif two_byte_codesets.has (a_from_code_page) then
				l_pointer := wide_string_to_pointer (a_from_string.as_string_32)
				l_count := a_from_string.count * 2
			else
				l_pointer := multi_byte_to_pointer (a_from_string.as_string_8)
				l_count := a_from_string.count
			end
			l_pointer := c_iconv (multi_byte_to_pointer (a_from_code_page), multi_byte_to_pointer (a_to_code_page), l_pointer, l_count, $l_out_count)
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
				Result := a_from_string
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

	pointer_to_string_32 (a_w_string: POINTER; a_count: INTEGER_32): STRING_32
		local
			i: INTEGER_32
			l_managed_pointer: MANAGED_POINTER
			l_size: INTEGER_32
		do
			create l_managed_pointer.share_from_pointer (a_w_string, a_count)
			l_size := a_count // 4
			create Result.make (l_size)
			from
				i := 0
			until
				i >= l_size
			loop
				if i * 4 <= a_count then
					Result.append_code (l_managed_pointer.read_natural_32 (i * 4))
				end
				i := i + 1
			end
		end

	c_iconv (a_from_codeset, a_to_codeset: POINTER; a_str: POINTER; a_size: INTEGER; a_out_count: TYPED_POINTER [INTEGER]): POINTER is
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
				
				if (!(res = malloc(alloc))) {
					perror("malloc");
					return NULL;
				}

				wrptr = res;   /* duplicate pointers because they */
				inptr = $a_str; /* get modified by iconv */

				cd = iconv_open ($a_to_codeset, $a_from_codeset);
				if (cd == (iconv_t)(-1)) {
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
								break;
							}
							wrptr = tres + (wrptr - res);
							res = tres;
						}
						else /* something wrong with input */
							break;
					}
				} while (insize);

				if (iconv_close(cd))
					perror("iconv_close");

				*$a_out_count = alloc - avail;
								
				return  (wchar_t*) res;
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

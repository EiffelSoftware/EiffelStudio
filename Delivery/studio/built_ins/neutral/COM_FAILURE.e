class
	COM_FAILURE

feature {NONE} -- External

	frozen ccom_hresult (an_exception_code: POINTER): INTEGER is
		external
			"C inline"
		alias
			"[
				#ifdef EIF_WINDOWS
					char *stopstring = NULL;
					long result = 0, high_bits = 0, low_bits = 0;
					char high_str [7];
					char *exception_code = (char *)($an_exception_code);
					  
					if (NULL != exception_code)
					{
						strncpy (high_str, exception_code, 6);
						high_str [6] = '\0';
		
						high_bits = strtol (high_str, &stopstring, 16);
						low_bits = strtol (exception_code + 6, &stopstring, 16);
						result = (high_bits << 16) + low_bits;
					}
					return (EIF_INTEGER)result;
				#else
					return 0;
				#endif
			]"
		end

	frozen ccom_hresult_code (an_hresult: INTEGER): INTEGER is
		external
			"C inline use %"eif_com.h%""
		alias
			"[
				#ifdef EIF_WINDOWS
					return HRESULT_CODE($an_hresult);
				#else
					return 0;
				#endif
			]"
		end

	frozen ccom_hresult_facility (an_hresult: INTEGER): INTEGER is
		external
			"C inline use %"eif_com.h%""
		alias
			"[
				#ifdef EIF_WINDOWS
					return HRESULT_FACILITY($an_hresult);
				#else
					return 0;
				#endif
			]"
		end

	frozen cwin_error_text (a_code: INTEGER): POINTER is
			-- Get text from error `a_code'. It is up to the caller to free
			-- the returned buffer using `cwin_local_free'.
		external
			"C inline use %"eif_com.h%""
		alias
			"[
				#ifdef EIF_WINDOWS
					LPVOID result;
					FormatMessage( 
						FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
						NULL,
						$a_code,
						MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
						(LPTSTR) &result,
						0,
						NULL 
						);
					return result;
				#else
					return 0;
				#endif
			]"
		end

	frozen c_strlen (ptr: POINTER): INTEGER_32
			-- Number of characters in `ptr'.
		external
			"C inline use %"eif_com.h%""
		alias
			"[
			#ifdef EIF_WINDOWS
				return (EIF_INTEGER_32) _tcslen ((wchar_t *) $ptr);
			#else
				return 0;
			#endif
			]"
		end

	frozen character_size: INTEGER_32
			-- Number of bytes occupied by a TCHAR.
		external
			"C inline use %"eif_com.h%""
		alias
			"[
			#ifdef EIF_WINDOWS
				return sizeof(TCHAR);
			#else
				return 0;
			#endif
			]"
		end

	frozen cwin_local_free (a_ptr: POINTER)
			-- Free `a_ptr' using LocalFree.
		external
			"C inline use %"eif_com.h%""
		alias
			"[
			#ifdef EIF_WINDOWS
				LocalFree((HLOCAL) $a_ptr);
			#endif
			]"
		end

end

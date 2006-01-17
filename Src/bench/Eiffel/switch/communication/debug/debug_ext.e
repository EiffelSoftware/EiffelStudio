indexing
	description: "[
		External routines for debugging
		run-time counterpart: /C/ipc/ewb/eif_out.c
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_EXT

feature

	send_rqst_0 (code: INTEGER) is
		external
			"C"
		end;

	send_rqst_1 (code: INTEGER; info1: INTEGER) is
		external
			"C"
		end;

	send_rqst_2 (code: INTEGER; info1: INTEGER; info2: INTEGER) is
		external
			"C"
		end;

	send_rqst_3 (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: POINTER) is
		external
			"C"
		end;
		
	send_rqst_3_integer (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: INTEGER) is
		do
			send_rqst_3 (code, info1, info2, integer_to_pointer (info3))
		end

	send_integer_value (value: INTEGER) is
		external
			"C"
		end

	send_integer_64_value (value: INTEGER_64) is
			-- 
		external
			"C"
		end
		
	send_real_value (value: REAL) is
		external
			"C"
		end

	send_double_value (value: DOUBLE) is
		external
			"C"
		end

	send_char_value (value: CHARACTER) is
		external
			"C"
		end

	send_bool_value (value: BOOLEAN) is
		external
			"C"
		end

	send_ptr_value (value: POINTER) is
			-- value is the value of the pointer
		external
			"C"
		end

	send_string_value (value: POINTER) is
			-- value is the address of a C string
		external
			"C"
		end

	send_ref_value (value: POINTER) is
			-- value is the address of the object
		external
			"C signature (EIF_REFERENCE)"
		end

	recv_ack: BOOLEAN is
		external
			"C"
		end;

	recv_dead: BOOLEAN is
		external
			"C"
		end;

	c_twrite (data: POINTER; size: INTEGER) is
		external
			"C"
		end;

	c_send_str (str: POINTER) is
		external
			"C"
		end;	

	c_tread: STRING is
		external
			"C"
		end;
		
	integer_to_pointer (i: INTEGER): POINTER is 
			-- Convert integer value `i' in a valid `POINTER' value. 
		external 
			"C inline use %"eif_eiffel.h%"" 
		alias 
			"(EIF_POINTER) $i"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

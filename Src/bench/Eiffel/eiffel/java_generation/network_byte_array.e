indexing
	description: "objects that writes data into a character array. conversion to network byte order (%
					 %big endian) will be done automatically if %
	%neccessary depending on used platform."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	note: "Currently a platform with little endian is assumed, %
	%impelementation must be changed to not convert on %
	%platforms with big endian"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	NETWORK_BYTE_ARRAY

inherit
	CHARACTER_ARRAY
	JVM_CONSTANTS

feature {ANY} -- Element Change
			
	put_uint_8_from_int (i: INTEGER; pos: INTEGER) is
			-- puts the 8 least significant bits of `i' at `pos'
			-- using network byte order
		require
			index_small_enough: pos <= count;
			index_large_enough: pos > 0;
			i_positive: i >= 0
			i_small_enough: i < 256 -- 2^8
		do
			area.put (i.ascii_char, pos)
		end
			
	put_sint_8_from_int (i: INTEGER; pos: INTEGER) is
			-- puts the 8 least significant bits of `i' at `pos'
			-- using network byte order
		require
			index_small_enough: pos <= count;
			index_large_enough: pos > 0;
			i_positive: i >= -128
			i_small_enough: i <= 127
		do
			area.put (i.ascii_char, pos)
		end
			
	put_uint_16_from_int (i: INTEGER; pos: INTEGER) is
			-- put 16 bit unsigned integer
			-- puts the 16 least significant bits of `i' at `pos'
			-- using network byte order
		require
			index_small_enough: (pos + Int_16_size) <= count;
			index_large_enough: pos > 0;
			i_positive: i >= 0
			i_small_enough: i < 65536 -- 2^16
		do
			put_uint_8_from_int (i.bit_shift_right (8), pos)
			put_uint_8_from_int (i.bit_and (0x000000FF), pos + Int_8_size)
		end
			
	put_sint_16_from_int (i: INTEGER; pos: INTEGER) is
			-- put 16 bit singned integer
			-- puts the 16 least significant bits of `i' at `pos'
			-- using network byte order
		require
			index_small_enough: (pos + Int_16_size) <= count;
			index_large_enough: pos > 0;
			i_positive: i >= -32768
			i_small_enough: i <= 32767
		do
			put_sint_8_from_int (i.bit_shift_right (8), pos)
			put_uint_8_from_int (i.bit_and (0x000000FF), pos + Int_8_size)
		end
			
	put_uint_32_from_int (i: INTEGER; pos: INTEGER) is
			-- puts the 32 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			index_small_enough: (pos + Int_32_size) <= count;
			index_large_enough: pos > 0;
			i_positive: i >= 0
			i_small_enough: i < 4294967296 -- 2^32
		do
			put_uint_16_from_int (i.bit_shift_right (16), pos)
			put_uint_16_from_int (i.bit_and (0x0000FFFF), pos + Int_16_size)
		end
			
	put_sint_32_from_int (i: INTEGER; pos: INTEGER) is
			-- puts the 32 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			index_small_enough: (pos + Int_32_size) <= count;
			index_large_enough: pos > 0;
			i_big_enough: i >= -2147483648
			i_small_enough: i <= 2147483647
		do
			put_sint_16_from_int (i.bit_shift_right (16), pos)
			put_uint_16_from_int (i.bit_and (0x0000FFFF), pos + Int_16_size)
		end
			
	put_uint_64_from_int_64 (i: INTEGER_64; pos: INTEGER) is
			-- puts the 64 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			index_small_enough: (pos + Int_64_size) <= count;
			index_large_enough: pos > 0;
			i_positive: i >= 0
			i_small_enough: i < {INTEGER_64}.max_value
		do
			check
				TODO:False
			end
			-- still missing int 64 to int 32 conversion (in class INTEGER_64)
		end
			
	put_sint_64_from_int_64 (i: INTEGER_64; pos: INTEGER) is
			-- puts the 64 least significant bits of `i' at `pos'
			-- using network byte order
			-- Note: on most machines INTEGER is only 32 bit and signed,
			-- so there should never be an overflow here
		require
			index_small_enough: (pos + Int_64_size) <= count;
			index_large_enough: pos > 0;
			i_large_enough: i >= -9223372036854775808
			i_small_enough: i < 9223372036854775807
		do
			check
				TODO:False
			end
			-- still missing int 64 to int 32 conversion (in class INTEGER_64)
		end
			
	put_utf8_from_string (s: STRING; pos: INTEGER) is
			-- puts `s' at pos
			-- byte for byte from `s' will be written to the array
			-- there will be no additional info on size or a terminating
			-- zero character. You have to provide this information yourself
		require	
			index_small_enough: (pos + Int_16_size + s.count) <= count;
			index_large_enough: pos > 0;
			s_not_void: s /= Void
			s_short_enought: s.count < 65536 -- 2^16
		do
			check
				False -- TODO
			end
		end
			
	put_double_from_double (d: DOUBLE; pos: INTEGER) is
			-- Note: `ca_wdouble' does not seem to work. FIXME
		require
			index_small_enough: (pos + Double_size) <= count;
			index_large_enough: pos > 0;
		do
			ca_wdouble ($area, d, pos - 1)
		end

	put_float_from_real (f: REAL; pos: INTEGER) is
			-- Note: `ca_wdouble' does not seem to work. FIXME
		require
			index_small_enough: (pos + Double_size) <= count;
			index_large_enough: pos > 0;
		do
			check
				TODO: False
			end
		end

feature {NONE} --
			
	ca_wdouble (ptr: POINTER; val: DOUBLE; pos: INTEGER) is
			-- Note: This does not seem to write the double into the
			-- memory as Java would expect it. FIXME
		external
			"C"
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

end -- class NETWORK_BYTE_ARRAY
										
										
										
										

										




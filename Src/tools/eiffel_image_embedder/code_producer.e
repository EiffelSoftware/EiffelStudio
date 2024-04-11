note
	description: "[
					Eiffel source code generator which generate a EV_PIXEL_BUFFER descendant class.
					The class have all image pixel data and can be created directly without original
					png file.
																									]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PRODUCER

feature -- Commands

	build_c_external_data_code (a_pixel_buffer: EV_PIXEL_BUFFER): STRING
			-- Build C external features where we store all image raw data.
			-- We use C char array to store image data. If we use C uint32 array, on Windows the
			-- final compiled exe size will be 3 times bigger when using Microsoft C compiler.
			-- However, on Linux there is no size differences between using C char array and C uint32
			-- array.
			-- There is big endian difference bewteen the case when using C char array and the case when
			-- using C unint32 array.
		require
			not_void: a_pixel_buffer /= Void
		local
			l_feature_count, l_offset_count: INTEGER
			l_line_max_length: INTEGER
			l_iterator: EV_PIXEL_BUFFER_ITERATOR
			l_pixel: EV_PIXEL_BUFFER_PIXEL
		do
			from
				a_pixel_buffer.lock
				l_iterator := a_pixel_buffer.pixel_iterator
				l_iterator.start
				c_external_data_features_count := a_pixel_buffer.width * a_pixel_buffer.height // c_external_data_offset + 1
				create Result.make_empty
				last_tab_indention := 0
				Result.append ("feature {NONE} -- Image data" + new_line)
				Result.append (new_line)
				l_line_max_length := 80
			until
				l_feature_count >= c_external_data_features_count
			loop
				if l_iterator.after then
					c_external_data_features_count := c_external_data_features_count - 1
				else
					last_tab_indention := 1
					Result.append (tab (0) + "c_colors_" + l_feature_count.out + " (a_ptr: POINTER; a_offset: INTEGER)" + new_line)
					Result.append (tab (2) + "-- Fill `a_ptr' with colors data from `a_offset'." + new_line)
					Result.append (tab (-1) + "external" + new_line)
					Result.append (tab (1) + "%"C inline%"" + new_line)
					Result.append (tab (-1) + "alias" + new_line)
					Result.append (tab (1) + "%"[" + new_line)
					Result.append (tab (0) + "{" + new_line)
					Result.append (tab (1) + "#define B(q) \" + new_line)
					Result.append (tab (1) + "#q" + new_line)
					Result.append (tab (-1) + "#ifdef EIF_WINDOWS" + new_line)
					Result.append (tab (0) + "#define A(a,r,g,b) \" + new_line)
					Result.append (tab (1) + "B(\x##b\x##g\x##r\x##a)" + new_line)
					Result.append (tab (-1) + "#else" + new_line)
					Result.append (tab (0) + "#define A(a,r,g,b) \" + new_line)
					Result.append (tab (1) + "B(\x##r\x##g\x##b\x##a)" + new_line)
					Result.append (tab (-1) + "#endif" + new_line)

					Result.append (tab (0) + "char l_data[] = " + new_line)

					from
						l_offset_count := 0

					until
						l_offset_count >= c_external_data_offset or l_iterator.after
					loop
						l_pixel := l_iterator.item
						if l_offset_count = 0 then
							Result.append (tab(0))
						end
						if l_offset_count \\ l_line_max_length = 0 and l_offset_count /= 0 then
							Result.append (new_line + tab(0))
						end

						Result.append ("A(" + l_pixel.alpha.to_hex_string + "," + l_pixel.red.to_hex_string + "," + l_pixel.green.to_hex_string + "," + l_pixel.blue.to_hex_string + ")")

						l_iterator.forth
						l_offset_count := l_offset_count + 1
					end

					Result.append (";" + new_line)
					-- `sizeof l_data' should minus one sice there is additional `0' added by C compiler automatically.
					Result.append (tab (0) + "memcpy ((EIF_NATURAL_32 *)$a_ptr + $a_offset, &l_data, sizeof l_data - 1);" + new_line)
					Result.append (tab (-1) + "}" + new_line)
					Result.append (tab (0) + "]%"" + new_line)
					Result.append (tab (-1) + "end" + new_line)
					Result.append (new_line)
					l_feature_count := l_feature_count + 1
				end
			end
		end

	build_colors_code: STRING
			-- Build colors creating code.
			-- Use array instead of tuple to store colors do create Result.make_empty
		local
			l_i: INTEGER
		do
			last_tab_indention := 1
			create Result.make (200)
			Result.append (tab (0) + "build_colors (a_ptr: POINTER)" + new_line)
			Result.append (tab (2) + "-- Build `colors'." + new_line)
			Result.append (tab (-1) + "do" + new_line)
			from
				check build_c_external_data_code_called: c_external_data_features_count > 0 end
				last_tab_indention := last_tab_indention + 1
			until
				l_i >= c_external_data_features_count
			loop
				Result.append ((tab (0) + "c_colors_" + l_i.out + " (a_ptr, " + (l_i * c_external_data_offset).out + ")" + new_line))
				l_i := l_i + 1
			end

			Result.append (tab (-1) + "end" + new_line)
		end

	build_draw_point_code (a_color: NATURAL_32): STRING
			-- Build single color creating code.
		do
			Result := "0x" + a_color.to_hex_string
		end

	build_top_code (class_name: STRING): STRING
			-- Build code of the class before initialization code.
		do
			create Result.make_empty
			Result.append ("note" + new_line)
			Result.append ("%Tdescription: %"[" + new_line)
			Result.append ("%T%T%TPixel buffer that replaces original image file." + new_line)
			Result.append ("%T%T%TThe original version of this class has been generated by Image Eiffel Code." + new_line)
			Result.append ("%T%T]%"")
			Result.append (new_line)
			Result.append ("class" + new_line)
			Result.append ("%T" + class_name.as_upper + new_line)
			Result.append (new_line)
			Result.append ("inherit" + new_line)
			Result.append ("%TEV_PIXEL_BUFFER" + new_line)
			Result.append (new_line)
			Result.append ("create" + new_line)
			Result.append ("%Tmake" + new_line)
			Result.append (new_line)
		end

	build_initialization_code (a_width, a_height: INTEGER) : STRING
			-- Build initialization code.
		do
			create Result.make_empty
			Result.append ("feature {NONE} -- Initialization" + new_line)
			Result.append (new_line)
			Result.append ("%Tmake" + new_line)
			Result.append ("%T%T%T-- Initialization" + new_line)
			Result.append ("%T%Tdo" + new_line)
			Result.append ("%T%T%Tmake_with_size (" + a_width.out + ", " + a_height.out + ")" + new_line)

			Result.append ("%T%T%Tfill_memory" + new_line)
			Result.append ("%T%Tend" + new_line)
			Result.append (new_line)
		end

	build_fill_memory_code (a_colors: ARRAYED_LIST [ARRAYED_LIST [NATURAL_32]]; a_width, a_height: INTEGER): STRING
			-- Build implementation code.
		do
			last_tab_indention := 0
			create Result.make_from_string (
				"[
feature {NONE} -- Image data filling.

	fill_memory
			-- Fill image data into memory.
		local
			l_pointer: POINTER
		do
			if attached {EV_PIXEL_BUFFER_IMP} implementation as l_imp then
				l_pointer := l_imp.data_ptr
				if not l_pointer.is_default_pointer then
					build_colors (l_pointer)
					l_imp.unlock
				end
			end
		end

				]"
			)
		end

feature -- Helper featuers

	new_line: STRING
			-- New line
		do
			create Result.make_from_string ("%N")
		end

feature {NONE} -- Implementation

	c_external_data_features_count: INTEGER
			-- How many c_colors_X features generated?

	c_external_data_offset: INTEGER = 400
			-- Eiffel Language have manifest string limitation which is 32k.
			-- We can't generated c external features as long as we want.
			-- Hope the limitation can be removed in the future. (2007-Aug-22)

	last_tab_indention: INTEGER
			-- Last tab indention.

	tab (a_add: INTEGER): STRING
			-- `a_add' can be negative.
		local
			l_i: INTEGER
		do
			from
				l_i := 0
				last_tab_indention := last_tab_indention + a_add
				create Result.make_empty
			until
				l_i >= last_tab_indention
			loop
				Result := Result + "%T"
				l_i := l_i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

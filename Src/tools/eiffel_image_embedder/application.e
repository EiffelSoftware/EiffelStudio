note
	description	: "Root class for this application."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date		: "$Date$"
	revision	: "1.0.0"

class
	APPLICATION

inherit
	ARGUMENTS_32

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize and launch application
		local
			gui: GUI_APPLICATION
			is_gui: BOOLEAN
			i,n: INTEGER
			arg: STRING_32
			pix_src: PATH
			l_output: PATH
		do
			is_gui := True
			from
				i := 1
				n := argument_count
			until
				i > n
			loop
				arg := argument (i)
				if arg.is_case_insensitive_equal_general ("--gui") then
					is_gui := True
				elseif arg.is_case_insensitive_equal_general ("--pixmap") then
					i := i + 1
					arg := argument (i)
					is_gui := False
					create pix_src.make_from_string (arg)
				elseif arg.is_case_insensitive_equal_general ("--output") then
					i := i + 1
					arg := argument (i)
					create l_output.make_from_string (arg)
				elseif arg.starts_with_general ("-") then
					io.error.put_string_32 ({STRING_32} "Ignore option: " + arg + "%N")
				elseif pix_src = Void then
					is_gui := False
					create pix_src.make_from_string (arg)
				elseif l_output = Void then
					is_gui := False
					create l_output.make_from_string (arg)
				else
					io.error.put_string_32 ({STRING_32} "Ignore argument: " + arg + "%N")
				end
				i := i + 1
			end
			if is_gui then
				create gui.make_and_launch
			elseif pix_src /= Void then
				generate_eiffel_class (pix_src, l_output)
			else
				io.error.put_string ("[
					Usage:
						--gui: force GUI mode
						--pixmap path:  pixmap location
						--output path:  optional Eiffel class output location						
					]")
			end
		end

	generate_eiffel_class (pix_fn: PATH; a_output: detachable PATH)
		local
			eimgemb: EIMGEMB
			pix: EV_PIXEL_BUFFER
			cl, txt: STRING_8
			fut: FILE_UTILITIES
			f: PLAIN_TEXT_FILE
			ofn: PATH
		do
			create fut
			if fut.file_path_exists (pix_fn) then
				create pix
				pix.set_with_named_path (pix_fn)

				create eimgemb.make (pix)
				if a_output /= Void then
					ofn := a_output
					cl := eimgemb.eiffel_class_name_suggestion (a_output)
				else
					cl := eimgemb.eiffel_class_name_suggestion (pix_fn)
					ofn := eimgemb.eiffel_file_name_suggestion (pix_fn)
				end
				txt := eimgemb.to_eiffel_class_text (cl)
				create f.make_with_path (ofn)
				f.create_read_write
				f.put_string (txt)
				f.close
			else
				io.error.put_string_32 ({STRING_32} "File not found: " + pix_fn.name + "%N")
			end
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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

end -- class APPLICATION

note
	description: "Pixmap file loading helper"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PIXMAP_LOAD_HELPER

feature -- Loading

	loaded_pixmap_from_file (a_file: PATH; a_default_pixmap: EV_PIXMAP; a_default_buffer: EV_PIXEL_BUFFER): TUPLE [a_pixmap: EV_PIXMAP; a_buffer: EV_PIXEL_BUFFER]
			-- Loaded pixmap as well as its pixel buffer from `a_file'.
			-- If loading failed, `a_buffer' will be `a_default_buffer' if set, otherwise `a_buffer' will be Void;
			-- and `a_pixmap' will be `a_default_pixmap' if set, otherwise `a_pixmap' will be Void too.
		require
			a_file_attached: a_file /= Void
		local
			l_retried: BOOLEAN
			l_file: RAW_FILE
			l_buffer: EV_PIXEL_BUFFER
			l_pixmap: EV_PIXMAP
		do
			if not l_retried and not a_file.is_empty then
				create l_buffer
				create l_file.make_with_path (a_file)
				if l_file.exists and then l_file.is_readable then
					l_buffer.set_with_named_path (a_file)
					l_pixmap := l_buffer.sub_pixmap (create {EV_RECTANGLE}.make (0, 0, l_buffer.width, l_buffer.height))
				end
			end
			if l_pixmap = Void then
				l_pixmap := a_default_pixmap
			end
			-- `l_buffer' is not void after exceptions in exectuing `set_with_named_path'.
			-- We need to check `l_retried' here.
			if l_buffer = Void or l_retried then
				l_buffer := a_default_buffer
			end
			Result := [l_pixmap, l_buffer]
		rescue
			l_retried := True
			retry
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

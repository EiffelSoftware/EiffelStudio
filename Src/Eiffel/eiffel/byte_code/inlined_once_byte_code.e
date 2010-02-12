note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class INLINED_ONCE_BYTE_CODE

inherit
	ONCE_BYTE_CODE
		undefine
			has_inlined_code
		end

	INLINED_BYTE_CODE
		undefine
			append_once_mark,
			is_once, is_process_relative_once, is_object_relative_once,
			pre_inlined_code, inlined_byte_code_type, generate_once_declaration,
			generate_once_data, generate_once_prologue, generate_once_epilogue
		redefine
			make
		end

create
	make

feature -- Update

	make (std: STD_BYTE_CODE)
			-- Initialize current from non-inlined `std'.
		do
			Precursor {INLINED_BYTE_CODE} (std)
			if std.is_process_relative_once then
				set_is_process_relative_once
			elseif std.is_object_relative_once then
				set_is_object_relative_once
			else --| default: if std.is_thread_relative_once
				set_is_thread_relative_once
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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

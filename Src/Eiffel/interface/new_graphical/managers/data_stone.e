note
	description: "Stone which can contain any data"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_STONE

inherit
	STONE
		redefine
			is_valid,
			is_storable
		end

create
	default_create,
	make

feature{NONE} -- Initializatioin

	make (a_data: like data; a_validity_func: like validity_function)
			-- Initialize `data' with `a_data'.
		do
			set_data (a_data)
			set_validity_function (a_validity_func)
		end

feature -- Properties

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone.
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
			Result := Cursors.cur_cluster
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
			-- Default is Void, meaning no cursor is associated with `Current'.
		do
			Result := Cursors.cur_x_Cluster
		end

	stone_signature: STRING
			-- Short string to describe Current
			-- (basically the name of the stoned object).
		do
			Result := "Groups stone"
		end

	header: STRING_GENERAL
			-- String to describe Current
			-- (as it may be described in the title of a development window).
		do
			Result := stone_signature.as_string_32
		end

	history_name: STRING_32
			-- Name used in the history list,
			-- (By default, it is the stone_signature
			-- and a string to describe the type of stone (Class, feature,...)).
		do
			Result := stone_signature
		end

	data: ANY
			-- List of groups contained in Current stone

	validity_function: FUNCTION [ANY, TUPLE [ANY], BOOLEAN]
			-- Function used to check if `data' is valid
			-- If not set, `data' is considered to be valid by default.

feature -- Status report

	is_valid: BOOLEAN
			-- Is `data' valid?
		do
			if validity_function = Void then
				Result := True
			else
				Result := validity_function.item ([data])
			end
		end

	is_storable: BOOLEAN
			-- Can `Current' be kept?
			-- False by default.
		do
			Result := False
		end

feature -- Setting

	set_data (a_data: like data)
			-- Set `data' with `a_data'.
		do
			data := a_data
		end

	set_validity_function (a_validity_function: like validity_function)
			-- Set `validity_function' with `a_validity_function'.
		do
			validity_function := a_validity_function
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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

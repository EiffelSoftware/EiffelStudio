indexing
	description	: " Multi column list tooltipable (on windows for now)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "$Author$"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MULTI_COLUMN_LIST_ROW

inherit
	EV_MULTI_COLUMN_LIST_ROW

create
	default_create

create {EB_MULTI_COLUMN_LIST_ROW}
	make_filled

feature -- Element access

	tooltip: STRING is
			-- Tooltip displayed on `Current'.
		do
			Result := implementation.tooltip
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			implementation.set_tooltip (a_tooltip)
		end
		
	remove_tooltip is
			-- Make `tooltip' empty.
		do
			implementation.remove_tooltip
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

end -- class EB_MULTI_COLUMN_LIST_ROW

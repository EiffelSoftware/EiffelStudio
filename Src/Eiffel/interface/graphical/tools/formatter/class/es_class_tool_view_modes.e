indexing
	description: "[
		Various view modes for the class tool {ES_CLASS_TOOL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CLASS_TOOL_VIEW_MODES

feature -- Access

	basic: NATURAL_8 = 0x00
			-- Clickable mode

	clickable: NATURAL_8 = 0x01
			-- Clickable mode

	flat: NATURAL_8 = 0x02
			-- Flat mode

	short: NATURAL_8 = 0x03
			-- Short mode

	flat_short: NATURAL_8 = 0x04
			-- Flat short mode

	ancestors: NATURAL_8 = 0x10
			-- Class ancestors mode

	descendents: NATURAL_8 = 0x11
			-- Class descendents mode

	clients: NATURAL_8 = 0x12
			-- Class clients mode

	suppliers: NATURAL_8 = 0x13
			-- Class suppliers mode

	attributes: NATURAL_8 = 0x20
			-- Class attribute features mode

	routines: NATURAL_8 = 0x21
			-- Class routine features mode

	invariants: NATURAL_8 = 0x22
			-- Class invariants mode

	creators: NATURAL_8 = 0x23
			-- Class creation routines mode

	deferreds: NATURAL_8 = 0x24
			-- Class deferred features mode

	onces: NATURAL_8 = 0x25
			-- Class once features mode

	externals: NATURAL_8 = 0x26
			-- Class external features mode

	exported: NATURAL_8 = 0x27
			-- Class fully exported features mode

	custom: NATURAL_8 = 0xFF
			-- Custom formatter mode

feature -- Query

	is_valid_mode (a_mode: NATURAL_8): BOOLEAN
			-- Determines if a mode is a valid class view mode.
			--
			-- `a_mode': Mode to determine for validity
			-- `Result': True if the mode is valid; False otherwise.
		do
			Result := (a_mode = basic or else
				a_mode = clickable or else
				a_mode = flat or else
				a_mode = short or else
				a_mode = flat_short or else
				a_mode = ancestors or else
				a_mode = descendents or else
				a_mode = clients or else
				a_mode = suppliers or else
				a_mode = attributes or else
				a_mode = routines or else
				a_mode = invariants or else
				a_mode = creators or else
				a_mode = deferreds or else
				a_mode = onces or else
				a_mode = externals or else
				a_mode = exported or else
				a_mode = custom)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

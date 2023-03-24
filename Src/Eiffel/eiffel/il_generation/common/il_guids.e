note
	description: "Predefined GUIDs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	IL_GUIDS

feature -- Access

	language_guid: CIL_GUID
			-- Language guid used to identify our language when debugging.
		once
			create Result.make (0xE1FFE11E, 0x8195, 0x490C,
				{ARRAY [NATURAL_8]} <<0x87, 0xEE, 0xA7, 0x13, 0x30, 0x1A, 0x67, 0x0C>>)
		ensure
			language_guid_not_void: language_guid /= Void
		end

	vendor_guid: CIL_GUID
			-- Vendor guid used to identify us when debugging.
		once
			create Result.make (0xE1FFE10E, 0x9424, 0x485F,
				{ARRAY [NATURAL_8]} <<0x82, 0x64, 0xD4, 0xA7, 0x26, 0xC1, 0x62, 0xE7>>)
		ensure
			vendor_guid_not_void: vendor_guid /= Void
		end

	document_type_guid: CIL_GUID
			-- Document type guid.
		once
			create Result.make_empty
		ensure
			document_type_guid_not_void: document_type_guid /= Void
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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

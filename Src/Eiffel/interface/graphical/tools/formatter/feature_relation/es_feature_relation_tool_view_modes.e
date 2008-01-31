indexing
	description: "[
		Various view modes for the feature relation tool {ES_FEATURE_RELATION_TOOL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_FEATURE_RELATION_TOOL_VIEW_MODES

feature -- Access

	basic: NATURAL_8 = 0x00
			-- Basic text mode

	flat: NATURAL_8 = 0x01
			-- Flat, clickable mode

	callers: NATURAL_8 = 0x12
			-- Feature callers mode

	assigners: NATURAL_8 = 0x13
			-- Feature callers assigners

	creators: NATURAL_8 = 0x14
			-- Feature creators mode

	callees: NATURAL_8 = 0x20
			-- Feature callees mode

	assignees: NATURAL_8 = 0x21
			-- Feature assignees mode

	creations: NATURAL_8 = 0x22
			-- Feature creations mode

	implementers: NATURAL_8 = 0x30
			-- Implementers mode

	ancestors: NATURAL_8 = 0x31
			-- Ancestors implementations mode

	descendants: NATURAL_8 = 0x32
			-- Decendant implementations mode

	homonyms: NATURAL_8 = 0x40
			-- Homonyms features mode. Be careful when using this feature as it may take a long time.

	custom: NATURAL_8 = 0xFF
			-- Custom formatter mode

feature -- Query

	is_valid_mode (a_mode: NATURAL_8): BOOLEAN
			-- Determines if a mode is a valid feature view mode.
			--
			-- `a_mode': Mode to determine for validity
			-- `Result': True if the mode is valid; False otherwise.
		do
			Result := (a_mode = basic or
				a_mode = flat or
				a_mode = callers or
				a_mode = assigners or
				a_mode = creators or
				a_mode = callees or
				a_mode = assignees or
				a_mode = creations or
				a_mode = implementers or
				a_mode = ancestors or
				a_mode = descendants or
				a_mode = custom)
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

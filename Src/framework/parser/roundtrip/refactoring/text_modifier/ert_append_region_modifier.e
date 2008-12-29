note
	description: "Region modifier for appending text to AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_APPEND_REGION_MODIFIER

inherit
	ERT_ADDITION_REGION_MODIFIER

	COMPARABLE

create
	make

feature{NONE} -- Initialization

	make (a_index: INTEGER; a_region: ERT_TOKEN_REGION; a_text: STRING)
			-- Initialize instance.
		require
			a_region_not_void: a_region /= Void
			a_text_not_void: a_text /= Void
		do
			initialize (a_index, a_region)
			text := a_text.twin
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Status reporting

	is_prepended_to (a_index: INTEGER): BOOLEAN
			-- Dose current modifier prepend to `a_index'?
		do
			Result := False
		end

	is_appended_to (a_index: INTEGER): BOOLEAN
			-- Dose current modifier append to `a_index'?
		do
			Result := end_index = a_index
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			check
				not region.is_overlap_region (other.region)
			end
			if region.is_equivalent (other.region) then
				Result := index < other.index
			else
				if region.end_index = other.region.end_index then
					Result := region.start_index > other.region.start_index
				else
					Result := region.end_index < other.region.end_index
				end
			end
		end

feature{LEAF_AS_LIST} -- Modify

	apply (a_list: LEAF_AS_LIST)
			-- Apply current modifier.
		do
			a_list.active_modifier_list.extend (Current)
			a_list.active_append_modifier_list.extend (Current)
			applied := True
		end

note
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
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

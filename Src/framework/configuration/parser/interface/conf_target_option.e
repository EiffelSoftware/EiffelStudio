note
	description: "A configuration target option."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_TARGET_OPTION

inherit
	CONF_OPTION
		redefine
			default_create,
			make_6_3,
			merge
		end

create
	default_create,
	make_6_3,
	make_6_4,
	make_7_0,
	make_7_3,
	make_14_05,
	make_15_11,
	make_16_11

feature {NONE} -- Creation

	default_create
			-- <Precursor>
		do
			make_16_11
		end

	make_6_3
			-- <Precursor>
		do
			Precursor
			create concurrency.make (concurrency_name, concurrency_index_none)
			create void_safety_capability.make (void_safety)
			create catcall_safety_capability.make (catcall_detection)
			create concurrency_capability.make (concurrency)
		end

	make_16_11
			-- <Precursor>
			-- Difference from `make_15_11': SCOOP for concurrency.
		do
			make_15_11
			concurrency.put_default_index (concurrency_index_scoop)
		end

feature -- Capability

	void_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for void safety.

	catcall_safety_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for catcall safety.

	concurrency_capability: CONF_ORDERED_CAPABILITY
			-- Capability settings for concurrency.

feature -- Access: concurrency

	concurrency: CONF_VALUE_CHOICE
			-- Concurrency option.

	concurrency_index_thread: NATURAL_8 = 1
			-- Option index for thread-based concurrency.
			-- This is the lowest level, least restricted.

	concurrency_index_none: NATURAL_8 = 2
			-- Option index for no concurrency.

	concurrency_index_scoop: NATURAL_8 = 3
			-- Option index for SCOOP concurrency.
			-- This is the highest level, most restricted.

feature -- Merging

	merge (other: like Current)
			-- <Precursor>
		do
			Precursor (other)
				-- Merge concurency capability.
			concurrency.set_safely (other.concurrency)
				-- Merge CAT-call and void safety: only root settings need to be merged because capabilities are merged by precursor.
			catcall_safety_capability.set_safely_root (other.catcall_safety_capability)
			void_safety_capability.set_safely_root (other.void_safety_capability)
		end

feature {NONE} -- Access: concurrency

	concurrency_name: ARRAY [READABLE_STRING_32]
			-- Available values for `concurrency' option.
		once
			Result := <<
					{CONF_CONSTANTS}.concurrency_multithreaded_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_none_name.as_string_32,
					{CONF_CONSTANTS}.concurrency_scoop_name.as_string_32
				>>
		ensure
			result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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

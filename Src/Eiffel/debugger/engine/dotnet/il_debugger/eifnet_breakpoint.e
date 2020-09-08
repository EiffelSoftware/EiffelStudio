note
	description: ".NET breakpoint"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_BREAKPOINT

inherit

	DEBUG_OUTPUT
		redefine
			is_equal
		end

	HASHABLE
		redefine
			is_equal
		end

	ICOR_EXPORTER
		redefine
			is_equal
		end

create
	make

feature

	make (a_bp_loc: BREAKPOINT_LOCATION; a_module_key: STRING_32; a_class, a_feature: NATURAL_32; a_line: INTEGER)
			-- Initialize BP item data
		require
			module_key_lower_case: is_lower_case (a_module_key)
		do
			breakpoint_location := a_bp_loc
			module_key := a_module_key
			class_token := a_class
			feature_token := a_feature
			break_index := a_line.as_natural_32 --| FIXME: truncated from INTEGER
		end

feature -- Hashable interface

	hash_code: INTEGER
			-- Hash code used for HASH_TABLE
		do
			Result := ([module_key, class_token, feature_token, break_index]).hash_code
			--| if overflow
			if Result < 0 then
				Result := - Result
			end
		end

feature -- comparison

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to `Current'?
			-- `other' equals to `Current' if they represent
			-- the same physical breakpoint, in other words they
			-- have the same `body_index' and `offset'.
			-- We use 'body_index' because it does not change after
			-- a recompilation
		do
			Result := (other.break_index = break_index)
					and then other.module_key.is_equal (module_key)
					and then other.class_token = class_token
					and then other.feature_token = feature_token
		end

feature -- Access assertion

	is_lower_case (a_string: STRING): BOOLEAN
			-- is `a_string' in lower case
			-- used in assertion
		require
			not_void: a_string /= Void
		do
			Result := a_string.as_lower.is_equal (a_string)
		end

feature -- access

	breakpoint_location: BREAKPOINT_LOCATION
			-- Corresponding eStudio BREAKPOINT

	module_key: STRING_32
			-- modulename view as key
			-- this means in our case, lowered

	class_token: NATURAL_32
			-- class token

	feature_token: NATURAL_32
			-- feature token

	break_index: NATURAL_32
			-- il line index (il offset)

feature -- dotnet properties

	icor_breakpoint: ICOR_DEBUG_BREAKPOINT
			-- Corresponding ICorDebugBreakpoint

	set_icor_breakpoint (a_val: like icor_breakpoint)
			-- Set `icor_breakpoint' to `a_val'.
		do
			icor_breakpoint := a_val
		end

feature -- status

	is_active: BOOLEAN
			-- Is Current an active Breakpoint ?

	enabled: BOOLEAN
			-- Is Current enabled ?

feature -- change

	enable
			-- Enable the Current breakpoint.
		do
			enabled := True
		end

	disable
			-- Disable the Current breakpoint.
		do
			enabled := False
		end

	activate
			-- Activate the Current breakpoint.
		do
			is_active := True
		end

	unactivate
			-- UnActivate the Current breakpoint.
		do
			is_active := False
		end

feature -- debug output

	debug_output: STRING
			-- Debug output value
			-- debug purpose only
		do
			Result := "BP: "
						+ "Class  [" + class_token.out + "] "
						+ "Feature[" + feature_token.out +"] "
						+ "Index  [" + break_index.out +"] "
						+ "Module [" + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (module_key) + "] "
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

end -- class EIFNET_BREAKPOINT

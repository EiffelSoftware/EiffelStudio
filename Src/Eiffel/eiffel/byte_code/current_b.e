﻿note
	description: "Access to Current."
	legal: "See notice at end of class."
	status: "See notice at end of class."

class CURRENT_B

inherit

	ACCESS_B
		redefine
			c_type,
			enlarged,
			is_current,
			is_fast_as_local,
			pre_inlined_code,
			print_checked_target_register,
			print_register,
			register_name
		end

	SHARED_TYPE_I

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_current_b (Current)
		end

feature

	type: LIKE_CURRENT
			-- Current type
		do
			create Result.make (context.current_type)
				-- Current is always attached
			Result.set_attached_mark
				-- Current is always frozen
			Result.set_frozen_mark
		end

	c_type: TYPE_C
			-- <Precursor>
			-- Current is always of a reference type.
		once
			Result := reference_c_type
		end

	is_current: BOOLEAN
			-- This is an access to Current
		do
			Result := True
		end

	same (other: ACCESS_B): BOOLEAN
			-- Is `other' the same access as Current ?
		do
			Result := attached {CURRENT_B} other
		end

	enlarged: CURRENT_B
			-- Enlarges the tree to get more attributes and returns the
			-- new enlarged tree node.
		do
				-- This is the root of the call tree
			create {CURRENT_BL} Result
		end

	register_name: STRING
			-- The "Current" string
		once
			Result := {C_CONST}.current_name
		end

	print_register
			-- Print "Current" register
		do
			context.buffer.put_string ({C_CONST}.current_name)
		end

feature {REGISTRABLE} -- C code generation

	print_checked_target_register
			-- <Precursor>
		do
				-- Current is always attached, no need to check for void.
			context.buffer.put_string ({C_CONST}.current_name)
		end

feature -- IL code generation

	is_fast_as_local: BOOLEAN = true
			-- Is expression calculation as fast as loading a local?

feature -- Inlining

	pre_inlined_code: CURRENT_B
			-- <Precursor>
		do
			create {INLINED_CURRENT_B} Result
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

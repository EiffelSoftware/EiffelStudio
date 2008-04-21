indexing
	description: "Access to an object-test local."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class OBJECT_TEST_LOCAL_B

inherit
	LOCAL_B
		redefine
			array_descriptor,
			assigns_to,
			enlarged,
			is_creatable,
			pre_inlined_code,
			process,
			register_name,
			same,
			type
		end

create
	make

feature {NONE} -- Creation

	make (p: like position; b: like body_id)
			-- Create an object test local descriptor with position `p' in body `b'
		do
			position := p
			body_id := b
		ensure
			position_set: position = p
			body_id_set: body_id = b
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_object_test_local_b (Current)
		end

feature -- Status report

	is_creatable: BOOLEAN is False
			-- Can an access to a local variable be the target for
			-- a creation ?

feature -- Access

	body_id: INTEGER
			-- Body id of the feature that declares this local

	type: TYPE_A
			-- Local type
		local
			p: like position
		do
			p := context.object_test_local_position (Current)
			if not system.il_generation and system.in_final_mode and then system.inlining_on then
					-- {BYTE_CONTEXT}.local_list might be not initialized,
					-- but we can use recorded locals of the current feature
					-- because the object test local is not inherited.
				Result := context.byte_code.locals.item (p)
			else
				Result := context.local_list.i_th (p)
			end
		end

feature -- Comparison

	same (other: ACCESS_B): BOOLEAN is
			-- Is `other' the same access as Current ?
		do
			if {o: OBJECT_TEST_LOCAL_B} other then
				Result := o.position = position and then
					o.body_id = body_id
			end
		end

feature -- C code generation

	enlarged: OBJECT_TEST_LOCAL_B is
			-- Enlarge current node
		do
			create {OBJECT_TEST_LOCAL_BL} Result.make_from (Current)
		end

	register_name: STRING is
			-- The "otl<body_id>_<pos>" string
		do
			create Result.make (6)
			Result.append_string ("loc")
			Result.append_integer (context.object_test_local_position (Current))
		end

feature -- Array optimization

	assigns_to (i: INTEGER): BOOLEAN is
		do
				-- False here.
		end

	array_descriptor: INTEGER is
		do
			Result := - context.object_test_local_position (Current)
		end

feature -- Inlining

	pre_inlined_code: INLINED_OBJECT_TEST_LOCAL_B is
		do
			create Result.make_from (Current)
		end

indexing
	copyright:	"Copyright (c) 2008, Eiffel Software"
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

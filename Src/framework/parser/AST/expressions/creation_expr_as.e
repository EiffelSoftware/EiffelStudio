note
	description: "Abstract description of an Eiffel creation expression call."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CREATION_EXPR_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

feature {NONE} -- Initialization

	initialize (a: BOOLEAN; t: like type; c: like call)
			-- Create a new CREATION_EXPR AST node.
		require
			t_not_void: t /= Void
		do
			is_active := a
			type := t
			call := c
		ensure
			is_active_set: is_active = a
			type_set: type = t
			call_set: call = c
		end

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>
			--
			-- Although the expression is always attached, its computation may be sophisticated.
			-- Treating is as detachable allows for using it in assertions like
			--     expected_data: attached (create {FOO}.make (something_complicated)) as foo
			--     is_valid: some_checks_on (foo)

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_creation_expr_as (Current)
		end

feature -- Access

	is_active: BOOLEAN
			-- Is creation region active (for separate types)?

	type: TYPE_AS
			-- Creation Type.

	call: detachable ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result :=
				is_active = other.is_active and then
				equivalent (call, other.call) and then
				equivalent (type, other.type)
		end

invariant
		-- A creation expression contains its type
	type_exists: type /= Void

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

end

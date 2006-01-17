indexing
	description: "Node for a creation instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class CREATION_AS

inherit
	INSTRUCTION_AS

feature {NONE} -- Initialization

	initialize (tp: like type; tg: like target; c: like call) is
			-- Create a new CREATION AST node.
		require
			tg_not_void: tg /= Void
		do
			type := tp
			target := tg
			call := c
		ensure
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_creation_as (Current)
		end

feature -- Attributes

	type: TYPE_AS
			-- Creation type

	target: ACCESS_AS
			-- Target to create

	call: ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

invariant
	target_not_void: target /= Void

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

end -- class CREATION_AS

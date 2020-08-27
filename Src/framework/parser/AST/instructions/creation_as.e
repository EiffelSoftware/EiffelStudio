note
	description: "Node for a creation instruction."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CREATION_AS

inherit
	INSTRUCTION_AS

create
	make

feature {NONE} -- Initialization

	make (a: BOOLEAN; tp: like type; tg: like target; c: like call; k_as: like create_keyword)
			-- Create new CREATE_CREATION AST node.
		require
			tg_not_void: tg /= Void
		do
			is_active := a
			type := tp
			target := tg
			call := c
			if k_as /= Void then
				create_keyword_index := k_as.index
			end
		ensure
			is_active_set: is_active = a
			type_set: type = tp
			target_set: target = tg
			call_set: call = c
			create_keyword_set: k_as /= Void implies create_keyword_index = k_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_creation_as (Current)
		end

feature -- Attributes

	is_active: BOOLEAN
			-- Is creation region active (for separate types)?

	type: detachable TYPE_AS
			-- Creation type

	target: ACCESS_AS
			-- Target to create

	call: detachable ACCESS_INV_AS
			-- Routine call: it is an instance of ACCESS_INV_AS because
			-- only procedure and functions are valid and no export validation
			-- is made.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				is_active = other.is_active and then
				equivalent (call, other.call) and then
				equivalent (target, other.target) and then
				equivalent (type, other.type)
		end

feature -- Roundtrip

	create_keyword_index: INTEGER
			-- Index of keyword "create" associated with this structure

	create_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "create" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, create_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := create_keyword_index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and create_keyword_index /= 0 then
				Result := create_keyword (a_list)
			elseif attached type as l_type then
				Result := l_type.first_token (a_list)
			else
				Result := target.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached call as l_call then
				Result := l_call.last_token (a_list)
			else
				Result := target.last_token (a_list)
			end
		end

invariant
	target_not_void: target /= Void

note
	ca_ignore: "CA011", "CA011: too many arguments"
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

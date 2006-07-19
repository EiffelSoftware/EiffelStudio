indexing
	description: "Decription of an inline agent"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INLINE_AGENT_CREATION_AS

inherit
	AGENT_ROUTINE_CREATION_AS
		rename
			make as initialize_routine
		redefine
			process,
			is_equivalent,
			last_token
		end

create
	make

feature{NONE} -- Initialization

	make (a_body: like body; o: like internal_operands; a_as: like agent_keyword) is
			-- Create a new INLINE_AGENT_CREATION_AS AST node.
		require
			as_not_void: a_as /= Void
			body_not_void: a_body /= Void
		do
			initialize (Void, Void, o, False)
			agent_keyword := a_as
			body := a_body
		ensure
			agent_keyword_set: agent_keyword = a_as
			body_set: body = a_body
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_inline_agent_creation_as (Current)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor (other) and then equivalent (body, other.body)
		end

feature -- Access

	set_feature_name (a_fn: ID_AS) is
		require
			fn_not_void: a_fn /= Void
		do
			feature_name := a_fn
		ensure
			feature_name_set: feature_name = a_fn
		end

	body: BODY_AS
			-- Inline agent body

feature -- Roundtrip/Token

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := body.last_token (a_list)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

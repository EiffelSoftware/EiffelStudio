indexing
	description: "Object that represents a list of local decarations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_DEC_LIST_AS

inherit
	AST_EIFFEL

create
	make

feature{NONE} -- Initialization

	make (l_as: like locals; k_as: like local_keyword) is
			-- Initialize instance.
		require
			l_as_not_void: l_as /= Void
		do
			locals := l_as
			if k_as /= Void then
				local_keyword_index := k_as.index
			end
		ensure
			locals_set: locals = l_as
			local_keyword_set: k_as /= Void implies local_keyword_index = k_as.index
		end

feature -- Access

	locals: EIFFEL_LIST [TYPE_DEC_AS]
			-- Local declarations

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_local_dec_list_as (Current)
		end

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			if locals = Void then
				Result := other.locals = Void
			else
				Result := other.locals /= Void and then locals.is_equivalent (other.locals)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- First token in current AST node
		do
			if a_list /= Void and local_keyword_index /= 0 then
				Result := local_keyword (a_list)
			elseif locals /= Void then
				Result := locals.last_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
			-- Last token in current AST node
		do
			if locals /= Void then
				Result := locals.last_token (a_list)
			end
			if (Result = Void or else Result.is_null) and a_list /= Void and local_keyword_index /= 0 then
				Result := local_keyword (a_list)
			end
		end

feature -- Roundtrip

	local_keyword_index: INTEGER
			-- Index of keyword "local" associated with current AST node

	local_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "local" associated with current AST node
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := local_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
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

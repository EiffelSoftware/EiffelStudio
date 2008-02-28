indexing
	description	: "Description of variant loop. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class VARIANT_AS

inherit
	TAGGED_AS
		redefine
			process, first_token
		end

create
	make

feature -- Initialization

	make (t: like tag; e: like expr; v_as: like variant_keyword; c_as: like colon_symbol) is
			-- Create new VARIANT AST node.
		do
			initialize (t, e, c_as)
			if v_as /= Void then
				variant_keyword_index := v_as.index
			end
		ensure
			variant_keyword_set: v_as /= Void implies variant_keyword_index = v_as.index
		end

feature -- Roundtrip

	variant_keyword_index: INTEGER
		-- Index of keyword "variant" associated with this structure

	variant_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
		-- Keyword "variant" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := variant_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and variant_keyword_index /= 0 then
				Result := variant_keyword (a_list)
			elseif tag /= Void then
				Result := tag.first_token (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_variant_as (Current)
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

end -- class VARIANT_AS

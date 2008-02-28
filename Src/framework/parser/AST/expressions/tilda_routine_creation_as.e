indexing
	description: "Abstract description of an Eiffel routine object in tilda form"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TILDA_ROUTINE_CREATION_AS

inherit
	ROUTINE_CREATION_AS
		redefine
			process
		end

create
	make

feature{NONE} -- Initialization

	make (t: like target; f: like feature_name; o: like internal_operands; ht: BOOLEAN; t_as: like tilda_symbol) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			initialize (t, f, o, ht)
			if t_as /= Void then
				tilda_symbol_index := t_as.index
			end
		ensure
			tilda_symbol_set: t_as /= Void implies tilda_symbol_index = t_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tilda_routine_creation_as (Current)
		end

feature -- Roundtrip

	tilda_symbol_index: INTEGER
			-- Index of symbol "~" or "}~" associated with this structure

	tilda_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "~" or "}~" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := tilda_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and lparan_symbol_index /= 0 then
					-- Roundtrip mode
				Result := lparan_symbol (a_list)
			else
				if target /= Void then
					Result := target.first_token (a_list)
				end
			end
			if Result = Void or else Result.is_null then
				if a_list /= Void and tilda_symbol_index /= 0 then
					Result := tilda_symbol (a_list)
				else
					Result := feature_name.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if operands /= Void then
					Result := operands.last_token (a_list)
				else
					Result := feature_name.last_token (a_list)
				end
			else
				if internal_operands /= Void then
					Result := internal_operands.last_token (a_list)
				else
					Result := feature_name.last_token (a_list)
				end
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

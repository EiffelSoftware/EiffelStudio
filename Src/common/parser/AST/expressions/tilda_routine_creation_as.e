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

	make (t: like target; f: like feature_name; o: like operands; ht: BOOLEAN; t_as: like tilda_symbol) is
			-- Create a new ROUTINE_CREATION AST node.
			-- When `t' is Void it means it is a question mark.
		do
			initialize (t, f, o, ht)
			tilda_symbol := t_as
		ensure
			tilda_symbol_set: tilda_symbol = t_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_tilda_routine_creation_as (Current)
		end

feature -- Roundtrip

	tilda_symbol: SYMBOL_AS
			-- Symbol "~" or "}~" associated with this structure

	set_tilda_symbol (a_symbol: SYMBOL_AS) is
			-- Set `tilda_symbol' with `a_symbol'.
		do
			tilda_symbol := a_symbol
		ensure
			tilda_symbol_set: tilda_symbol = a_symbol
		end

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if target /= Void then
				Result := target.complete_start_location (a_list)
			end
			if Result = Void or else Result.is_null then
				if a_list /= Void then
						-- Roundtrip mode
					Result := tilda_symbol.complete_start_location (a_list)
				else
					Result := feature_name.complete_start_location (a_list)
				end
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if operands /= Void then
					Result := operands.complete_end_location (a_list)
				else
					Result := feature_name.complete_end_location (a_list)
				end
			else
				if internal_operands /= Void then
					Result := internal_operands.complete_end_location (a_list)
				else
					Result := feature_name.complete_end_location (a_list)
				end
			end
		end

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

end

indexing
	description: "Combo box that allows the user to choose a view"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_VIEW_SELECTOR

inherit
	EV_COMBO_BOX

create
	make_default

feature -- Initialization

	make_default is
			-- Initialize with "DEFAULT" as selected view.
		do
			make_with_strings (Initial_strings)
			set_text ("DEFAULT")
			set_minimum_width (100)
			return_actions.extend (agent on_view_name_typed)
		end

feature {NONE} -- Events

	on_view_name_typed is
			-- A view name was typed in `Current' text field.
		local
			tmp: LINKED_LIST [STRING]
		do
			select_actions.block
			tmp := strings
			tmp.compare_objects
			if not is_trivial (text) then
				if tmp.has (text) then
					tmp.prune_all (text)
				end
				tmp.put_front (text)
				set_strings (tmp)
			end
			select_actions.resume
			select_actions.call (Void)
		end

feature {NONE} -- Implementation

	initial_strings: ARRAY [STRING] is
			-- Initial list items.
		once
			Result := <<"DEFAULT">>
		end

	is_trivial (str: STRING): BOOLEAN is
			-- Is str only composed	of blank characters?
		local
			i: INTEGER
			c: CHARACTER
		do
			Result := True
			if str /= Void and then not str.is_empty then
				from
					i := 1
				until
					Result = False or else i > str.count
				loop
					c := str.item (i)
					if c /= ' ' and c /= '%T' then
						Result := False
					end
					i := i + 1
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

end -- class EB_VIEW_SELECTOR

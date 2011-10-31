note
	description: "[
		Check if a group size definition name valid
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_GROUP_NODE_SIZE_DEFINITION_CHECKER

feature -- Command

	on_focus_in (a_combo_box: EV_COMBO_BOX)
			-- Handle combo box focus in actions
		do
			last_valid_size_definition := a_combo_box.text
		ensure
			set: last_valid_size_definition /= Void
		end

	on_focus_out (a_combo_box: EV_COMBO_BOX)
			-- Handle combo box focus out actions
		local
			l_colors: EV_STOCK_COLORS
		do
			if not a_combo_box.text.is_empty and then
				not is_text_valid (a_combo_box.text, a_combo_box) then
				if attached last_valid_size_definition as l_last_size_definition then
					if l_last_size_definition.is_empty then
						a_combo_box.set_text (create {STRING_32}.make_empty)
					else
						if is_text_valid (l_last_size_definition, a_combo_box) then
							a_combo_box.set_text (l_last_size_definition)
						else
							a_combo_box.set_text (create {STRING_32}.make_empty)
						end
					end
				else
					check not_possible: False end
				end
				create l_colors
				a_combo_box.set_foreground_color (l_colors.default_foreground_color)
			end
			last_valid_size_definition := Void
		ensure
			clear: last_valid_size_definition = Void
		end

	on_text_change (a_combo_box: EV_COMBO_BOX)
			-- Handle text change actions
		local
			l_text: STRING_32
			l_colors: EV_STOCK_COLORS
		do
			create l_colors
			l_text := a_combo_box.text
			if not l_text.is_empty then
				if is_text_valid (l_text, a_combo_box) then
					a_combo_box.set_foreground_color (l_colors.default_foreground_color)
				else
					a_combo_box.set_foreground_color (l_colors.red)
				end
			else
				-- Empty is valid
				a_combo_box.set_foreground_color (l_colors.default_foreground_color)
			end
		end

	is_text_valid (a_text: STRING_32; a_combo_box: EV_COMBO_BOX): BOOLEAN
			-- If `a_text' a child of `a_combo_box'?
		do
			from
				a_combo_box.start
			until
				a_combo_box.after or Result
			loop
				if a_combo_box.item.text.same_string (a_text) then
					Result := True
				end
				a_combo_box.forth
			end
		end

feature {NONE} -- Implementation

	last_valid_size_definition: detachable STRING_32
			-- Last remembered size definition name

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

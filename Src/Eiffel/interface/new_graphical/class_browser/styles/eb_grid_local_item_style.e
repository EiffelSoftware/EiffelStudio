indexing
	description: "Objects that represents a local display style in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GRID_LOCAL_ITEM_STYLE

--inherit
--	EB_GRID_COMPILER_ITEM_STYLE
--		redefine
--			apply,
--			image,
--			tooltip,
--			setup_tooltip,
--			setup_text,
--			text
--		end

--feature -- Setting

--	apply (a_item: EB_GRID_LOCAL_ITEM) is
--			-- Apply current style to `a_item'.
--		do
--			setup_text (a_item)
--			setup_tooltip (a_item)
--			if a_item.is_parented then
--				a_item.redraw
--			end
--		end

--feature -- Statue report

--	image (a_item: EB_GRID_LOCAL_ITEM): STRING is
--			-- Image of current style used in search
--		do
--			Result := a_item.name
--		end

--	text (a_item: EB_GRID_LOCAL_ITEM): LIST [EDITOR_TOKEN] is
--			-- Text of current style for `a_item'
--		deferred
--		end

--	tooltip (a_item: EB_GRID_LOCAL_ITEM): EB_EDITOR_TOKEN_TOOLTIP is
--			-- Setup related parameters for tooltip display.
--		do
--			create Result.make (a_item.pointer_enter_actions, a_item.pointer_leave_actions, agent a_item.is_destroyed)
--			token_writer.new_line
--			Result.set_tooltip_text (token_writer.last_line.content)
--			initialize_tooltip (Result)
--		ensure then
--			result_attached: Result /= Void
--		end

--feature {NONE} -- Implementation

--	setup_text (a_item: EB_GRID_LOCAL_ITEM) is
--			-- Setup text for `a_item'.
--		do
--			a_item.set_text_with_tokens (text (a_item))
--		end

--invariant
--	invariant_clause: True -- Your invariant here

indexing
		copyright: "Copyright (c) 1984-2006, Eiffel Software"
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

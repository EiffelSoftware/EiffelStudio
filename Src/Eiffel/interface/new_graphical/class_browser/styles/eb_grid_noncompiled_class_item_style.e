indexing
	description: "Object that represents a style for noncompiled class item in class browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_GRID_NONCOMPILED_CLASS_ITEM_STYLE

inherit
	EB_GRID_COMPILER_ITEM_STYLE

feature -- Setting

	apply (a_item: EB_GRID_NONCOMPILED_CLASS_ITEM) is
			-- Apply current style to `a_item'.
		do
			setup_text (a_item)
			setup_tooltip (a_item)
			if a_item.is_parented then
				a_item.redraw
			end
		end

feature -- Statue report

	image (a_item: EB_GRID_NONCOMPILED_CLASS_ITEM): STRING is
			-- Image of current style used in search
		local
			l_tokens: LIST [EDITOR_TOKEN]
		do
			token_writer.new_line
			a_item.associated_class_i.append_name (token_writer)
			create Result.make (32)
			l_tokens := token_writer.last_line.content
			from
				l_tokens.start
			until
				l_tokens.after
			loop
				Result.append (l_tokens.item.image)
				l_tokens.forth
			end
		end

	text (a_item: EB_GRID_NONCOMPILED_CLASS_ITEM): LIST [EDITOR_TOKEN] is
			-- Text of current style for `a_item'
		deferred
		end

	tooltip (a_item: EB_GRID_COMPILED_CLASS_ITEM): EB_EDITOR_TOKEN_TOOLTIP is
			-- Setup related parameters for tooltip display.
		do
			-- No tooltip available
		end

feature -- Style type

	is_full_signature_style: BOOLEAN is
			-- Does current represent a full signature style?
		do
		end

	is_just_name_style: BOOLEAN is
			-- Does current represent a just name style?
		do
		end

feature -- Setting

	setup_text (a_item: EB_GRID_NONCOMPILED_CLASS_ITEM) is
			-- Setup text for `a_item'.
		do
			a_item.set_text_with_tokens (text (a_item))
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

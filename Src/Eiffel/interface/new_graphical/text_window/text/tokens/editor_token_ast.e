indexing
	description: "Editor token that represents an AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_AST

inherit
	EDITOR_TOKEN_TEXT
		undefine
			max_color_id
		redefine
			text_color_id,
			background_color_id,
			font_id,
			process
		end

	EB_EDITOR_TOKEN_IDS

create
	make,
	make_with_appearance

feature{NONE} -- Initialization

	make_with_appearance (a_text: STRING_32; a_appearance: TUPLE [a_font_id: INTEGER; a_text_color_id: INTEGER; a_background_color_id: INTEGER]) is
			-- Initialize.
		require
			a_text_attached: a_text /= Void
			a_appearance_attached: a_appearance /= Void
		do
			make (a_text)
			text_font_id_internal := a_appearance.a_font_id
			text_color_id_internal := a_appearance.a_text_color_id
			background_color_id_internal := a_appearance.a_background_color_id
			is_new_appearance_set := True
		end

feature -- Process

	process (a_visitor: TOKEN_VISITOR) is
			-- Visitor
		do
			a_visitor.process_editor_token_text (Current)
		end

feature -- Color

	text_color_id: INTEGER is
		do
			if is_new_appearance_set then
				Result := text_color_id_internal
			else
				Result := Precursor
			end
		end

	background_color_id: INTEGER is
		do
			if is_new_appearance_set then
				Result := background_color_id_internal
			else
				Result := Precursor
			end
		end

	font_id: INTEGER is
			-- Font id.
		do
			if is_new_appearance_set then
				Result := text_font_id_internal
			else
				Result := Precursor
			end
		end

feature {NONE} -- Implementation

	text_font_id_internal: INTEGER
			-- Font id

	text_color_id_internal: INTEGER
			-- Text color id

	background_color_id_internal: INTEGER
			-- Text background color id

	is_new_appearance_set: BOOLEAN;
			-- Is new appearance set?
			-- If not, Current editor token will use inherited font, text color and background color.

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

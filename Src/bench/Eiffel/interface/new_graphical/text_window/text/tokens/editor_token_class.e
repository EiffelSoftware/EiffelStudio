indexing
	description	: "Token that describe an Eiffel string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_CLASS

inherit
	EDITOR_TOKEN_TEXT
		undefine
			max_color_id
		redefine
			text_color_id,
			background_color_id,
			editor_preferences,
			process
		end

	EB_EDITOR_TOKEN_IDS

create
	make

feature -- Visitor

	process (a_visitor: EIFFEL_TOKEN_VISITOR) is
			-- Visitor
		do
			a_visitor.process_editor_token_class (Current)
		end

feature {NONE} -- Implementation

	text_color_id: INTEGER is
		do
			Result := class_text_color_id
		end

	background_color_id: INTEGER is
		do
			Result := class_background_color_id
		end

	editor_preferences: EB_EDITOR_DATA is
			--
		once
			Result ?= editor_preferences_cell.item
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

end -- class EDITOR_TOKEN_CLASS

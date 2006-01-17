indexing
	description	: "Tokens for `Result' and `Current'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_RESERVED

inherit
	EDITOR_TOKEN_TEXT
		redefine
			text_color,
			background_color,	
			editor_preferences,
			process
		end

create
	make

feature -- Visitor

	process (a_token_visitor: EIFFEL_TOKEN_VISITOR) is
			--  Process
		do
			a_token_visitor.process_reserved_word_token (image)
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.reserved_text_color
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.reserved_background_color
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

end -- class EDITOR_TOKEN_RESERVED



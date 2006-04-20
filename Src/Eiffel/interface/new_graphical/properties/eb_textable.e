indexing
	description	: "Abstraction for an editable tool or window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EB_TEXTABLE

feature {NONE} -- Initialization

	build_interface is
			-- Build system widget.
		do
			build_text_area
		end

feature -- Access

	widget: EV_WIDGET is
			-- Widget representing Current
		do
			Result := text_area.widget
		end

	text_area: EB_CLICKABLE_EDITOR
			-- Text area attached to Current

feature -- Status report

	changed: BOOLEAN is
			-- As the text changed since last save?
			-- False by default.
		do
			Result := text_area.changed
		end

feature -- Basic operations

	save_text is
			-- Save current text.
		require
			text_has_changed: changed
		deferred
		end

	save_as_text is
			-- Save current text as...
		deferred
		end

feature {NONE} -- Implementation

	build_text_area is
			-- Create the text component where the information will be displayed.
		local
			an_editor: EB_CLICKABLE_EDITOR
		do
			create an_editor.make (Void)
			text_area := an_editor
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

end -- class EB_TEXTABLE

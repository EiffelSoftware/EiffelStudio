indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_BASIC_STATUS_BAR

inherit
	EB_STATUS_BAR

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			f: EV_FRAME
			vp: EV_VIEWPORT
		do
			create widget
			create vp
			create f
			f.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			create label
			vp.extend (label)
			f.extend (vp)
			widget.extend (f)
		end

feature -- Status setting

	display_message (mess: STRING) is
			-- Display `mess'.
		do
			label.set_text (mess)
		end

feature -- Status report

	message: STRING is
			-- Return the currently displayed message.
		do
			Result := label.text
		end

feature -- Access

	widget: EV_STATUS_BAR
			-- Widget representing `Current'.

feature {NONE} -- Implementation

	label: EV_LABEL;
			-- Label where messages are displayed.

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

end -- class EB_BASIC_STATUS_BAR

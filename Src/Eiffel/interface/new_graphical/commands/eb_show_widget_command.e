indexing
	description	: "Command to show/hide a widget"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_SHOW_WIDGET_COMMAND

inherit
	EB_TARGET_COMMAND
		redefine
			target,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
			-- Initialize default values.
		do
			is_visible := target.is_show_requested
		end

feature -- Access

	is_visible: BOOLEAN
			-- Is current target visible?
	
feature -- Execution

	execute is
			-- toggle between show and hide.
		do
			if is_visible then
				disable_visible
			else
				enable_visible
			end
		end

	enable_visible is
			-- Set `is_visible' to True
		do
			if not is_visible then
				is_visible := True
				target.show
			end
		end

	disable_visible is
			-- Set `is_visible' to True
		do
			if is_visible then
				is_visible := False
				target.hide
			end
		end

feature {NONE} -- Implementation

	target: EV_WIDGET;
			-- Target that can be shown or hidden.

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

end -- class EB_SHOW_COMMAND

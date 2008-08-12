indexing
	description: "Dual pop-up toolbar button for a toolbarable toolbar command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON

inherit
	SD_TOOL_BAR_DUAL_POPUP_BUTTON
		rename
			make as sd_make
		end

	EB_SD_COMMAND_TOOL_BAR_BUTTON
		undefine
			on_pointer_motion,
			on_pointer_release,
			sd_make,
			width,
			internal_recycle,
			internal_detach_entities
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_command: EB_TOOLBARABLE_COMMAND) is
			-- Creation method
		do
			sd_make
			Precursor {EB_SD_COMMAND_TOOL_BAR_BUTTON}(a_command)
		end

feature {NONE} -- Cleanup

	internal_recycle is
			-- <Precursor>
		do
			if menu /= Void then
				menu.destroy
			end
			if popup_imp /= Void then
				popup_imp.destroy
			end
			if popup_widget /= Void then
				popup_widget.destroy
			end
			Precursor
		end

	internal_detach_entities is
			-- <Precursor>
		do
			menu := Void
			popup_imp := Void
			popup_widget := Void
			Precursor
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

end -- class EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON

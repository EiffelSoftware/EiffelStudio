indexing
	description: "Abstract notion of a command to save a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_SAVE_COMMAND

obsolete "use EV_SAVE_FILE_COMMMAND instead"

inherit
	EB_GENERAL_DATA

	NEW_EB_CONSTANTS

	EB_EDITOR_COMMAND

	EB_COMMAND_FEEDBACK

feature -- Properties

--	unmodified_pixmap: EV_PIXMAP is 
--			-- Pixmap for the button.
--		once 
--			Result := Pixmaps.bm_Save 
--		end
--
--	modified_pixmap: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Modified
--		end

feature {NONE} -- Attributes

	license_checked: BOOLEAN is True
			-- Is the license checked?

--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Save
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Save
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Save
--		end

feature -- Execution

	execute is deferred end

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

end -- class EB_SAVE_CMD

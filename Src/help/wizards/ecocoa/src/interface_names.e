note
	description	: "Names for buttons, labels, ..."
	author: "Daniel Furrer <danie.furrer@gmail.com>"
	date: "$Date$"
	revision	: "$Revision$"

class
	INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Labels names

	l_menu_bar: STRING_32 do Result := locale.translation ("Menu Bar") end
	l_tool_bar: STRING_32 do Result := locale.translation ("Tool Bar") end
	l_status_bar: STRING_32 do Result := locale.translation ("Status Bar") end
	l_about_dialogbox: STRING_32 do Result := locale.translation ("About DialogBox") end

feature -- Title

	t_new_cocoa_wizard: STRING_32 do Result := locale.translation ("New Cocoa Application Wizard") end
	t_welcome_to_the_wizard: STRING_32 do Result := locale.translation ("Welcome to the New Cocoa%NApplication Wizard") end
	t_completing_wizard: STRING_32 do Result := locale.translation ("Completing the New Cocoa%NApplication Wizard") end
	t_cocoa_application_appearance: STRING_32 do Result := locale.translation ("Cocoa Application Appearance") end
	t_subtitle: STRING_32 do Result := locale.translation ("You can choose the appearance of your application.") end

feature -- Message

	m_you_have_specified_the_following_setting (a_project_name, a_project_location: READABLE_STRING_GENERAL): STRING_32
		do
			Result := locale.formatted_string (locale.translation (
			"You have specified the following settings:%N%
			%%N%
			%Project name: %T$1%N%
			%Location:     %T$2%N"
			), [a_project_name, a_project_location])
		end

	m_click_finish_to (a_compile: BOOLEAN): STRING_32
		do
			if a_compile then
				Result := locale.translation ("Click Finish to generate and compile this project")
			else
				Result := locale.translation ("Click Finish to generate this project")
			end
		end

	m_wizard_introduction: STRING_32
		do
			Result := locale.translation (
				"Using this wizard you can create a graphical application%N%
				%based on the Cocoa library for Eiffel.%N%
				%%N%
				%The generated application will run on any Mac OS X system.%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	m_click_checkboxes_to: STRING_32 do Result := locale.translation ("Click the checkboxes to change the appearance.") end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class INTERFACE_NAMES

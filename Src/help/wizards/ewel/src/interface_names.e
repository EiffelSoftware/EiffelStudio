note
	description	: "Names for buttons, labels, ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	INTERFACE_NAMES

inherit
	WIZARD_SHARED

feature -- Labels names

	l_frame_application: STRING_GENERAL do Result := locale.translation ("Frame application") end
	l_dialog_application: STRING_GENERAL do Result := locale.translation ("Dialog application") end
	l_project_icon: STRING_GENERAL do Result := locale.translation ("Project icon") end

feature -- Title

	t_new_wel_wizard: STRING_GENERAL	do Result := locale.translation ("New WEL Application Wizard") end
	t_welcome_to_the_wizard: STRING_GENERAL	do Result := locale.translation ("Welcome to the New WEL%NApplication Wizard") end
	t_completing_wizard: STRING_GENERAL	do Result := locale.translation ("Completing the New WEL%NApplication Wizard") end
	t_wel_app_type: STRING_GENERAL do Result := locale.translation ("WEL Application Type") end
	t_choose_type_subtitle: STRING_GENERAL do Result := locale.translation ("You can choose the type of your application between%N a Frame-based or a Dialog based window") end
	t_project_icon: STRING_GENERAL do Result := locale.translation ("Project icon") end
	t_choose_icon_subtitle: STRING_GENERAL do Result := locale.translation ("Choose an icon for you project.") end

feature -- Message

	m_you_have_specified_the_following_setting (a_project_name, a_project_location: STRING_GENERAL): STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation (
			"You have specified the following settings:%N%
			%%N%
			%Project name: %T$1%N%
			%Location:     %T$2%N"
			), [a_project_name, a_project_location])
		end

	m_click_finish_to (a_compile: BOOLEAN): STRING_GENERAL
		do
			if a_compile then
				Result := locale.translation ("Click Finish to generate and compile this project")
			else
				Result := locale.translation ("Click Finish to generate this project")
			end
		end

	m_wizard_introduction: STRING_GENERAL
		do
			Result := locale.translation (
				"Using this wizard you can create a Windows application%N%
				%based on the WEL library.%N%
				%%N%
				%%N%
				%To continue, click Next.")
		end

	m_a_frame_based_application: STRING_GENERAL
		do
			Result := locale.translation (
				"A Frame-Based Application uses a main window, or %"frame%", which can have %
				%%Nmenus, subwindows, etc. (EiffelStudio is an example of Frame-Based Application.)%
				%%N%NA Dialog-Based Application uses a sequence of dialogs.%
				%%N(This wizard is an example of Dialog-Based Application.)%
				%")
		end

	m_choose_icon: STRING_GENERAL
		do
			Result := locale.translation (
				"You have chosen to build a Frame-Based Application.%N%
				%You can provide an icon or use the default icon")
		end

note
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

end -- class INTERFACE_NAMES

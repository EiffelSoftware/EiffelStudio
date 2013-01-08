note
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	BENCH_WIZARD_MANAGER

inherit
	WIZARD_PROJECT_MANAGER
		redefine
			prepare,
			make_and_launch
		end

	BENCH_WIZARD_SHARED
		undefine
			default_create, copy, is_equal
		end

	EIFFEL_LAYOUT
		undefine
			default_create, copy, is_equal
		end

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		local
			retried: BOOLEAN
			l_layout: WIZARD_EIFFEL_LAYOUT
		do
			if not retried then
				create l_layout
				l_layout.check_environment_variable
				set_eiffel_layout (l_layout)
				Precursor
			else
				write_bench_notification_cancel
			end
		rescue
			retried := true
			retry
		end

	prepare
			-- Prepare the first window to be displayed.
		local
			icon_pixmap: EV_PIXMAP
			retried: BOOLEAN
		do
			if not retried then
				setup_locale
				Precursor
				create icon_pixmap
				icon_pixmap.set_with_named_path (wizard_pixmaps_path.extended ("wizard.png"))
				first_window.set_icon_pixmap (icon_pixmap)
			end
		rescue
			retried := True
			retry
		end

	setup_locale
			-- Setup locale.
		local
			l_manager: I18N_LOCALE_MANAGER
			l_locale: detachable like locale
		do
			create l_manager.make (eiffel_layout.language_path.name)
			if argument_count >= 2 then
				l_locale := l_manager.locale (create {I18N_LOCALE_ID}.make_from_string (argument (2)))
			end
			locale_cell.put (l_locale)
		end

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

end

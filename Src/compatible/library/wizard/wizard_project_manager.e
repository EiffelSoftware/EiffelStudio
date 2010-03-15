note
	description	: "Class which is launching the application."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_PROJECT_MANAGER

inherit
	EV_APPLICATION

	WIZARD_SHARED
		rename
			help_engine as wizard_help_engine
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	make_and_launch
			-- Initialize and launch application
		do
			if argument_count < 1 then
				io.put_string("wizard -arg1 [resource_path] [-arg2 [locale_id]]%N")
			else
				default_create
				set_help_engine (wizard_help_engine)
				set_application (Current)
				prepare
				launch
			end
		end

	prepare
			-- Prepare the first window to be displayed.
			-- Perform one call to first window in order to
			-- avoid to violate the invariant of class EV_APPLICATION.
		local
			l_window: WIZARD_WINDOW
		do
			create l_window.make (wizard_factory)
			first_window_cell.put (l_window)
			l_window.load_first_state

			first_window.set_title (Wizard_title)
			first_window.close_request_actions.extend (agent first_window.cancel_actions)
			first_window.show
		end

	Wizard_title: STRING_GENERAL
			-- Window title for this wizard.
		once
			Result := "Wizard Version 1.1"
		ensure
			Valid_result: Result /= Void and then not Result.is_empty
		end

	wizard_factory: WIZARD_FACTORY
			-- Factory for current project.
		deferred
		ensure
			wizard_factory_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WIZARD_PROJECT_MANAGER



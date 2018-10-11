note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_GRAPHICAL_WIZARD

inherit
	EV_APPLICATION

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create, copy
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch
		local
			w: like main_window
			cons: EWF_CONSOLE_WIZARD_APPLICATION
			env: EC_EIFFEL_LAYOUT
		do
			default_create

				-- Initialize ISE_PROJECTS variable with expected EiffelStudio value.
			if not attached execution_environment.item ("ISE_PROJECTS") as v or else v.is_whitespace then
					-- ISE_PROJECTS is not defined, so let's defined it to expected ISE default.
				create env
				execution_environment.put (env.user_projects_path.name, "ISE_PROJECTS")
			end

				-- Initialize wizard.			
			if execution_environment.arguments.index_of_word_option ("-console") > 0 then
				create cons.make
			else
				create w
				main_window := w

				w.show
				launch
			end
		end

feature {NONE} -- Implementation

	main_window: detachable EWF_WIZARD_WINDOW

end

indexing

	description:	
		"Set execution format so that breakable point %
			%will be taken into account."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_DEBUG_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			User_stop_points as execution_mode
		redefine
			make,
			tooltext,
			is_tooltext_important
		end

create
	make

feature -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current'.
		do
			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
				False, False, False)
			accelerator.actions.extend (agent execute)
		end

feature -- Access

	set_launched (a_launched: BOOLEAN) is
		local
			toolbar_items: like managed_toolbar_items
		do
			toolbar_items := managed_toolbar_items
			if toolbar_items /= Void then
				from
					toolbar_items.start
				until
					toolbar_items.after
				loop
						-- If text has been set then update it with state of `Current'
					if a_launched then
						if not toolbar_items.item.text.is_equal ("") then
							toolbar_items.item.set_text (Interface_names.b_Continue)
						end
					else
						if not toolbar_items.item.text.is_equal ("") then
							toolbar_items.item.set_text (Interface_names.b_Launch)
						end
					end
					toolbar_items.forth
				end
			end
		end

feature {NONE} -- Attributes

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap for the button.
		once
			Result := Pixmaps.Icon_run_debug
		end

	name: STRING is "Exec_debug"
			-- Name of the command.

	tooltext: STRING is
			-- Default text displayed in toolbar button
		do
			Result := Interface_names.b_launch
		end

	is_tooltext_important: BOOLEAN is
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := True
		end

	internal_tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_debug
		end

	menu_name: STRING is
			-- Name used in menu entry.
		once
			Result := Interface_names.m_Debug_run_new
		end

end -- class EB_EXEC_NO_STOP_CMD

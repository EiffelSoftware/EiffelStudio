indexing
	description:	"Retarget the class tool with the class the execution is stopped in."
	date: "$Date$"
	revision: "$Revision$"

class EB_CURRENT_CLASS_CMD

inherit

	EB_EDITOR_COMMAND
		redefine
			tool
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation

	make

feature -- Properties

	tool: EB_CLASS_TOOL
			-- should change, for the command work in a feature tool

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Current
--		end

--	name: STRING is
--			-- Command name.
--		do
--			Result := Interface_names.f_Current
--		end

--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Current
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Current
--		end

feature {NONE} -- Implementation

	execute (argument: EV_ARGUMENT1 [ANY]; data: EV_EVENT_DATA) is
			-- Retarget the class tool with the current class if any.
		local
			e_class: CLASS_C
			status: APPLICATION_STATUS
			st: FEATURE_STONE
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_System_not_running)
			elseif not status.is_stopped then
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_System_not_stopped)
			elseif status.e_feature = Void or status.dynamic_class = Void then
					-- Should never happen.
				create wd.make_default (tool.parent, Interface_names.t_Warning, Warning_messages.w_Unknown_class)
			else
					-- Show the current routine in that class.
				create st.make (status.e_feature)
				tool.process_feature (st)
			end
		end

end -- class EB_CURRENT_CLASS_CMD

indexing
	description:	"Retarget the class tool with the class the execution is stopped in."
	date: "$Date$"
	revision: "$Revision$"

class EB_CURRENT_CLASS_COMMAND

obsolete "useless with merged debugging tool and class tool"

inherit
	EB_EDITOR_COMMAND
		redefine
			target
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation
	make

feature -- Properties

	target: EB_DEVELOPMENT_WINDOW
			-- should change, for the command work in a feature tool

feature {NONE} -- Implementation

	execute is
			-- Retarget the class tool with the current class if any.
--		local
--			status: APPLICATION_STATUS
--			st: FEATURE_STONE
--			wd: EV_WARNING_DIALOG
		do
--			status := Application.status
--			if status = Void then
--				create wd.make_with_text (Warning_messages.w_System_not_running)
--				wd.show_modal
--			elseif not status.is_stopped then
--				create wd.make_with_text (Warning_messages.w_System_not_stopped)
--				wd.show_modal
--			elseif status.e_feature = Void or status.dynamic_class = Void then
--					-- Should never happen.
--				create wd.make_with_text (Warning_messages.w_Unknown_class)
--				wd.show_modal
--			else
--					-- Show the current routine in that class.
--				create st.make (status.e_feature)
--				tool.process_feature (st)
--			end
--		end

end -- class EB_CURRENT_CLASS_CMD

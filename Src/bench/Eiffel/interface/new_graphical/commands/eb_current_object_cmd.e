indexing
	description:	"Retarget the object tool with the object the execution is stopped in."
	date: "$Date$"
	revision: "$Revision$"


class EB_CURRENT_OBJECT_CMD

inherit
	EB_TOOL_COMMAND
		redefine
			tool
		end

	SHARED_APPLICATION_EXECUTION

	NEW_EB_CONSTANTS

creation

	make

feature -- Properties

	tool: EB_OBJECT_TOOL

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Current
--		end
--
--	name: STRING is
--			-- Name of the command.
--		do
--			Result := Interface_names.f_Current
--		end
--
--	menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Current
--		end
--
--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--			Result := Interface_names.a_Current
--		end

feature {NONE} -- Implementation

	execute is
			-- Retarget the object tool with the current object if any.
		local
			e_class: CLASS_C
			address: STRING
			stone: OBJECT_STONE
			status: APPLICATION_STATUS
			wd: EV_WARNING_DIALOG
		do
			status := Application.status
			if status = Void then
				create wd.make_with_text (Warning_messages.w_System_not_running)
				wd.show_modal
			elseif not status.is_stopped then
				create wd.make_with_text (Warning_messages.w_System_not_stopped)
				wd.show_modal
			else
				address := status.object_address
				if address = Void or status.dynamic_class = Void then
						-- Should never happen.
					create wd.make_with_text (Warning_messages.w_Unknown_object)
					wd.show_modal
				else
					e_class := status.dynamic_class
					create stone.make (address, status.e_feature.name, e_class)
					tool.process_object (stone)
				end
			end
		end

end -- class CURRENT_OBJECT

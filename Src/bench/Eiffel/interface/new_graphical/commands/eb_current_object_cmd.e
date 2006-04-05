indexing
	description:	"Retarget the object tool with the object the execution is stopped in."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create

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

end -- class CURRENT_OBJECT

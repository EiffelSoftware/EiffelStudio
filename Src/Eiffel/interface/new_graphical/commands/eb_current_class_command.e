indexing
	description:	"Retarget the class tool with the class the execution is stopped in."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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

end -- class EB_CURRENT_CLASS_CMD

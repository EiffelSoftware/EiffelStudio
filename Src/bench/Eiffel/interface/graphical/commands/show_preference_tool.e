indexing

	description:
		"Put your description here."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHOW_PREFERENCE_TOOL

inherit
	WINDOWS;
	EB_CONSTANTS;
	ISE_COMMAND

create
	make

feature {NONE} -- Initalization

	make (a_category: like category) is
			-- Initialize command with `a_category'.
		do
			category := a_category
		end

feature {NONE} -- Access

	category: RESOURCE_CATEGORY
			-- Category to be displayed

feature {NONE} -- Execution

	work (arg: ANY) is
		local
			gpc: GENERAL_PREF_CAT; -- A general category
			cwpc: CLASS_PREF_CAT; -- Preference category for the class window
			ewpc: EXPLAIN_PREF_CAT; -- Preference category for the explain window
			pwpc: PROJECT_PREF_CAT; -- Preference category for the project window
			swpc: SYSTEM_PREF_CAT; -- Preference category for the system window
			rwpc: ROUTINE_PREF_CAT; -- Preference category for the routine window
			owpc: OBJECT_PREF_CAT; -- Preference category for the object window
			grpc: GRAPHICAL_PREF_CAT; -- Preference category for the graphical values
			prpc: PROFILE_PREF_CAT; -- Preference category for the profile tool
			mp: MOUSE_PTR;
			p_tool: EB_PREFERENCE_TOOL
		do
			create mp.set_watch_cursor;
			if preference_tool = Void then
				create p_tool.make;
				create gpc.make (p_tool);
				create pwpc.make (p_tool);
				create ewpc.make (p_tool);
				create swpc.make (p_tool);
				create cwpc.make (p_tool);
				create rwpc.make (p_tool);
				create owpc.make (p_tool);
				create prpc.make (p_tool);
				create grpc.make (p_tool);
				p_tool.add_preference_category (gpc);
				p_tool.add_preference_category (pwpc);
				p_tool.add_preference_category (ewpc);
				p_tool.add_preference_category (swpc);
				p_tool.add_preference_category (cwpc);
				p_tool.add_preference_category (rwpc);
				p_tool.add_preference_category (owpc);
				p_tool.add_preference_category (prpc);
				p_tool.add_preference_category (grpc);
				p_tool.build_interface (Project_tool.screen);
				preference_tool_cell.put (p_tool)
			end;
			preference_tool.show_page_number (category.page_number);
			preference_tool.display;
			mp.restore
		end

feature -- Properties

	name: STRING is 
		do
			Result := Interface_names.f_Preferences
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Preferences
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

invariant

	valid_category: category /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class SHOW_PREFERENCE_TOOL

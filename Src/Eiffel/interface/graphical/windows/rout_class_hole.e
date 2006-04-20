indexing

	description:	
		"Class Hole for a routine tool."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision: "

class ROUT_CLASS_HOLE

inherit

	DEFAULT_HOLE_COMMAND
		rename
			work as default_work
		redefine
			symbol, full_symbol, name, tool, stone_type,
			transported_stone, process_feature,
			menu_name, accelerator
		end
	DEFAULT_HOLE_COMMAND
		redefine
			symbol, full_symbol, name, work, tool, stone_type,
			transported_stone, process_feature,
			menu_name, accelerator
		select
			work
		end

create

	make

feature -- Properties

	tool: ROUTINE_W;
			-- Associated tool

	symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Class
		end;

	full_symbol: PIXMAP is
			-- Icon for the class tool
		once
			Result := Pixmaps.bm_Class_dot
		end;
	
	name: STRING is
		do
			Result := Interface_names.s_Class_stone
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_New_class
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	stone_type: INTEGER is
		do
			Result := Class_type
		end;

	transported_stone: STONE is
		local
			fs: FEATURE_STONE
		do
			fs := tool.stone;
			if fs /= Void then
				create {CLASSC_STONE} Result.make (fs.e_class)
			end
		end;

feature -- Execution

	work (argument: ANY) is
			-- Execute the command for associated hole.
		local
			fs: FEATURE_STONE;
			classc: CLASSC_STONE;
			new_tool: CLASS_W
		do
			fs := tool.stone;
			if argument = control_button_three_action then
				if fs /= Void and then fs.e_class /= Void then
					new_tool := window_manager.class_window;
					new_tool.display;
					new_tool.process_feature (fs)
				end
			elseif argument = shift_button_three_action then
--Arnaud		create super_melt_cmd.do_nothing;
        		create classc.make (fs.e_class);
--Arnaud		super_melt_cmd.work (classc)
			else
				default_work (argument)
			end
		end;

feature -- Update

	process_feature (st: FEATURE_STONE) is
        do
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

end -- class ROUT_CLASS_HOLE

indexing
	description: "Command that super melts a class or a routine."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class SUPER_MELT

inherit
	EB_CONSTANTS

	TOOL_COMMAND
		rename
			init as make
		end

	SHARED_APPLICATION_EXECUTION

create
	make, do_nothing

feature -- Access

	name: STRING is
		do
			Result := Interface_names.f_Stoppable
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Stoppable
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

	insert_breakpoint: BOOLEAN is
			-- Super melt doesn't add a breakpoint.
		do
		end

feature -- Execution

	work (arg: ANY) is
			-- Super melt a class or routine. If associated `tool'
			-- is Void then the arg is checked if it is a stone.
		local
			c_stone: CLASSC_STONE;
			f_stone: FEATURE_STONE;
			disp_bp: DEBUG_STOPIN_HOLE;
			mp: MOUSE_PTR;
			stone: STONE
		do
			if tool = Void then	
				stone ?= arg	
			else
				stone := tool.stone
			end;
			f_stone ?= stone;
			c_stone ?= stone;
			create disp_bp.do_nothing;
			if f_stone /= Void then
				if f_stone.is_valid and then f_stone.e_feature.is_debuggable then
					create mp.set_watch_cursor;
					Application.super_melt_feature (f_stone.e_feature, insert_breakpoint);
					disp_bp.work (Void);
					mp.restore
				end
			elseif c_stone /= Void and then c_stone.is_valid then
				create mp.set_watch_cursor;
				Application.super_melt_class (c_stone.e_class, insert_breakpoint);
				disp_bp.work (Void);
				mp.restore
			end;
		end;

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

end -- class SUPER_MELT

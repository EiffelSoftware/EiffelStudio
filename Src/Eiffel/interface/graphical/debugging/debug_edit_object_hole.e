indexing
	description: ""
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_EDIT_OBJECT_HOLE

inherit
	HOLE_COMMAND
		redefine
			compatible, process_object
		end

create
	make

feature -- Properties

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Debug_edit_object
		end

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Debug_edit_object
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	symbol: PIXMAP is 
			-- Pixmap for the button.
		do 
			Result := Pixmaps.bm_Debug_edit_object 
		end

	stone_type: INTEGER is
		do
		end

feature -- Access

	compatible (dropped: STONE): BOOLEAN is
			-- Can `Current' accept `dropped' ?
		do
			Result := (dropped /= Void) and then 
					  (dropped.stone_type = Object_type)
		end

feature -- Update

	process_object (object_stone: OBJECT_STONE) is
			-- Process object stone.
		local
			edit_attr: EDIT_ATTR
			edit_local: EDIT_LOCAL
		do
			edit_attr := Project_tool.edit_attr
			edit_local := Project_tool.edit_local

			if edit_local.waiting_for_object then
				edit_local.go_on(object_stone)
			elseif edit_attr.waiting_for_object then
				edit_attr.go_on(object_stone)
			else
				edit_attr.set_stone(object_stone)
				edit_attr.work(Project_tool)
			end
			if edit_attr.modified or edit_local.modified then
				io.put_string("modification done.%N")
			end
		end


feature -- Execution

	work (argument: ANY) is
			-- edit an object or a local variable
		local
			edit_local: EDIT_LOCAL
		do
			edit_local := Project_tool.edit_local
			edit_local.work(Project_tool)
			if edit_local.modified then
				io.put_string("modification done.%N")
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

end -- class DEBUG_EDIT_OBJECT_HOLE

indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_EDIT_OBJECT_HOLE

inherit
	HOLE_COMMAND
		redefine
			compatible, process_object
		end

creation
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
				io.putstring("modification done.%N")
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
				io.putstring("modification done.%N")
			end
		end

end -- class DEBUG_EDIT_OBJECT_HOLE

indexing

	description: 
		"";
	date: "$Date$";
	revision: "$Revision $"

class EDIT_OPERATIONS

inherit

	TOOL_COMMAND

creation
	make_paste, 
	make_copy, 
	make_cut

feature {NONE} -- Initialization

	make_paste (a_tool: like tool) is
			-- Initialize command for paste operation.
		do
			edit_type := paste_type;
			tool := a_tool
		end;	

	make_cut (a_tool: like tool) is
			-- Initialize command for cut operation.
		do
			edit_type := cut_type;
			tool := a_tool
		end;	

	make_copy (a_tool: like tool) is
			-- Initialize command for copy operation.
		do
			edit_type := copy_type;
			tool := a_tool
		end;	

	name: STRING is
			-- Name of editor operations
		do
			inspect
				edit_type
			when copy_type then
				Result := Interface_names.f_copy
			when cut_type then
				Result := Interface_names.f_cut
			when paste_type then
				Result := Interface_names.f_paste
			end
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			inspect
				edit_type
			when copy_type then
				Result := Interface_names.m_copy
			when cut_type then
				Result := Interface_names.m_cut
			when paste_type then
				Result := Interface_names.m_paste
			end
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			inspect
				edit_type
			when copy_type then
				Result := Interface_names.a_copy
			when cut_type then
				Result := Interface_names.a_cut
			when paste_type then
				Result := Interface_names.a_paste
			end
		end

feature -- Execution

	work (argument: ANY) is
			-- Perform edit operations.
		do
			inspect
				edit_type
			when copy_type then
				text_window.copy_text
			when cut_type then
				text_window.cut_text
			when paste_type then
				text_window.paste_text
			end
		end;

feature {NONE} -- Implementation

	edit_type: INTEGER;

	copy_type, paste_type, cut_type: INTEGER is unique

end -- class EDIT_OPERATIONS

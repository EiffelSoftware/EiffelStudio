Indexing

	description: 
		"Print window that allows printing to the printer or to%
		%a file.";
	date: "$Date$";
	revision: "$Revision $"

class PRINT_COMMAND
inherit

	EV_COMMAND

	ONCES

	CONSTANTS

creation

	make

feature -- Initialization

	make (c: like caller; p: like print_window; n: like notebook) is
		do
			caller := c
			print_window := p
			notebook := n
		end;

feature -- Properties

	print_window:ANY --  EC_PRINT_WINDOW
	notebook: EV_NOTEBOOK

	is_to_directory: BOOLEAN;
			-- Are we generating files to a directory?

	last_cwd: STRING
			-- Last current working directory for file selection box


feature -- Output

	real_print is
			-- the actual printing
		local
			file: PLAIN_TEXT_FILE;
			error: BOOLEAN

		--	file_page: FILE_PAGE
		--	item: EV_LIST_ITEM
		do
		--	if caller /= Void then
		--		if print_window /= Void then
		--			if notebook /= Void then
		--				if notebook.current_page = 2 then
		--					file_page := print_window.file_page
	--
	--						if file_page /= Void then
	--							file_name_text_field := file_page.file_name_print
	--							if file_name_text_field /= Void then
	--								!! file.make (file_name_text_field.text);
	--								if is_to_directory then
	--									if not (file.exists and then 
	--										file.is_directory and then
	--										file.is_writable)
	--									then
	--										error := True;
	--										Windows_manager.popup_error (Message_keys.write_to_dir_er, file.name, print_window)
	--									end
	--								else
	--									if (file.exists and then file.is_directory) or else
	--										not file.is_creatable 
	--									then
	--										error := True;
	--										Windows_manager.popup_error (Message_keys.write_er, file.name, print_window)
	--									end
	--								end;
	--								if not error then
	--									filters := file_page.filters
	--									item := filters.selected_item
	--									if item /= Void then
	--										caller.print_document (file_name_text_field.text,item.text , print_graphics);
	--									end
	--								end
	--							end
	--						end
	--					else
	--						caller.print_document ("", Void, print_graphics);
	--					end
	--				end
	--			end
	--		end
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			dir: PLAIN_TEXT_FILE;
			win_att: WIDGET_ATTRIBUTES
			s: STRING
		do
			real_print;
		--	if print_window /= Void then
		--		print_window.destroy
		--	end
		end;

feature {NONE} -- Implementation properties

	box_ok_action, box_cancel_action: ANY is
		once
			!! Result
		end;

	file_selection_box: CASE_FILE_SELECTOR -- FILE_SEL_D;
			-- File selection dialog

	caller: PRINT_WINDOW_CALLER;
			-- Class that called Current

	printer_label, generate_to_label,
	format_label: EV_LABEL;
	printer_text_field, 
	file_name_text_field: EV_TEXT_FIELD;

	filters: EV_COMBO_BOX
	print_graphics: BOOLEAN;

end -- class PRINT_WINDOW

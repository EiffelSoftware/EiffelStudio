indexing
	description: "Command to open a new dynamic library file"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OPEN_DYNAMIC_LIB_CMD

inherit
	OPEN_FILE
		redefine
			work, loose_changes, save_changes
		end

creation

	make
	
feature -- Callbacks

--	load_chosen (argument: ANY) is
--		local
--			chooser: NAME_CHOOSER_W
--		do
--			chooser := name_chooser (popup_parent)
--			chooser.set_open_file
--			chooser.call (Current)
--		end

	loose_changes is
		local
			f: PLAIN_TEXT_FILE
			res: BOOLEAN
		do
			if Eiffel_dynamic_lib.file_name /= Void then
				create f.make_open_read (Eiffel_dynamic_lib.file_name)

				Res:= Eiffel_dynamic_lib.parse_exports_from_file(f)
				Eiffel_dynamic_lib.set_modified(False)
				dynamic_lib_tool.hide
			end
		end

	save_changes (argument: ANY) is
			-- The user has been warned that he will lose his stuff and
			-- has decided to save it.
		do
			if dynamic_lib_tool.save_cmd_holder /= Void then
				dynamic_lib_tool.save_cmd_holder.associated_command.execute (Void)
			end
			dynamic_lib_tool.text_window.clear_window
			Eiffel_dynamic_lib.set_modified(False)
			dynamic_lib_tool.hide
		end


	
feature {NONE} -- Implementation

	new_dynamic_lib_file: BOOLEAN

	work (argument: ANY) is
			-- Open a file.
		local
			fn: FILE_NAME
			f: PLAIN_TEXT_FILE
			temp: STRING	
			chooser: NAME_CHOOSER_W
		do
			if argument /= Void and then argument = last_name_chooser then
				create fn.make_from_string (last_name_chooser.selected_file)
				if not fn.empty then
					create f.make (fn)
					if
						f.exists and then 
						f.is_readable and then 
						f.is_plain
					then
						Eiffel_dynamic_lib.set_file_name (fn)
						new_dynamic_lib_file := True
						work(Current)
					elseif f.exists and then not f.is_plain then
						warner (popup_parent).custom_call (Current, 
							Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					else
						warner (popup_parent).custom_call (Current, 
						Warning_messages.w_Cannot_read_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
					end
				else
					warner (popup_parent).custom_call (Current, 
						Warning_messages.w_Not_a_file_retry (fn), Interface_names.b_Ok, Void, Interface_names.b_Cancel)
				end
			else
				-- First click on open
				if Eiffel_dynamic_lib.modified then
					warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed,
						Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
				elseif new_dynamic_lib_file then
					new_dynamic_lib_file := False
 					dynamic_lib_tool.display
 					dynamic_lib_tool.show_file_content (Eiffel_dynamic_lib.file_name)
				else

					chooser := name_chooser (popup_parent)
					chooser.set_open_file
					chooser.set_pattern ("*.def")
					chooser.set_pattern_name ("Dynamic Library Definition File (*.def)")

					chooser.call (Current) 
				end
			end
		end

end -- class EB_OPEN_DYNAMIC_LIB_CMD


class ALIGNMENT_CMD 

inherit

	CMD_LIST
		redefine
			work
		end

feature {NONE}

	associated_form: INTEGER is
		do
			Result := Context_const.alignment_form_nbr
		end;

	c_name: STRING is
		do
			Result := Command_names.cont_alignment_cmd_name
		end;
	
feature 

	work (editor: CONTEXT_EDITOR) is
		local
			list: ALIGNMENT_BOX;
			cmd: SEL_SINGLE_CMD;
		do
			context := editor.edited_context;
			list := editor.alignment_form.context_list;
				-- Prevent unwanted reset of the context
				-- editors if the context is the bulletin
			if list.empty then
				failed := True
			else
				list.start;
				context := list.item.data;
				!!cmd_list.make;
				from
				until
					list.after
				loop
					!!cmd;
						-- work does not put the command in the history
					cmd.work (list.item.data);
					cmd_list.put_right (cmd);
					list.forth;
				end;
				editor.apply_current_form;
				context_catalog.update_editors (context, editor.current_form_number);
			end;
		end;

end

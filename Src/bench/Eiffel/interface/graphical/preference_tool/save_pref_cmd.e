indexing

	description:
		"Command to save and validate all changes in resources.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_PREF_CMD

inherit
	PREFERENCE_COMMAND;
	EXECUTION_ENVIRONMENT;
	EB_RESOURCES

creation
	make

feature {PREFERENCE_COMMAND} -- Execution

	execute (argument: ANY) is
			-- Save resources
		local
			file: PLAIN_TEXT_FILE;
			fn: FILE_NAME;
			msg: STRING;
			wd: WARNING_D;
			file_names: RESOURCE_FILES_PARSER
		do
			!! file_names.make ((create {PRODUCT_NAMES}).Workbench_name);
			!! fn.make_from_string (file_names.system_specific)
			if fn /= Void then
				!! file.make (fn)
				if
					(file.exists and then file.is_writable)
					or else (not file.exists and then file.is_creatable)
				then
					tool.validate_all
					if tool.is_valid then
						file.open_write;
						save_resources_to_file (file);
						file.close;
						tool.close
					end
				else
					!! wd.make ("Warning", tool);
					!! msg.make (0);
					msg.append ("Do not have appropriate permissions to%Nsave to file ");
					msg.append (fn);
					wd.set_message (msg);
					wd.hide_help_button;
					wd.hide_cancel_button;
					wd.add_ok_action (Current, wd);
					wd.set_title ("Warning");
					wd.popup;
					wd.raise;
				end
			end
		end

	save_resources_to_file (file: PLAIN_TEXT_FILE) is
			-- Save all resources to `file'.
		require
			file_not_void: file /= Void;
			file_is_open_write: file.is_open_write
		local
			cats: LINKED_LIST [PREFERENCE_CATEGORY];
		do
			from
				cats := tool.category_list;
				cats.start
			until
				cats.after
			loop
				cats.item.save_resources (file);
				cats.forth
			end
		end;

end -- class SAVE_PREF_CMD

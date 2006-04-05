indexing

	description:
		"Command to save and validate all changes in resources."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SAVE_PREF_CMD

inherit
	PREFERENCE_COMMAND;
	EXECUTION_ENVIRONMENT;
	EB_RESOURCES

create
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
			create file_names.make ((create {PRODUCT_NAMES}).Workbench_name);
			create fn.make_from_string (file_names.system_specific)
			if fn /= Void then
				create file.make (fn)
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
					create wd.make ("Warning", tool);
					create msg.make (0);
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

end -- class SAVE_PREF_CMD

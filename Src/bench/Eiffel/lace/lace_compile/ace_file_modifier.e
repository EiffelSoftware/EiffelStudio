indexing
	description: "Facilities for modifying project properties."
	date: "$Date$"
	revision: "$Revision$"

class
	ACE_FILE_MODIFIER

inherit
	ACE_FILE_ACCESSER
	
	SHARED_EIFFEL_PROJECT
		export {NONE}
			all
		end

	SHARED_WORKBENCH
		EXPORT {NONE}
			ALL
		END

	EB_SHARED_ARGUMENTS
		export {NONE}
			all
		undefine
			default_create, is_equal
		end
		
create
	make

feature -- Access

	arguments: STRING is
			-- Program arguments.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
		do
			create Result.make (20)
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					not Result.is_empty or defaults.after
				loop
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.arguments then
							Result := defaults.item.value.value
							if Result.is_empty or else 
								Result.is_equal (" ") or else
								Result.has ('%U')
							then
								Result := No_argument_string
							end							
						end
					end
					defaults.forth
				end
			end
		ensure
			non_void_arguments: Result /= Void
		end

feature -- Element change

	set_working_directory (new_name: STRING) is
			-- Set directory `new_name' as working directory.
		require
			new_name_exists: new_name /= Void
			new_name_not_empty: not new_name.is_empty			
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.working_directory then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			else
				create defaults.make (20)
			end
			
			defaults.extend (new_special_option_sd ("working_directory", new_name, True))
			if Workbench.system_defined then
				Lace.set_application_working_directory (new_name)
			end			
		end

	set_arguments (arg: STRING) is
			-- Set `arg' as new argument.
		require
			arg_not_void: arg /= Void
		local
			defaults: LACE_LIST [D_OPTION_SD]
			free_opt: FREE_OPTION_SD
			is_item_removable: BOOLEAN
			txt: STRING
		do
			defaults := root_ast.defaults
			txt := escape_argument (arg)
				-- Set command line arguments of current compiled
				-- project.
			if Workbench.system_defined then
				Lace.argument_list.put_front (txt)
			end
			
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					is_item_removable := False
					if defaults.item.option.is_free_option then
						free_opt ?= defaults.item.option
						if free_opt.code = free_opt.arguments then
							is_item_removable := True
						end
					end
					if is_item_removable then
						defaults.remove
					else
						defaults.forth
					end
				end
			else
				create defaults.make (20)
				root_ast.set_defaults (defaults)
			end
			
			defaults.extend (new_special_option_sd ("arguments", txt, True))
		end

feature {NONE} -- Implementation

	escape_argument (argument_text: STRING): STRING is
			-- Turn `argument_text' into a string that can be safely added to
			-- the ace file. Escape all special characters.
		do
			if argument_text = Void or else argument_text.is_equal (No_argument_string) then
				Result := " "
			else
				Result := clone (argument_text)
				Result.replace_substring_all ("%%", "%%%%")
				Result.replace_substring_all ("%"", "%%%"")
			end
		ensure
			valid_result: Result /= Void
		end

end -- class ACE_FILE_MODIFIER

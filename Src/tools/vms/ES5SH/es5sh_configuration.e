indexing
	description: "configuration values from CONFIG.EIF"
	author: "David Schwartz"
	Date: "$Date$"
	Revision: "$Revision$"
	Id:		"$Id$"

class ES5SH_CONFIGURATION

inherit
	ES5SH_COMMON

create make

feature {NONE} -- Initialization

	common: ES5SH_COMMON
		-- stupid hack to access es5sh common information
		-- ***tbs*** refactor: remove attributes from ES5SH_COMMON...

	make (a_file_name: FILE_NAME; a_common: ES5SH_COMMON ) is
			-- Initialize configuration from `a_file_name' and `common'
		require
			file_name_exists_nonblank: a_file_name /= Void and then not a_file_name.is_empty
		do
			print_output_message ("Reading configuration file: '" + a_file_name + "'%N")
			create {ES5SH_TEXT_FILE}configuration_file.make (a_file_name)
			create table.make (200)
			read_file
			debug ("dump_options")
				dump_options ("after reading config file")
			end
			debug ("test_options")
				test_options ("")
			end
			post_process
		end

feature -- Access

	file_name: STRING is
			-- name of `configuration_file'
		do
			Result := configuration_file.name
		end

	has (a_key: STRING): BOOLEAN is
			-- Is there an item with key `a_key'?
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		do
			Result := table.has (a_key)
		end

	item (a_key: STRING): STRING is
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		do
			Result := table.item (a_key)
		end

	printable_item (a_key: STRING): STRING is
			-- item associated with `a_key', "undefined" if none exists
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		do
			if table.has (a_key) then
				Result := printable_value (table.item (a_key))
			else
				Result := "<Undefined>"
			end
		end

--	get_item_once (a_key : STRING; a_default : STRING) : STRING is
--			-- Return the value of configuration option `a_key'. If not defined, print warning message
--			-- and define it as `a_default' so the warning is issued only once.
--		require
--			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
--		local
--			--l_msg: STRING
--		do
--			if table.has (a_key) then
--				Result := table.item (a_key)
--			else
--				print_file_message (in_makefile, in_makefile.line_count, "Warning", a_key + " not specified")
--				--print_makefile_message ("Warning", a_key + " not specified")
--				if a_default /= Void and then not a_default.is_empty then
--					Result := a_default
--					print (", " + Result + " will be used.%N")
--				else
--					Result := ""
--					print (", will be ignored.%N")
--				end
--				table.put (Result, a_key)	-- suppress further warnings for this name
--			end
--		end; -- get_configuration_option_once


	found_item: STRING is
		do
			Result := table.found_item
		end

	found: BOOLEAN is
		do
			Result := table.found
		end

	not_found: BOOLEAN is
		do
			Result := table.not_found
		end

	inserted: BOOLEAN is
		do
			Result := table.inserted
		end

	replaced: BOOLEAN is
		do
			Result := table.replaced
		end

	comment_prefix: STRING
			-- comment_prefix config file option (Void if not target_gnu_make; must be Void or not empty);
			-- should be some string beginning with "#"

	continuation_string: STRING
			-- end of line continuation character(s)

	target_gnu_make: BOOLEAN
			-- If true, generate Makefile for GNU make (gmake):
			--	quote '$' in DCL names and lexical functions,
			--	quote ':' in target : dependents rules,
			--  use $(subst) to convert spaces to commas in library commands
			-- otherwise generate Makefile for MMS/MMK
	target_gnu_make_default: BOOLEAN is True

	commandfile: STRING is
			-- String used to invoke a command procedure
		once
			Result := table.item ("commandfile")
			if target_gnu_make then
				Result := "\@"
			else
				Result := "@"
			end
		end

	ignore_prefix: STRING is
			-- prefix for commands that causes make/gmake/MMS/MMK to ignore errors
		once
			if target_gnu_make then
				Result := "- "
			else -- MMS/MMK requires space after "-" as ignore indicator to distinguish from "-" as continuation character
				Result := "- "
			end
		end

feature -- Basic operations

		put (a_value, a_key: STRING) is
			obsolete "use force or replace"
			do
				force (a_value, a_key)
			end

		force (a_value, a_key: STRING) is
				-- insert `a_value' for `a_key' (replace if exists, insert otherwise)
				-- same semantics as HASH_TABLE.force
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
		do
			table.force (a_value, a_key)
		end

	replace (a_value, a_key: STRING) is
				-- replace 'a_value` for `a_key'
				-- same semantics as HASH_TABLE.replace
		require
			key_exists_nonblank: a_key /= Void and then not a_key.is_empty
			key_value_exists: has (a_key)
		do
			table.replace (a_value, a_key)
		end

feature {NONE} -- Implementation

	configuration_file: ES5SH_TEXT_FILE
		-- text file with configuration key/value definitions

	table: HASH_TABLE [STRING, STRING]
		-- table of value/key pairs

	read_file is
			-- read the configuration file, populate `table'
		require
			file_not_void: configuration_file /= Void
		local
			l_key, l_val: STRING
			l_number: INTEGER
		do
--			print_output_message ("Reading configuration from file: '" + configuration_file.name + "'%N")
			configuration_file.open_read
			-- read each line
			-- if it starts with "==" it is a key name
			-- each line following is the value until a blank line, eof or a line starting with ==
			-- all will terminate the value
			from
				configuration_file.read_line
			until
				configuration_file.off
			loop
				if starts_with (configuration_file.last_string, "==") then
					l_number := configuration_file.line_count
					l_key := configuration_file.last_string.twin
					l_key.remove_head (2)	-- remove leading "=="
					l_key.left_adjust; l_key.right_adjust
					from
						create l_val.make (80)
						configuration_file.read_line
					until
						configuration_file.end_of_file or else
						configuration_file.last_string.is_empty or else
						starts_with (configuration_file.last_string, "==")
					loop
						-- get rid of leading blanks
						--configuration_file.last_string.left_adjust
						-- oops, that will get rid of necessary tabs
						-- so, comment must start at beginning of line
						if starts_with (configuration_file.last_string, "--") then
							--this is a comment, ignore
							configuration_file.read_line
						else
							if not l_val.is_empty then
								l_val.append ("%N") end
								l_val.append (configuration_file.last_string)
								configuration_file.read_line
							end	-- if not comment
						end
						debug ("table")
							print (" Key: " + l_key + ", Value: " + l_val + "%N")
						end -- debug ("table")
						-- warn if duplicate option
					if (table.has (l_key) ) then
						print_configuration_warning ("duplicate option '", l_number)
						print (l_key + "'%N  old: '" + printable_item (l_key) + "'%N  new: '" + l_val + "'%N")
						table.force (l_val, l_key)
					else
						table.extend (l_val, l_key)
					end
				else
					configuration_file.read_line
				end
			end -- loop
			configuration_file.close
		ensure
			configuration_file_closed: configuration_file.is_closed
		rescue
			if configuration_file.is_open_read then
				configuration_file.close
			end
		end


	post_process is
			-- handle special case configuration items
		local
			l_val: STRING
			l_msg: STRING
		do
			-- set default make target
			if table.has ("target_gnu_make") then
				l_val := table.item ("target_gnu_make")
				if l_val /= Void and then l_val.is_boolean then
					target_gnu_make := l_val.to_boolean
					if target_gnu_make then
						l_msg := "GNU make "
					else
						l_msg := "MMS/MMK "
					end
					print_output_message ("== target_gnu_make: " + target_gnu_make.out + "; using " + l_msg + " syntax.%N")
				else
					target_gnu_make := target_gnu_make_default
					print_error_message ("invalid value for 'target_gnu_make': %"" + l_val + "%", " + target_gnu_make.out + " assumed.%N")
				end
			else
				target_gnu_make := target_gnu_make_default
				print_output_message ("option 'target_gnu_make' not specified, " + target_gnu_make.out + " assumed.%N")
			end

			-- special handling for rm
			-- ***I don't remember what this is for*** -- dz
			if table.has ("rm") and then --table.item("rm").substring_index ("del", 1) > 0 then
					starts_with (table.item ("rm"), "del") then
				table.item ("rm").to_lower
			else
				table.force ("#!delete", "rm")
			end

--			if not table.has ("commandfile") then
--				print_warning_message ("required option 'commandfile' not specified, '")
--				if target_gnu_make then
--					table.extend ("\@", "commandfile");
--					l_msg := "GNU make; for MMS/MMK specify '@'"
--				else
--					table.extend ("@", "commandfile");
--					l_msg := "MMS/MMK; for GNU make specify '\@'"
--				end
--					print (table.item ("commandfile") + "' assumed.%N  Note: this default works for " + l_msg + "%N")
--			end

--			if not table.has ("make") then
--				table.extend ("make", "make")
--				print_warning_message ("required item 'make' not present, '" + table.item ("make") + "' will be used.%N")
--			end

			if not table.has ("rt_include") then
				print_warning_message ("configuration $rt_include missing, things may not work...%N")

			end
			if table.has ("comment_prefix") then
				comment_prefix := table.item ("comment_prefix")
				if comment_prefix.is_empty or else is_blank (comment_prefix) then
					--comment_prefix := "#--"
					comment_prefix := Void
					if comment_prefix /= Void then
						print_warning_message ("invalid blank comment_prefix, '" + comment_prefix + "' will be used.%N")
					else
						print_warning_message ("invalid blank comment_prefix, ignored.%N")
					end
				end
			end

			if table.has ("continuation") then
				continuation_string := table.item ("continuation")
			else
				continuation_string := " \"
				print_output_message ("option 'continuation' not specified, '" + continuation_string + "' assumed.%N")
			end

			-- check for valid options
--			if options.has ("DCL_dollar_quote") then
--				value := options.item ("DCL_dollar_quote")
--				inspect value.count
--				when 1 then
--					DCL_dollar_quote := value   --was clone (value)
--				when 0 then
--					DCL_dollar_quote := Void
--				else
--					print ("invalid DCL_dollar_quote: %'" + value + "%' -- ignored.%N")
--					DCL_dollar_quote := Void
--				end
--			else
--				DCL_dollar_quote := Void
--			 end

			trim_nonblank_value ("INCLUDE_PATH_PREFIX")
			trim_nonblank_value ("INCLUDE_PATH_SUFFIX")

--			if table.has ("DCL_dollar_quote") then
--				l_val := table.item ("DCL_dollar_quote")
--				inspect l_val.count
--					when 1 then
--						DCL_dollar_quote := l_val	--was clone (l_val)
--					when 0 then
--						DCL_dollar_quote := Void
--					else
--						print ("invalid DCL_dollar_quote: %'" + l_val + "%' -- ignored.%N")
--						DCL_dollar_quote := Void
--						end
--					else
--						DCL_dollar_quote := Void
--					end
--				...

			-- warn of obsolete options
			force_obsolete_targeted_option ("commandfile", "\@", "@")
			force_obsolete_targeted_option ("make", "gmake", "make")
			l_val := obsolete_targeted_option_value ("DCL_dollar_quote", "$", Void)
			l_val := obsolete_targeted_option_value ("quote_colon_in_VMS_dependencies", (True).out, (False).out)

--			if not table.has ("make") then
--				table.extend ("make", "make")
--				print_warning_message ("required item 'make' not present, '" + table.item ("make") + "' will be used.%N")
--			end

			if table.has ("preobj_libr") then
				print_output_message ("obsolete option '== preobj_libr' ignored.%N")
				table.remove ("preobj_libr")
			end

			if table.has ("(INCLUDE_PATH)") then
				print_output_message ("obsolete option '== (INCLUDE_PATH)' ignored.%N")
				table.remove ("(INCLUDE_PATH)")
			end
		ensure
			--platform_nonblank: value_platform /= Void and then not value_platform.is_empty
			--continuation_key_present: options.has ("continuation")
			make_key_present: table.has ("make")
			rm_key_present: table.has ("rm") -- or else table.extend ("rm", "!delete")
			comment_prefix_Void_or_not_empty: comment_prefix = Void or else not comment_prefix.is_empty
		end


	trim_nonblank_value (a_key: STRING) is
			-- if value for `a_key' is blank then remove it and print warning,
			-- else if it is present the remove leading and trailing whitespace
		local
			l_val: STRING
		do
			if table.has (a_key) then
				l_val := table.item (a_key)
				if is_blank (l_val) then
					print_warning_message ("invalid == " + a_key + ": blank (empty) value ignored.%N")
					table.remove (a_key)
				else
					l_val.right_adjust; l_val.left_adjust
				end
			end
		end


	force_obsolete_targeted_option (a_key, a_target_gnu, a_target_mmk: STRING) is
			-- force value for `a_key' : (if target_gnu_make then `a_target_gnu' else `a_target_mmk')
		local
			l_val: STRING
		do
			l_val := obsolete_targeted_option_value (a_key, a_target_gnu, a_target_mmk)
			table.force (l_val, a_key)
		end

	obsolete_targeted_option_value (a_key, a_target_gnu, a_target_mmk: STRING) : STRING is
			-- value for `a_key' : (if target_gnu_make then `a_target_gnu' else `a_target_mmk')
		do
			if target_gnu_make then
				Result := a_target_gnu
			else
				Result := a_target_mmk
			end
			if table.has (a_key) then
				print_warning_message ("obsolete option '== " + a_key + "' ignored; %""
						+ printable_value (Result) + "%" implied by target_gnu_make: " + target_gnu_make.out + "%N")
			end
		end

	print_configuration_warning (a_msg: STRING; a_line_number: INTEGER) is
			-- print configuration file related warning message with line number
		do
--			print_warning_message ("")
--			--if (file /= Void and then file.name /= Void and then not file.name.is_empty) then
--				print (configuration_file.name + ":%N  ")
--			--else --if (name /= Void and then not name.is_empty) then
--				--	print (name + " : ")
--			--end
--			print (msg)
			print_file_message (configuration_file, a_line_number, "Warning", a_msg)
		end; --print_configuration_warning

feature -- test (options debugging)

	dump_options (tag : STRING) is
				-- dump all options on standard output
		local
			i : INTEGER
			keys : ARRAY [STRING]
		do
			keys := table.current_keys
			print ("Dump of options -- " + keys.count.out + " entries: %N")
			from	i := 1
			until   i > keys.count
			loop
				print (" @ " + i.out + " :   $" + (keys @ i) + " = '")
				--dump_option_val (keys @ i)
				print (table.item (keys @ i) + "'%N")
				i := i + 1
			end
		end; -- dump_options

--	dump_option_value (k : STRING) is
--				-- dump single named option value
--		local
--			val : STRING
--		do
--			val := table.item (k);
--			-- *TBS* -- remove newline from end of val, replace with some tag
--			print (val);
--		end; -- dump_option_value

		dump_option (k : STRING) is
			-- dump single named option, if it exists
		local
			l_val: STRING
		do
			if table.has (k) then
				--print (", value = '"); dump_option_value (k); print ("'")
				l_val := ", value = '" + printable_item (k) + "'"
			end
			print (" table.has ('" + k + "') = " + table.has(k).out + l_val + "%N")

		end; -- dump_option

	test_options (tag : STRING) is
		do
			print ("test_options: " + tag + "%N")
			--dump_option ("commandfile")
			dump_option ("cc")
			dump_option ("make")
			dump_option ("foo")
			dump_option ("THIS_KEY_SHOULD_NOT_EXIST")
			dump_option ("ccflags")
			dump_option ("CCFLAGS")
			dump_option ("rm")
			dump_option ("rm_safe")
			dump_option ("rm_safe_should_also_not_exist")
			io.new_line
		end; -- test_options

invariant
	configuration_file_exists: configuration_file /= Void
	table_exists: table /= Void
--	comment_prefix_void_or_not_empty:	comment_prefix = Void or else not comment_prefix.is_empty

end -- class ES5SH_CONFIGURATION


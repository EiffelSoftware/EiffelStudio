indexing
	description: "Class regenerating the command instantiator."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class
	COMMAND_INSTANTIATOR_GENERATOR

inherit
	CONSTANTS

creation
	make

feature -- Creation

	make is
			-- Create a command instantiator with at least
			-- the predefined commands.
		local
			new: NEW_CMD
			save: SAVE_CMD
			open: OPEN_CMD
			popup: POPUP_CMD
			popdown: POPDOWN_CMD
			open_window: OPEN_WINDOW_CMD
			close_window: CLOSE_WINDOW_CMD
			maximize_window: MAXIMIZE_WINDOW_CMD
			minimize_window: MINIMIZE_WINDOW_CMD
			restore_window: RESTORE_WINDOW_CMD
			reset_to_empty: RESET_TO_EMPTY_CMD
			reset_to_zero: RESET_TO_ZERO_CMD
			clear: CLEAR_CMD
		do
			!! eiffel_text.make (0)
			!! command_list.make	
			!! new.make
			!! save.make
			!! open.make
			!! popup.make
			!! popdown.make
			!! open_window.make
			!! close_window.make
			!! maximize_window.make
			!! minimize_window.make
			!! restore_window.make
			!! reset_to_empty.make
			!! reset_to_zero.make
			!! clear.make
			add_command (new)
			add_command (open)
			add_command (save)
			add_command (popup)
			add_command (popdown)
			add_command (open_window)
			add_command (close_window)
			add_command (maximize_window)
			add_command (minimize_window)
			add_command (restore_window)
			add_command (reset_to_empty)
			add_command (reset_to_zero)
			add_command (clear)
		end

feature {NONE} -- Attributes

	command_list: EB_LINKED_LIST [CMD]
			-- List of known commands that can be instantiated

	eiffel_text: STRING
			-- Eiffel text for this class.

	instantiation_line: STRING is "feature -- Instantiation"
			-- Line from which regeneration begins

	comment: STRING is "%T%T%T-- Generate a new instance of `"
			-- Comment line for each feature used to instantiate commands

feature -- Access

	add_command (a_command: CMD) is
			-- Add `a_command' in `command_list'.
		do
			command_list.extend (a_command)
			overwrite_text
		end

	remove_command (a_command: CMD) is
			-- Remove `a_command' from `command_list'.
		do
			command_list.start
			command_list.prune (a_command)
			overwrite_text
		end
	
	update_command is
		do
			overwrite_text
		end

feature {NONE} -- Code generation

	overwrite_text is
			-- Write the updated code in the file.
		local
			file: PLAIN_TEXT_FILE
		do
			eiffel_text.wipe_out
			!! file.make (associated_file_name)
			file.open_read
			from
				file.start
				file.read_line
			until	
				file.end_of_file or else file.last_string.is_equal (instantiation_line)
			loop
				eiffel_text.append (file.last_string)
				eiffel_text.append ("%N")
				file.read_line
			end
			file.close
			check
				not_end_of_file: not file.end_of_file
			end
			eiffel_text.append (instantiation_line)
			eiffel_text.append ("%N%N")
			eiffel_text.append (instantiated_commands)
			eiffel_text.append (new_instance_text)
			eiffel_text.append ("%Nend -- COMMAND_INSTANTIATOR%N")
			file.open_write
			file.put_string (eiffel_text)
			file.close
		end
			
	associated_file_name: FILE_NAME  is
			-- File name path for Current Class
			-- in Generated commands directory
		local
			tmp: STRING
			tmp_to_lower: STRING
		do
			!! Result.make_from_string (environment.commands_directory)
			Result.set_file_name (base_file_name)
		end

	base_file_name: FILE_NAME is
			-- Base file name for Current Class
		do
			Result := base_file_name_without_dot_e
			Result.add_extension ("e")
		end

	base_file_name_without_dot_e: FILE_NAME is
			-- Base file name for Current Command without
			-- the `.e' extension
		do
			!! Result.make_from_string ("command_instantiator")
		end

	instantiated_commands: STRING is
			-- Return the code necessary to instantiate
			-- commands
		local
			temp: STRING
			a_cmd: CMD
			i: INTEGER
		do
			!! Result.make (0)
			from 
				command_list.start
			until
				command_list.after
			loop
				a_cmd := command_list.item
				temp := clone (a_cmd.eiffel_type)
				temp.to_lower
				Result.append ("%Tnew_")
				Result.append (temp)
				Result.append(" (creation_arg: COMMAND_CREATION_ARGUMENT): ")
				temp.to_upper
				Result.append (temp)
				Result.append (" is%N")
				Result.append (comment)
				Result.append (temp)
				Result.append ("'.%N")
				Result.append (local_declaration (a_cmd))
				Result.append ("%T%Tdo%N")
				Result.append (assignment_attempt (a_cmd))
				Result.append ("%T%T%T!! Result.make")
				Result.append (local_arguments (a_cmd))
				Result.append ("%N%T%Tend%N%N")
				command_list.forth
			end
		end

	local_declaration (a_cmd: CMD): STRING is
			-- Code corresponding to the local declaration.
		local
			temp: STRING
			i: INTEGER
		do
			!! Result.make (0)
			if not a_cmd.arguments.empty then
				Result.append ("%T%Tlocal%N")
				from
					a_cmd.arguments.start
					i := 1
				until
					a_cmd.arguments.after
				loop
					Result.append ("%T%T%Tlocal_")
					temp := clone (a_cmd.arguments.item.eiffel_type)
					temp.to_lower
					Result.append (temp)
					Result.append_integer (i)
					Result.append (": ")
					temp.to_upper
					Result.append (temp)
					Result.append ("%N")
					a_cmd.arguments.forth
					i := i + 1
				end
			end
		end

	assignment_attempt (a_cmd: CMD): STRING is
			-- Code corresponding to the assignment attempts.
		local
			temp: STRING
			i: INTEGER
		do
			!! Result.make (0)
			if not a_cmd.arguments.empty then
				from
					a_cmd.arguments.start
					i := 1
				until
					a_cmd.arguments.after
				loop
					Result.append ("%T%T%Tlocal_")
					temp := clone (a_cmd.arguments.item.eiffel_type)
					temp.to_lower
					Result.append (temp)
					Result.append_integer (i)
					Result.append (" ?= creation_arg @ ")
					Result.append_integer (i)
					Result.append ("%N")
					a_cmd.arguments.forth
					i := i + 1
				end
			end
		end

	local_arguments (a_cmd: CMD): STRING is
			-- Code corresponding to the local arguments used
			-- in the call to the creation procedure.
		local
			temp: STRING
			i: INTEGER
		do
			!! Result.make (0)
			if not a_cmd.arguments.empty then	
				Result.append (" (")
				from
					a_cmd.arguments.start
					i := 1
				until
					a_cmd.arguments.after
				loop
					Result.append ("local_")
					temp := clone (a_cmd.arguments.item.eiffel_type)
					temp.to_lower
					Result.append (temp)
					Result.append_integer (i)
					a_cmd.arguments.forth
					i := i + 1
					if not a_cmd.arguments.after then
						Result.append (", ")
					end
				end
				Result.append (")")
			end
		end

	new_instance_text: STRING is
			-- Generate the code corresponding to `new_instance'.
		local
			temp: STRING
		do
			!! Result.make (0)
			Result.append ("%Tnew_instance (command_name: STRING; creation_arg: COMMAND_CREATION_ARGUMENT): BUILD_CMD is%N%T%T%T-- Return meta-command which executes command corresponding to `command_name'%N%T%T%T-- if application is in state `state' on the widget `a_widget'.%N%T%Trequire%N%T%T%Tvalid_command_name: command_name /= Void%N%T%Tlocal%N%T%T%Ta_build_command: BUILD_CMD%N%T%Tdo%N%T%T%Tif command_name.is_equal (%"")
			command_list.start
			temp := clone (command_list.item.eiffel_type)
			Result.append (temp)
			Result.append ("%") then%N%T%T%T%Ta_build_command := new_")
			temp.to_lower
			Result.append (temp)
			Result.append (" (creation_arg)%N")
			from
				command_list.forth
			until
				command_list.after
			loop
				Result.append ("%T%T%Telseif command_name.is_equal (%"")
				temp := clone (command_list.item.eiffel_type)
				Result.append (temp)
				Result.append ("%") then%N%T%T%T%Ta_build_command := new_")
				temp.to_lower
				Result.append (temp)
				Result.append (" (creation_arg)%N")
				command_list.forth
			end
			Result.append ("%T%T%Telse%N%T%T%T%Ta_build_command := new_do_nothing_cmd%N%T%T%Tend%N%T%T%TResult := a_build_command%N%T%Tend%N%N")
		end

end -- class COMMAND_INSTANTIATOR_GENERATOR

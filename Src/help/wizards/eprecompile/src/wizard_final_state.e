indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		select
			default_create
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as exec_command_line,
			default_create as ex_create
		end

	PRECOMPILE_WIZARD_CONSTANT
		undefine
			default_create
		end

create
	make

feature -- Basic Operations

	build_finish is 
			-- Build user entries.
		local
			h1: EV_HORIZONTAL_BOX
			cell: EV_CELL
		do
			choice_box.wipe_out
			choice_box.set_border_width (10)
			choice_box.set_padding (10)

			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			progress_text.align_text_left
			progress.set_background_color (white_color)
			progress.set_foreground_color (white_color)
			progress_text.set_background_color (white_color)

			create progress_2
			progress_2.set_minimum_height(20)
			progress_2.set_minimum_width(100)
			create progress_text_2
			progress_text_2.align_text_left
			progress_2.set_background_color (white_color)
			progress_2.set_foreground_color (white_color)
			progress_text_2.set_background_color (white_color)

			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)
			choice_box.extend(progress_2)
			choice_box.disable_item_expand(progress_2)
			choice_box.extend(progress_text_2)
			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			create cell
			cell.set_background_color (white_color)
			choice_box.extend(cell)

			choice_box.set_background_color (white_color)

		end


	proceed_with_current_info is
		local
			mess: EV_INFORMATION_DIALOG
		do
			build_finish
			launch_precompilations
			Precursor
			create mess.make_with_text (final_message)
			mess.show_modal
		end

feature -- Access

	display_state_text is
		do
			title.set_text ("LAUNCH PRECOMPILATIONS")
			message.set_text ("The precompilation will be launched as soon as you will push the Finish button%
								%%NThis can take a while !")
		end

	final_message: STRING is
			-- final message for the last message dialog at the end of all the precompilations
		do
			Result:= "Precompilations done !"
		end

	launch_precompilations is
			-- Launch all the choosen precompilations
		local
			current_it: EV_MULTI_COLUMN_LIST_ROW
			lib_info: TUPLE [STRING, BOOLEAN]
			sys_name: STRING
			ace_path: STRING
			already_precompiled: BOOLEAN_REF
		do
			progress.set_proportion (0)
			progress_2.set_proportion (0)
			progress_text.set_text ("Total Progress: ")
			progress_text_2.set_text ("Preparing precompilations ...")

			from 
				wizard_information.l_to_precompile.start
				n_lib_to_precompile:= wizard_information.l_to_precompile.count
				n_lib_done:= 0
			until
				wizard_information.l_to_precompile.after
			loop
				current_it:= wizard_information.l_to_precompile.item
				sys_name := current_it.i_th (1)
				lib_info ?= current_it.data
				ace_path ?= lib_info.item (1)
				already_precompiled ?= lib_info.item (2)

				precompile (sys_name, ace_path, already_precompiled.item)
				wizard_information.l_to_precompile.forth
			end
		end

	precompile (lib_name, lib_ace: STRING; lib_compiled: BOOLEAN) is
			-- Launch the precompilation for the library 'lib_name'
			-- Using the ace file 'lib_ace'
			-- If the library is already compiled, in 'lib_compiled' then
			-- the previous EIFGEN will be deleted.
		require
			lib_exists: lib_name /= Void and then lib_ace /= Void
		local
			to_end: BOOLEAN
			time_left, n_dir: INTEGER
			s: STRING
			proj_path, command: STRING
			total_prog: INTEGER
		do
				-- We need to find the path, the exact name and the full name of the Ace file
				-- knowing the full name. (Can be fixed .. )
			lib_ace.mirror
			n_dir:= lib_ace.index_of ('/', 1)
			if lib_ace.index_of ('\', 1) /= 0 and then n_dir > lib_ace.index_of ('\', 1) then
				n_dir:= lib_ace.index_of ('/', 1)
			end
			proj_path:= lib_ace.substring (n_dir + 1 , lib_ace.count)
			proj_path.mirror
			lib_ace.mirror

				-- Launch the precompilation and update the progress bars.
			from
				compt:= 1 -- Not needed if the file is used....
				to_end:= False
				progress_text_2.set_text ("Precompiling " + lib_name + " library: ")
				command:= wizard_information.es4_location + "es4 -precompile -ace " + lib_ace + " -project_path " + proj_path
				launch (command)
			until
				to_end = True
			loop
				time_left:= find_time (proj_path)
				if time_left >= 100 then
					to_end:= True	
				else
					progress_2.set_proportion (time_left/100)
					progress_text_2.set_text ("Precompiling " + lib_name + " library: " + time_left.out + "%%")
					
					total_prog:= ((time_left + 100*n_lib_done)/(n_lib_to_precompile)).floor
					progress.set_proportion ((time_left + 100*n_lib_done)/(100*n_lib_to_precompile))
					progress_text.set_text ("Total progress: " + total_prog.out + "%%")
				end
			end
			n_lib_done:= n_lib_done + 1
		end

	find_time (project_path: STRING): INTEGER is
			-- Check the progress file to determine the current progress of the precompilation
			-- The function will check the project file in the directory 'project_path'
		require
			project_path_exists: project_path /= Void
		local
			fi: PLAIN_TEXT_FILE
			s: STRING
			dir: DIRECTORY
			in_dir: ARRAYED_LIST [STRING]
		do
			current_application.sleep (100)
			current_application.process_events
--			compt:= compt + 1

			create dir.make (project_path)
			in_dir:= dir.linear_representation
			in_dir.compare_objects
			if in_dir.has (Progress_file) then
				create fi.make_open_read (project_path + "/" + Progress_file)
				fi.read_stream (fi.count)
				s:= fi.last_string
				fi.close
				Result:= s.to_integer
			end

--			Result:= compt
		ensure
			result_is_integer: Result /= Void
		end

feature -- Access

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard

	progress_text_2: EV_LABEL
		-- 2nd progress text (For each library)

	progress_2: EV_HORIZONTAL_PROGRESS_BAR
		-- 2nd progress bar (For each library)

	n_lib_to_precompile: INTEGER
		-- Number of library left to precompile

	n_lib_done: INTEGER
		-- Number of library already precompiled

	compt: INTEGER
		-- Used to test .. unuseful if the progress file is used

end -- class WIZARD_FINAL_STATE

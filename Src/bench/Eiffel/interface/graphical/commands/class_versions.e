indexing
	description: "Command that displays all the class versions"
	date: "$Date$"
	revision: "$Revision$"

class CLASS_VERSIONS

inherit
	PROJECT_CONTEXT

	EIFFEL_ENV

	TOOL_COMMAND
		rename
			init as make
		redefine
			tool, execute
		end

	WARNER_CALLBACKS
		rename
			execute_warner_ok as read_in_file
		end

creation
	make

feature -- Properties

	tool: CLASS_W
			-- Class tool

	name, menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Version
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

	execute_warner_help is
		do
		end

	read_in_file (argument: ANY) is
			-- Read in the file that was selected in the choice window list.
		local
			file_name: STRING
			f: PLAIN_TEXT_FILE
			pos: INTEGER
		do
			pos := choice.position
			if pos = 1 then
				tool.set_stone (stone)
				tool.synchronize
			else
					-- Didn't record the first entry into `version_list'.
					-- The first entry is always the Current stone. 
				file_name := version_list.i_th (pos - 1)
				!! f.make (file_name)
				if f.exists and then f.is_readable and then f.is_plain then
					tool.set_text_from_file (f)
				else
 					warner (popup_parent).gotcha_call
						(Warning_messages.w_Cannot_read_file (file_name))
				end
			end	
		end

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then	
				choice.popdown
			end
			stone := Void
			version_list := Void
		end

feature {NONE} -- Implementation

	stone: STONE
			-- Stone of class window

	choice: CHOICE_W
			-- Window for user choices

	version_list: ARRAYED_LIST [FILE_NAME]

feature {NONE} -- Execution

	execute (arg: ANY) is
			-- Execute the command.
		local
			classc: CLASSC_STONE
			classi: CLASSI_STONE
		do
			if (choice /= Void) and then (arg = choice) then
				if choice.position /= 0 then
					if text_window.changed then
						warner (popup_parent).custom_call (Current, Warning_messages.w_File_changed (Void),
								Interface_names.b_Yes, Interface_names.b_No, Interface_names.b_Cancel)
					else
						read_in_file (Void)
					end
				else
					close_choice_window
				end
			else
				classi ?= tool.stone
				classc ?= tool.stone
				if classi /= Void then
					display_choice (classi.class_i)
				elseif classc /= Void then
 					display_choice (classc.e_class.lace_class)
				end
			end
		end

feature {NONE} -- Implementation

	work (any: ANY) is
		do
		end

	display_choice (classi: CLASS_I) is
				-- Display class names from `class_list' to `choice'.
		require
			classi_not_void: classi /= Void
		local
			stats: SYSTEM_STATISTICS
			i, comp_nbr: INTEGER
			cluster_name: STRING
			base_name: STRING
			fname: FILE_NAME
			temp: STRING
			file: PLAIN_TEXT_FILE
			output_list: LINKED_LIST [STRING]
		do
			base_name := classi.base_name
			cluster_name := classi.cluster.cluster_name
			!! version_list.make (1)
			!! output_list.make
			!! stats.make_compilation_stat
			comp_nbr := stats.number_of_compilations
			!! temp.make (0)
			temp.append ("Current: ")
			!! file.make (classi.file_name)
			if file.exists then
				temp.append (date_string (file.date))
				temp.prune ('%N')
			end
			output_list.extend (temp)
			output_list.forth
			from
				i := comp_nbr
			until
				i = 0
			loop
				!! fname.make_from_string (Backup_path)
				!! temp.make (9)
				temp.append (Comp)
				temp.append_integer (i)
				fname.extend (temp)
				fname.extend (cluster_name)
				fname.extend (base_name)
				!! file.make (fname)
				if file.exists then
					!! temp.make (0)
					temp.append_integer (i)
					temp.append (": ")
					temp.append (date_string (file.date))
					temp.prune ('%N')
					version_list.extend (fname)
					output_list.extend (temp)
					output_list.forth
				end
				i := i - 1
			end
			if choice = Void then
				!! choice.make (popup_parent)
			end
			stone := tool.stone
			choice.popup (Current, output_list, Interface_names.t_Select_class_version)
		end
		
feature {NONE} -- Externals

	date_string (a_date: INTEGER): STRING is
			-- String representation of `a_date'
		external
			"C"
		alias
			"eif_date_string"
		end

end -- class CLASS_VERSIONS

indexing
	description: "Command that displays all the class versions"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_CLASS_VERSIONS

inherit
	PROJECT_CONTEXT

	EIFFEL_ENV

	EB_EDITOR_COMMAND
		redefine
			tool
		end

	EB_CONFIRM_SAVE_CALLBACK

	NEW_EB_CONSTANTS

creation
	make

feature -- Properties

	tool: EB_DEVELOPMENT_TOOL
			-- Class tool

--	name, menu_name: STRING is
--			-- Name used in menu entry
--		do
--			Result := Interface_names.m_Version
--		end

--	accelerator: STRING is
--			-- Accelerator action for menu entry
--		do
--		end

	process is
			-- Read in the file that was selected in the choice window list.
		local
			file_name: STRING
			f: PLAIN_TEXT_FILE
			wd: EV_WARNING_DIALOG
		do
			if position = 1 then
				tool.set_stone (stone)
				tool.synchronize
			else
					-- Didn't record the first entry into `version_list'.
					-- The first entry is always the Current stone. 
				file_name := version_list.i_th (position - 1)
				create f.make (file_name)
				if f.exists and then f.is_readable and then f.is_plain then
					tool.show_file (f)
				else
 					create wd.make_with_text (Warning_messages.w_Cannot_read_file (file_name))
					wd.show_modal
				end
			end	
		end

feature {NONE} -- Implementation

	stone: CLASS_STONE
			-- Stone of class window

	position: INTEGER
			-- position of item chosen in choice dialog.

	version_list: ARRAYED_LIST [FILE_NAME]
			-- List of file names corresponding at the
			-- different versions of the class.

feature {NONE} -- Execution

	execute is
			-- Ask for version displaying.
		local
			classi: CLASSI_STONE
			classc: CLASSC_STONE
		do
				--| Event just triggered. We have to provide user a
				--| dialog for him choice a version.
			classi ?= tool.stone
			if classi /= Void then
				display_choice (classi.class_i)
			else
				classc ?= tool.stone
				if classc /= Void then
 					display_choice (classc.e_class.lace_class)
				else
						--| If stone is not a class stone, it must be Void.
					check
						no_stone: tool.stone = Void
					end
				end
			end
		end

	process_ith (pos: INTEGER) is
			-- Treat callback from choice window.
		local
			csd: EB_CONFIRM_SAVE_DIALOG
		do
			position := pos
			if position /= 0 then
				if tool.text_area.changed then
					create csd.make_and_launch (tool, Current)
						--| possible callback treated by `process'
				else
					process
				end
			end
		end

feature {NONE} -- Implementation

	display_choice (classi: CLASS_I) is
			-- Display class names from `class_list' in `choice'.
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
			choice : EB_CHOICE_DIALOG
		do
			base_name := classi.base_name
			cluster_name := classi.cluster.cluster_name
			create version_list.make (1)
			create output_list.make
			create stats.make_compilation_stat
			comp_nbr := stats.number_of_compilations
			create temp.make (0)
			temp.append ("Current: ")
			create file.make (classi.file_name)
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
				create fname.make_from_string (Backup_path)
				create temp.make (9)
				temp.append (Comp)
				temp.append_integer (i)
				fname.extend (temp)
				fname.extend (cluster_name)
				fname.extend (base_name)
				create file.make (fname)
				if file.exists then
					create temp.make (0)
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
			create choice.make_default (~process_ith (?))
			stone := tool.stone
			choice.set_title (Interface_names.t_Select_class_version)
			choice.set_list (output_list)
			choice.show
				--| Callback treated in `execute', if any
		end

end -- class EB_SHOW_CLASS_VERSIONS

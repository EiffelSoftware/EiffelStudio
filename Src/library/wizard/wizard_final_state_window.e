indexing
	description	: "Template for the first state of a wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_INITIAL_STATE_WINDOW
		export
			{NONE} all
		redefine
			display,
			proceed_with_current_info,
			is_final_state
		end

feature -- Basic Operations

	display is
			-- Display Current State
		do
			first_window.set_final_state ("Finish")
			build
		end

	proceed_with_current_info is
			-- destroy the window.
			-- Descendants have to redefine this routine
			-- if they want to add generation, warnings, ...
		do
			precursor
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

	copy_file (name, extension, destination: STRING) is
			-- Copy Class whose name is 'name'
		require
			name /= Void
		local
			f1,f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
		do
			create f1.make_from_string (wizard_resources_path)
			f_name := clone (f1)
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_read (f_name)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create f_name.make_from_string (destination)
			f_name.extend (name)
			f_name.add_extension (extension)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close
		end

	from_template_to_project (template_path, template_name, resource_path, resource_name: STRING; map_list: LINKED_LIST [TUPLE [STRING, STRING]]) is
			-- Take a template_name (name of the file) and its template_path
			-- Then change the FL Tag with strings according to the map_list
			-- Copy the modified template in a new file resource_name in the resource_path.
		local
			tup: TUPLE [STRING, STRING]
			s, s1, s2: STRING
			fi: PLAIN_TEXT_FILE
			f_name: FILE_NAME
		do
			create fi.make_open_read_write(template_path + "\" + template_name)
			fi.read_stream (fi.count)
			s:= clone (fi.last_string)
			if map_list /= Void then
				from
					map_list.start
				until
					map_list.after
				loop
					tup:= map_list.item
					s1 ?= tup.item (1)
					s2 ?= tup.item (2)
					if s1 /= Void and s2 /= Void then
						s.replace_substring_all (s1, s2)
					end
					map_list.forth
				end
			end
			fi.close
			create f_name.make_from_string (resource_path + "\" + resource_name)
			create fi.make_open_write (f_name)
			fi.put_string (s)
			fi.close

		end

	notify_user (s: STRING) is
			-- Output
		require
			not_void: s /= Void
		do
			progress_text.set_text(s)
			iteration := iteration + 1
			progress.set_proportion(iteration/total)
		end

	total, iteration: INTEGER

	ebench_launcher: EBENCH_LAUNCHER
		-- Class to launch ebench after the generation

feature -- Access

	is_final_state: BOOLEAN is TRUE

	final_message: STRING is 
		deferred
		end

	progress_text: EV_LABEL

	progress: EV_HORIZONTAL_PROGRESS_BAR


end -- class WIZARD_FINAL_STATE_WINDOW

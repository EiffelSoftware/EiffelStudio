indexing
	description: "Dialog used for final wizard interaction.  Shows summary%
		%of previous steps taken from WIZARD_INFORMATION, and must call%
		%appropriate wizard generation procedure(s) using `finish_wizard'."
	date: "$Date$"
	revision: "$Revision$"

class
	FINAL_DIALOG

inherit
	FINAL_DIALOG_IMP
		undefine
			show
		end

	WIZARD_DIALOG
		rename
			user_initialization as wizard_user_initialization,
			move_next as finish
		undefine
			initialize,
			is_in_default_state
		end
		
	SHARED_OBJECTS
		undefine
			copy,
			default_create
		end

create
	make_with_previous	

feature {NONE} -- Initialization

	user_initialization is
			-- called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			finish_bt.select_actions.extend (agent finish_wizard)
			back_bt2.select_actions.extend (agent move_previous)
			cancel_bt1.select_actions.extend (agent cancel)
			show_actions.extend (agent show_summary)
		end

feature {NONE} -- Implementation

	show_summary is
			-- Show summary of Wizard option
		local
			l_summary: EV_FRAME
		do
			from
				summary_box.wipe_out
				Summary_list.start
			until
				Summary_list.after
			loop
				l_summary := Summary_list.item.frame
				summary_box.extend (l_summary)
				summary_box.disable_item_expand (l_summary)
				Summary_list.forth
			end
		end

	finish_wizard is
			-- Finish wizard, perform necessary tasks.
		do
			hide
			if Wizard_data.is_html_to_help_convert then
				generate_html
				generate_help						
			elseif Wizard_data.is_help_convert then
				generate_help
			elseif Wizard_data.is_html_convert then
				generate_html
			end
			destroy
		end

	set_summary is
			-- Set summary data
		do		
		end
		
	summary: SUMMARY_BOX is 
			-- Summary widget
		once
			create Result.make (Current, "Summary")	
		end
		
feature {NONE} -- Implmentation

	generate_html is
			-- Generate HTML
		do
			generate_documentation_html	
			generate_code_html	
		end		

	generate_documentation_html is
			-- Generate HTML for documentation
		local
			html: HTML_GENERATOR
			l_dir_name: DIRECTORY_NAME
			l_files: ARRAYED_LIST [STRING]
		do
			create l_dir_name.make_from_string (Shared_constants.Application_constants.html_location)
			if Wizard_data.is_help_convert then
					-- Since we are also converting into a help project, for speed purposes 
					-- convert only the files necessary for the toc
				l_files := Shared_constants.Help_constants.toc.files (True)
			else
					-- Since there is no help project to be generated use all files in loaded project
				create l_files.make_from_array (Shared_document_manager.documents.current_keys)
			end
			create html.make (l_files, l_dir_name)
			html.generate
		end
		
	generate_code_html is
			-- Generate Eiffel code HTML
		local
			l_code_dir, 
			l_code_target_dir,
			l_sub_dir,
			l_target_sub_dir: DIRECTORY
			l_code_dir_name: FILE_NAME
			l_code_html_filter: CODE_HTML_FILTER
			l_cnt: INTEGER
			l_curr_dir: STRING
		do
				-- Target directory for HTML
			create l_code_dir_name.make_from_string (Shared_constants.Application_constants.Temporary_html_directory)
			l_code_dir_name.extend ("libraries")		
			create l_code_target_dir.make (l_code_dir_name)
			if l_code_target_dir /= Void then
				if not l_code_target_dir.exists then
					l_code_target_dir.create_dir
				end
			end
			
				-- Src directory of XML code files				
			create l_code_dir_name.make_from_string (Shared_project.root_directory)
			l_code_dir_name.extend ("libraries")
			create l_code_dir.make (l_code_dir_name)
			
				-- Build directories and code HTML into 'reference' directory of top-level cluster				
			from
				l_code_dir.open_read
				l_code_dir.start
				create l_curr_dir.make_empty
			until
				l_curr_dir = Void
			loop
				l_code_dir.readentry
				l_curr_dir := l_code_dir.lastentry
				if l_curr_dir /= Void and then not l_curr_dir.is_equal (".") and not l_curr_dir.is_equal ("..") then
					create l_code_dir_name.make_from_string (l_code_dir.name)
					l_code_dir_name.extend (l_curr_dir)
					l_code_dir_name.extend ("reference")
					create l_sub_dir.make (clone (l_code_dir_name))
					if l_sub_dir.exists then
							-- We are in `project_root/libraries/library_name/reference', a code directory
						Shared_constants.Application_constants.add_code_directory (l_sub_dir.name)
						l_code_dir_name.make_from_string (l_code_target_dir.name)
						l_code_dir_name.extend (l_curr_dir)
						l_code_dir_name.extend ("reference")
						create l_target_sub_dir.make (l_code_dir_name)
						if not l_target_sub_dir.exists then
							l_target_sub_dir.create_dir							
						end
						create l_code_html_filter.make (l_target_sub_dir, l_sub_dir)
					end
				end				
				l_cnt := l_cnt + 1
			end	
		end		
	
	generate_help is
			-- Generate help	
		local			
			help: HELP_GENERATOR
			l_loc: DIRECTORY
			l_help_settings: HELP_SETTING_CONSTANTS
			l_toc: TABLE_OF_CONTENTS
			l_name: STRING
		do			
			l_help_settings := Shared_constants.Help_constants
			l_name := l_help_settings.help_project_name
			create l_loc.make (l_help_settings.help_directory)
			l_toc := l_help_settings.toc
			if l_help_settings.is_html_help then
				create help.make (create {HTML_HELP_PROJECT}.make (l_loc, l_name, l_toc))
				help.generate
			elseif l_help_settings.is_vsip_help then				
				create help.make (create {MSHELP_PROJECT}.make (l_loc, l_name, l_toc))
				help.generate				
			elseif l_help_settings.is_web_help then
				-- TO DO: Web generation
				--create {WEB_HELP_PROJECT} help.create_with_filename (Wizard_data.help_generated_file_location, Wizard_data.help_project_name)
			end
		end

invariant
	has_previous: previous_dialog /= Void
	not_has_next: next_dialog = Void

end -- class FINAL_DIALOG


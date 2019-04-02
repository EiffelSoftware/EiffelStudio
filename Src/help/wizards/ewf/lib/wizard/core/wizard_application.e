note
	description: "Abstract wizard application."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_APPLICATION

inherit
	SHARED_EXECUTION_ENVIRONMENT

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'.
		local
			i,n: INTEGER
			s: READABLE_STRING_32
			wizard_directory_name: detachable PATH
			callback_file_name: detachable PATH
			args: ARGUMENTS_32
		do
				-- Usage
			args := execution_environment.arguments
			n := args.argument_count
			if n > 0 then
				from
					i := 1
				until
					i > n
				loop
					s := args.argument (i)
					if s.same_string_general ("-callback") or s.same_string_general ("--callback") then
						i := i + 1
						if i <= n then
							s := args.argument (i)
							create callback_file_name.make_from_string (s)
						end
					elseif wizard_directory_name = Void then
						create wizard_directory_name.make_from_string (s)
					else
						debug
							io.error.put_string ("Ignoring argument %"" + s + "%"%N")
						end
					end
					i := i + 1
				end
			end
			if wizard_directory_name = Void then
				create layout.make (execution_environment.current_working_path, execution_environment.current_working_path.extended ("wizard.cb"))
				display_usage (io.error)
				quit ("ERROR: Missing wizard directory name.")
			elseif callback_file_name = Void then
				create layout.make (execution_environment.current_working_path, execution_environment.current_working_path.extended ("wizard.cb"))
				display_usage (io.error)
				quit ("ERROR: Missing Eiffel Studio callback file name.")
			else
				create layout.make (wizard_directory_name, callback_file_name)
			end


				-- Values
			create data.make (10)
			create variables.make (5)
			create page_history.make (10)

				-- Wizard
			wizard := new_wizard
		end

	new_wizard: WIZARD
			-- Build new wizard.
			-- To be redefined.
		deferred
		end

	wizard: like new_wizard
			-- Associated Wizard.

feature -- Helpers

	display_usage (f: FILE)
		do
			f.put_string ("Usage: wizard {dirname} -callback {filename}%N")
			f.put_string ("       -callback filename: file used to communicate back with Eiffel Studio%N")
			f.put_string ("        dirname: folder containing the wizard resources, pixmaps, ...%N")
		end

	quit (a_failure_message: detachable READABLE_STRING_8)
		do
			if a_failure_message /= Void then
				io.error.put_string (a_failure_message)
			end
			send_response (create {WIZARD_FAILED_RESPONSE})
			die (-1)
		ensure
			False -- never reached
		end

	die (code: INTEGER)
		do
			(create {EXCEPTIONS}).die (code)
		end

	available_directory_path (a_name: READABLE_STRING_GENERAL; a_folder: PATH): PATH
		local
			ut: FILE_UTILITIES
			ok: BOOLEAN
			p: PATH
			l_name: STRING_32
			l_ext: detachable READABLE_STRING_32
			i: INTEGER
		do
			from
				Result := a_folder.extended (a_name)
				ok := not ut.directory_path_exists (Result)
				p := Result
				if
					not ok and then
					attached p.extension as ext
				then
					l_ext := ext
					l_name := p.name
					l_name.remove_head (ext.count + 1)
					create p.make_from_string (l_name)
				end
			until
				ok
			loop
				i := i + 1
				Result := p.appended ("_" + i.out)
				if l_ext /= Void then
					Result := Result.appended_with_extension (l_ext)
				end
				ok := not ut.directory_path_exists (Result)
			end
		end

feature -- Access

	variables: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]

	layout: WIZARD_LAYOUT

	data: WIZARD_DATA

feature -- State		

	current_page: detachable WIZARD_PAGE
		do
			if not page_history.is_empty then
				Result := page_history.item
			end
		end

	next_page (a_current_page: detachable WIZARD_PAGE): WIZARD_PAGE
		do
			Result := wizard.next_page (a_current_page)
			if Result /= a_current_page then
				Result.set_previous_page (a_current_page)
			end
		end

	page_history: ARRAYED_STACK [WIZARD_PAGE]

feature -- Factory	

	new_page (a_page_id: READABLE_STRING_8): WIZARD_PAGE
		deferred
		end

feature -- Events

	set_page (a_page: WIZARD_PAGE)
		do
			a_page.reuse
			if attached data.page_data (a_page.page_id) as l_page_data then
				a_page.set_data (l_page_data)
			end
			page_history.force (a_page)
		ensure
			current_page_set: current_page = a_page
		end

	on_start
		do
			set_page (next_page (Void))
		end

	on_refresh
		do
			if attached current_page as pg then
				pg.validate
				data.record_page_data (pg.data, pg.page_id)
				set_page (pg)
			else
				check refresh_expected: False end
			end
		end

	on_back
		do
			if
				attached current_page as pg and then
				attached pg.previous_page as l_prev
			then
				pg.validate
				data.record_page_data (pg.data, pg.page_id)
				page_history.remove
				page_history.remove
				set_page (l_prev)
			end
		end

	on_next
		do
			if attached current_page as pg then
				pg.validate
				if pg.has_error then
					on_refresh
				else
					data.record_page_data (pg.data, pg.page_id)
					set_page (next_page (pg))
				end
			else
				set_page (next_page (Void))
			end
		end

	on_cancel
		do
			quit (Void) --"Cancelled")
		end

	on_generate
		do
			wizard.wizard_generator.execute (data)
		end

	on_finish
		do
			if attached current_page as pg then
				if pg.has_error then
					on_refresh
				else
					on_generate
				end
			else
				on_refresh
			end
		end

feature -- Response	

	send_response (res: WIZARD_RESPONSE)
		local
			f: RAW_FILE
		do
			create f.make_with_path (layout.callback_file_location)
			if not f.exists or else f.is_writable then
				f.open_write
				res.send (f)
				f.close
			else
				die (-1)
			end
		end

end

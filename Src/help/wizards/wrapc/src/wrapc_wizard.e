note
	description: "Wizard for Eiffel Wrapc Libraries."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_WIZARD

inherit
	WIZARD

create
	make

feature -- Access

	title: STRING_32 = "Eiffel WrapC Wizard"

	default_project_name: STRING_32 = "new_library"

feature -- Factory

	wizard_generator: WRAPC_WIZARD_GENERATOR
		do
			create Result.make (Current)
		end

feature -- Pages

	first_page: WIZARD_PAGE
		once
			Result := new_page ("first")
			Result.set_title ("Eiffel WrapC Wizard")
			Result.add_section_text ("Create a reusable Eiffel WrapC Library.")
			Result.add_text ("[
				WrapC is an Eiffel wrapper generator for C libraries
				It can be used to create libraries that bridge the gap between Eiffel and C. 
				It aims to work for arbitrary ANSI C and with EiffelSoftware compiler
					
				
				More information at:
			]")
			Result.add_linked_text ("- https://github.com/eiffel-wrap-c", "https://github.com/eiffel-wrap-c")
			Result.add_linked_text ("- https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md", "https://github.com/eiffel-wrap-c/WrapC/blob/master/doc/Readme.md")
		end

	library_page: WIZARD_PAGE
		local
			q_str: WIZARD_STRING_QUESTION
			q_dir: WIZARD_DIRECTORY_QUESTION
		once
			Result := new_page ("library")
			Result.set_previous_page (c_library_page)
			Result.set_title ("Library Name and Project Location")
			Result.set_subtitle ("You can choose the name of the project and%Nthe directory where the project will be generated.")
			Result.add_text ("[
				Please fill in:
					The name of the project (without space).
					The directory where you want the eiffel classes to be generated.
			]")
			q_str := Result.new_string_question ("Project name:", "name", "ASCII name, without space")
			Result.extend (q_str)
			q_dir := Result.new_directory_question ("Project location:", "location", "Valid directory path, it will be created if missing")
			Result.extend (q_dir)
			q_str.value_change_actions.extend (agent (i_str: WIZARD_STRING_QUESTION; i_dir: WIZARD_DIRECTORY_QUESTION)
					local
						s, v: READABLE_STRING_GENERAL
						p: PATH
					do
						v := i_str.value
						create p.make_from_string (i_dir.text)
						if
							i_dir.text.ends_with_general ("/")
							or i_dir.text.ends_with_general ("\")
						then
								-- Keep current dir
						else
							p := p.parent
						end

						if v = Void then
							s := application.available_directory_path (default_project_name, p).name
							i_dir.set_text (s)
						elseif not v.is_whitespace then
							s := application.available_directory_path (v, p).name
							i_dir.set_text (s)
						end
					end(?,q_dir)
				)
			Result.data.force (default_project_name, "name")
			Result.data.force (application.available_directory_path (default_project_name, application.layout.default_projects_location.extended ("demo")).name, "location")

			Result.set_validation (agent  (a_page: WIZARD_PAGE)
				do
					if
						not attached a_page.data.item ("name") as l_name
						or else l_name.is_whitespace
					then
						a_page.report_error ("Invalid value for `name'!")
					end
					if not a_page.data.has ("location") then
						a_page.report_error ("Missing value for `location'!")
					end
				end)

		end

	c_library_page: WIZARD_PAGE
		once
			Result := new_page ("c_library")
			Result.set_previous_page (first_page)
			Result.set_title ("C Library Name and Location")
			Result.set_subtitle ("Set the C library name and%Nthe directory where the C header will be located and the header to be used")
			Result.extend (Result.new_string_question ("C Library name:", "name", "ASCII name, without space"))
			Result.add_file_question ("C library header location:", "c_header_location", "Filename (including pathname) to the C header to be preprocessed,%Nand name of header file, that should be used in Eiffel external clauses")
				--Result.add_string_question ("C header neame:", "c_header", "Valid name C header file")
			Result.add_string_question ("C compiler options:", "c_compile_options", "Optional c compile options")

			Result.data.force ("c_library", "name")
			Result.data.force ("", "c_header_location")
			Result.data.force ("", "c_compile_options")

			Result.set_validation (agent  (a_page: WIZARD_PAGE)
				do
					a_page.update_actions.extend (agent  (l_page: WIZARD_PAGE)
						local
							name: STRING_32
							index: INTEGER
						do
							if attached l_page.data.item ("c_header_location") as l_location then
								create name.make_from_string (l_location)
								if {PLATFORM}.is_windows then
									index := name.last_index_of ({PATH}.windows_separator, name.count)
								else
									index := name.last_index_of ({PATH}.unix_separator, name.count)
								end
								l_page.data.force (name.substring (1, index), "c_header_path")
								l_page.data.force (name.substring (index + 1, name.count), "c_header")
							end

						end (a_page))
					a_page.update_actions.call (Void)
					if
						not attached a_page.data.item ("name") as l_name
						or else l_name.is_whitespace
					then
						a_page.report_error ("Invalid value for `name'!")
					end
					if not a_page.data.has ("c_header_location") then
						a_page.report_error ("Missing value for `c_header_location'!")
					end
					if not a_page.data.has ("c_header") then
						a_page.report_error ("Missing value for `c_header'!")
					end
				end)
		end

	select_c_functions_page: WIZARD_PAGE
		local
			wfg: WRAPC_WIZARD_FUNCTION_GENERATOR
			l_header_path: STRING_32
			list_options: GRAPHICAL_WRAPC_WIZARD_LIST_OPTIONS
		do
			Result := new_page ("c_functions")
			Result.set_previous_page (library_page)
			Result.set_title ("List of C functions")
			Result.set_subtitle ("Select the C funtions that you want to wrap.")

			l_header_path := {STRING_32} ""
			if attached c_library_page.data.item ("c_header_location") as l_loc then
				l_header_path := l_loc
				Result.data.force (l_header_path, "c_full_header_path")
			end

			create wfg.make (l_header_path)
			create list_options.make ("select_c_functions", wfg.list_of_functions, l_header_path)
			Result.extend (list_options)
		end

	generator_page: WIZARD_PAGE
		local
		do
			Result := new_page ("WrapC generator")
			Result.set_title ("generate Eiffel and C glue code")
		end

	final_page: WIZARD_PAGE
		local
			txt1, txt2: WIZARD_PAGE_TEXT_ITEM
			ev_list: EV_LIST
			ev_list_box: EV_VERTICAL_BOX

		once
			Result := new_page ("final")
			Result.set_title ("Completing the New Eiffel WrapC Library Wizard")
			Result.add_text ("You have specified the following settings:%N%N")
			txt1 := Result.new_fixed_size_text_item ("...")
			Result.extend (txt1)

			txt2 := Result.new_fixed_size_text_item ("List of C functions to be wrapped")
			Result.extend (txt2)

			create ev_list
			create ev_list_box

			ev_list.set_minimum_size (50, 100)
			ev_list_box.extend (ev_list)
			ev_list_box.set_border_width (5)
			ev_list_box.set_padding_width (5)
			ev_list.set_tooltip ("List of C functions to be wrapped")
			ev_list_box.disable_item_expand (ev_list)
			Result.extend (create {GRAPHICAL_WIZARD_PAGE_WIDGET}.make_with_widget (ev_list_box))

			Result.update_actions.extend (agent  (a_page: WIZARD_PAGE; a_txt1, a_txt2: WIZARD_PAGE_TEXT_ITEM; a_ev_list: EV_LIST)
				local
					l_settings: ARRAYED_LIST [TUPLE [title: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]]
				do
					create l_settings.make (10)

					if attached a_page.previous_page as l_previous_page and then attached {GRAPHICAL_WRAPC_WIZARD_LIST_OPTIONS} l_previous_page.items.at (1) as l_collection then
						a_ev_list.wipe_out

						across l_collection.checkeable_list.checked_items as ic loop
							a_ev_list.force (create {EV_LIST_ITEM}.make_with_text (ic.item.text))
						end

					end

					if attached library_page.field_value ("name") as l_project_name then
						l_settings.force (["Project name", l_project_name])
					end
					if attached library_page.field_value ("location") as l_project_location then
						l_settings.force (["Location", l_project_location])
					end

					if attached c_library_page.field_value ("name") as l_c_name then
						l_settings.force (["C library name", l_c_name])
					end
					if attached c_library_page.field_value ("c_header_location") as l_c_header_location then
						l_settings.force (["C header location", l_c_header_location])
					end
					if attached c_library_page.field_value ("c_header") as l_c_header then
						l_settings.force (["C header ", l_c_header])
					end
					if attached c_library_page.field_value ("c_compile_options") as l_c_compile_options then
						l_settings.force (["C compile options ", l_c_compile_options])
					end
					a_txt1.set_text (formatted_title_value_items (l_settings))

				end (Result, txt1, txt2, ev_list))
		end

feature -- Events

	next_page (a_current_page: detachable WIZARD_PAGE): WIZARD_PAGE
		do
			Result := notfound_page
			if a_current_page = Void then
				Result := first_page
			elseif a_current_page = first_page then
				Result := c_library_page
			elseif a_current_page.page_id.is_case_insensitive_equal ("c_library") then
				Result := library_page
			elseif a_current_page.page_id.is_case_insensitive_equal ("library") then
				Result := select_c_functions_page
			elseif a_current_page.page_id.is_case_insensitive_equal ("c_functions") then
				copy_functions_to_wizard_data (a_current_page)
				Result := final_page
			end
		end

feature {NONE} -- Implementation

	copy_functions_to_wizard_data (a_page: WIZARD_PAGE)
			-- Copy selected C functions if any to WIZARD_DATA
		require
			a_page.page_id.same_string ("c_functions")
		local
			ev: EV_CHECKABLE_LIST
			i: INTEGER
			str: STRING_8
		do
			from
				a_page.items.start
			until
				a_page.items.after or attached ev
			loop
				if attached {GRAPHICAL_WRAPC_WIZARD_LIST_OPTIONS} a_page.items.item as l_page_item
				then
					ev := l_page_item.checkeable_list
				end
				a_page.items.forth
			end
				-- Copy all checked items
			if attached ev then
				across ev.checked_items as ic loop
					str := ic.item.text.to_string_8
					i := str.index_of ('(', 1)
					str := str.substring (1, i - 1)
					str.adjust
					if str.at (1) = '*' then
						str.remove_head (1)
					end
					a_page.data.elements.force (str)
				end
			end

		end

end

note
	description: "Wizard for Eiffel Libraries."
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_WIZARD

inherit
	WIZARD

create
	make

feature -- Access

	title: STRING_32 = "Eiffel Library Wizard"

	default_library_name: STRING_32 = "new_library"

feature -- Factory	

	wizard_generator : LIBRARY_WIZARD_GENERATOR
		do
			create Result.make (Current)
		end

feature -- Pages

	first_page: WIZARD_PAGE
		once
			Result := new_page ("first")
			Result.set_title ("Eiffel Library Wizard")
			Result.add_section_text ("Create a reusable Eiffel Library.")
		end

	library_page: WIZARD_PAGE
		local
			q_str: WIZARD_STRING_QUESTION
			q_dir: WIZARD_DIRECTORY_QUESTION
		once
			Result := new_page ("library")
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
							s := application.available_directory_path (default_library_name, p).name
							i_dir.set_text (s)
						elseif not v.is_whitespace then
							s := application.available_directory_path (v, p).name
							i_dir.set_text (s)
						end
					end(?,q_dir)
				)
			Result.data.force (default_library_name, "name")
			Result.data.force (application.available_directory_path (default_library_name, application.layout.default_projects_location.extended ("demo")).name, "location")

			Result.set_validation (agent (a_page: WIZARD_PAGE)
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


	final_page: WIZARD_PAGE
		local
			txt1, txt2: WIZARD_PAGE_TEXT_ITEM
		once
			Result := new_page ("final")
			Result.set_title ("Completing the New Eiffel Library Wizard")
			Result.add_text ("You have specified the following settings:%N%N")
			txt1 := Result.new_fixed_size_text_item ("...")
			Result.extend (txt1)

			txt2 := Result.new_fixed_size_text_item ("...")
			Result.extend (txt2)

			Result.update_actions.extend (agent (a_page: WIZARD_PAGE; a_txt1, a_txt2: WIZARD_PAGE_TEXT_ITEM)
				local
					l_settings: ARRAYED_LIST [TUPLE [title: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]]
				do
						-- Project
					create l_settings.make (10)
					if attached library_page.field_value ("name") as l_project_name then
						l_settings.force (["Project name", l_project_name])
					end
					if attached library_page.field_value ("location") as l_project_location then
						l_settings.force (["Location", l_project_location])
					end
					a_txt1.set_text (formatted_title_value_items (l_settings))
				end(Result, txt1, txt2))
		end

feature -- Events

	next_page (a_current_page: detachable WIZARD_PAGE): WIZARD_PAGE
		do
			Result := notfound_page
			if a_current_page = Void then
				Result := first_page
			elseif a_current_page = first_page then
				Result := library_page
			elseif a_current_page = library_page then
				Result := final_page
			end
		end

end

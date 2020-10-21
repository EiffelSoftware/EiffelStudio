note
	description: "Wizard for DEMO projects."
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO_WIZARD

inherit
	WIZARD

create
	make

feature -- Access

	title: STRING_32 = "DEMO Application Wizard"

	default_project_name: STRING_32 = "new_app"

feature -- Factory	

	wizard_generator : DEMO_WIZARD_GENERATOR
		do
			create Result.make (Current)
		end

feature -- Pages

	first_page: WIZARD_PAGE
		once
			Result := new_page ("first")
			Result.set_title ("DEMO Application Wizard")
			Result.set_subtitle ("This is an example to show how to use the wizard library...")
			Result.add_section_text ("Create DEMO application.")
			Result.add_text ("[
		
This wizard demonstrates the use of the Wizard library to build EiffelStudio wizard.

			]")
		end

	project_page: WIZARD_PAGE
		local
			q_str: WIZARD_STRING_QUESTION
			q_dir: WIZARD_DIRECTORY_QUESTION
		once
			Result := new_page ("project")
			Result.set_title ("Project Name and Project Location")
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

			Result.set_validation (agent (a_page: WIZARD_PAGE)
				do
					if
						not attached a_page.data.item ("name") as l_name
						or else l_name.is_whitespace
					then
						a_page.report_error ("Invalid value for `name`")
					end
					if not a_page.data.has ("location") then
						a_page.report_error ("Missing value for `location`")
					end
				end)
		end

	arguments_choice_page: WIZARD_PAGE
		once
			Result := new_page ("With or without arguments")
			Result.set_title ("Arguments usage")
			Result.set_subtitle ("You can choose to use arguments, or not.")
			Result.add_text ("[
An application can use argument passed in the command...

Select your options:
	]")
			Result.add_boolean_question ("With arguments", "use_arguments", "Use the ARGUMENTS_32 interface")
			Result.add_boolean_question ("Without arguments", "not_use_arguments", "Do not use any ARGUMENTS_32 interface")

			Result.data.force ("yes", "use_arguments")
			Result.data.force ("no", "not_use_arguments")
		end

	use_arguments_page: WIZARD_PAGE
		once
			Result := new_page ("App using arguments")
			Result.set_title ("The app will use arguments")
			Result.add_text ("[
You can choose what to do first

Select your options:
	]")
			Result.add_boolean_question ("Display the argument count", "display_argument_count", "Display the argument_count")
			Result.add_boolean_question ("Do nothing", "do_nothing", "Do nothing")

			Result.data.force ("yes", "display_argument_count")
			Result.data.force ("no", "do_nothing")
		end

	sub_dir_page: WIZARD_PAGE
		local
			q_dir: WIZARD_DIRECTORY_QUESTION
		once
			Result := new_page ("Sub directory")
			Result.set_title ("Choose a sub directory")
			Result.set_subtitle ("A sub directory depending on the application name...")

			q_dir := Result.new_directory_question ("Sub directory location:", "sub_dir_location", "Valid directory path, it will be created if missing")
			Result.extend (q_dir)
			if attached project_page ["location"] as loc then
				Result.data.force (loc, "sub_dir_location")
			end
		end

	final_page: WIZARD_PAGE
		local
--			s,sv: STRING_32
--			l_settings: ARRAYED_LIST [TUPLE [title: READABLE_STRING_GENERAL; value: READABLE_STRING_GENERAL]]
--			l_project_settings: STRING_32
--			l_ewf_settings: STRING_32
			txt1, txt2: WIZARD_PAGE_TEXT_ITEM
		once
			Result := new_page ("final")
			Result.set_title ("Completing the DEMO Application Wizard")
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
					if attached project_page ["name"] as l_project_name then
						l_settings.force (["Project name", l_project_name])
					end
					if attached project_page ["location"] as l_project_location then
						l_settings.force (["Location", l_project_location])
					end
					a_txt1.set_text (formatted_title_value_items (l_settings))

					create l_settings.make (5)
					if arguments_choice_page.boolean_field_value ("use_arguments") then
						l_settings.force (["use_arguments", "yes"])
					end

					a_txt2.set_text (formatted_title_value_items (l_settings))
				end(Result, txt1, txt2))
		end

feature -- Events

	next_page (a_current_page: detachable WIZARD_PAGE): WIZARD_PAGE
		do
			Result := notfound_page
			if a_current_page = Void then
				Result := first_page
			elseif a_current_page = first_page then
				Result := project_page
			elseif a_current_page = project_page then
				Result := arguments_choice_page
			elseif a_current_page = arguments_choice_page then
				if
					arguments_choice_page.boolean_field_value ("use_arguments")
				then
					Result := use_arguments_page
				else
					Result := sub_dir_page
				end
			elseif a_current_page = use_arguments_page then
				Result := sub_dir_page
			elseif a_current_page = sub_dir_page then
				Result := final_page
			end
		end

end

note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

deferred class
	CONSOLE_WIZARD_APPLICATION

inherit
	WIZARD_APPLICATION
		redefine
			set_page,
			on_start,
			on_finish,
			on_next,
			on_refresh,
			on_back
		end

	LOCALIZED_PRINTER

feature -- Factory	

	new_page (a_page_id: READABLE_STRING_8): CONSOLE_WIZARD_PAGE
		do
			create Result.make (a_page_id)
		end

	set_page (a_page: WIZARD_PAGE)
		do
			Precursor (a_page)

			process_page (a_page)
		end

feature -- Execution

	on_start
		do
			Precursor
			on_navigation
		end

	on_finish
		do
			Precursor
		end

	on_next
		do
			Precursor
			on_navigation
		end

	on_refresh
		do
			Precursor
			on_navigation
		end

	on_back
		do
			Precursor
			on_navigation
		end

	on_navigation
		do
			if attached current_page as pg then
				if pg = wizard.notfound_page then
					on_cancel
				elseif pg = wizard.final_page then
					on_finish
				else
					localized_print ("%N")
					if attached string_question ("Continue", <<["c", "Continue"], ["r", "Refresh"], ["b", "Back"], ["q", "Cancel"]>>, "c", True) as s then
						if s.is_case_insensitive_equal_general ("Cancel") then
							on_cancel
						elseif s.is_case_insensitive_equal_general ("Refresh") then
							on_refresh
						elseif s.is_case_insensitive_equal_general ("Back") then
							on_back
						elseif s.is_case_insensitive_equal_general ("Continue") then
							on_next
						else
							on_next
						end
					else
						on_next
					end
				end
			else
				on_cancel
			end
		end

	process_page (a_page: WIZARD_PAGE)
		do
			a_page.apply_data
			localized_print ("%N")

			if attached a_page.title as l_title then
				localized_print (l_title)
				localized_print ("%N")
				localized_print (create {STRING}.make_filled ('=', l_title.count))
				localized_print ("%N")

				if attached a_page.subtitle as l_subtitle then
					localized_print ("  -- ")
					localized_print (l_subtitle)
					localized_print ("%N")
				end
			end

			if attached a_page.reports as lst and then not lst.is_empty then
				across
					lst as ic
				loop
					localized_print (" : ")
					if ic.item.type = {WIZARD_PAGE}.error_report_type then
						localized_print ("Error:")
					elseif ic.item.type = {WIZARD_PAGE}.warning_report_type then
						localized_print ("Warning:")
					else
						localized_print ("Info:")
					end
					localized_print (ic.item.message)
					localized_print ("%N")
				end
			end

			a_page.reset_reports

			across
				a_page.items as ic
			loop
				output_page_item (ic.item)
			end
		end

	output_page_item (a_item: WIZARD_PAGE_ITEM)
		local
			b: BOOLEAN
			s: detachable READABLE_STRING_32
		do
			if attached {WIZARD_PAGE_TEXT_ITEM} a_item as txt then
				localized_print (txt.text)
				localized_print ("%N")
			elseif attached {WIZARD_QUESTION} a_item then
				localized_print (" -> ")
				if attached {WIZARD_BOOLEAN_QUESTION} a_item as l_bool_question then
					l_bool_question.set_value (boolean_question (l_bool_question.title, <<["y", True], ["n", False]>>, l_bool_question.value))
				elseif attached {WIZARD_INTEGER_QUESTION} a_item as l_integer_question then
					l_integer_question.set_text (string_question (l_integer_question.title, Void, l_integer_question.text, False))
				elseif attached {WIZARD_STRING_QUESTION} a_item as l_string_question then
					l_string_question.set_value (string_question (l_string_question.title, Void, l_string_question.text, False))
				elseif attached {WIZARD_DIRECTORY_QUESTION} a_item as l_directory_question then
					l_directory_question.set_text (string_question (l_directory_question.title, Void, l_directory_question.text, False))
				end
			end
		end

feature {NONE} -- Implementation

	boolean_question (m: READABLE_STRING_GENERAL; a_options: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: BOOLEAN]]; a_default: BOOLEAN): BOOLEAN
		local
			s: STRING_32
			def: detachable STRING_32
			l_answered: BOOLEAN
			l_options: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: BOOLEAN]]
		do
			if l_options = Void then
				l_options := a_options
			end
			if l_options = Void then
				l_options := <<["y", True], ["Y", True]>>
			end
			across
				l_options as ic
			until
				def /= Void
			loop
				if a_default = ic.item.value then
					def := ic.item.name
				end
			end

			from
			until
				l_answered
			loop
				localized_print (m)
				localized_print (" ")

				create s.make_empty
				across
					l_options as ic
				loop
					if not s.is_empty then
						s.append_character (',')
					end
					s.append_string_general (ic.item.name)
				end
				localized_print (" (")
				localized_print (s)
				localized_print (") ")

				if def /= Void then
					localized_print ("[default=")
					localized_print (def)
					localized_print ("] ")
				end

				localized_print ("?")
				io.read_line
				s := io.last_string
				s.left_adjust
				s.right_adjust
				if s.is_empty and def /= Void then
					create s.make_from_string_general (def)
				end
				if not s.is_empty then
					across
						l_options as o
					until
						l_answered
					loop
						if o.item.name.same_string (s) then
							l_answered := True
							Result := o.item.value
						end
					end
					if not l_answered then
						l_answered := True
						Result := False
					end
				end
			end
		end

	string_question (m: READABLE_STRING_GENERAL; a_options: detachable ITERABLE [TUPLE [name: READABLE_STRING_8; value: detachable READABLE_STRING_8]]; def: detachable READABLE_STRING_GENERAL; a_required_valid_option: BOOLEAN): detachable STRING_32
		local
			s: STRING_32
			l_answered: BOOLEAN
		do
			from
			until
				l_answered
			loop
				localized_print (m)
				localized_print (" ")
				create s.make_empty
				if a_options /= Void then
					across
						a_options as ic
					loop
						if not s.is_empty then
							s.append_character (',')
						end
						s.append_string_general (ic.item.name)
						if attached ic.item.value as v then
							s.append_character ('=')
							s.append_string_general (v)
						end
					end
					localized_print ("(")
					localized_print (s)
					localized_print (") ")
				end
				if def /= Void then
					localized_print ("[default=")
					localized_print (def)
					localized_print ("] ")
				end

				localized_print ("?")
				io.read_line
				create s.make_from_string_general (io.last_string)
				s.left_adjust
				s.right_adjust
				if s.is_empty and def /= Void then
					create s.make_from_string_general (def)
				end
				if not s.is_empty then
					if a_options /= Void then
						across
							a_options as o
						until
							l_answered
						loop
							if o.item.name.same_string (s) then
								l_answered := True
								if attached o.item.value as l_value then
									create Result.make_from_string_general (l_value)
								else
									Result := Void
								end
							end
						end
					end
					if not l_answered then
						l_answered := True
						Result := s
						if
							a_required_valid_option and then
							a_options /= Void and then
							not across a_options as o some attached o.item.value as v and then Result.same_string (v) end
						then
							l_answered := False
							Result := Void
						end
					end
				end
			end
		end


end

note
	description : "[
			This example demonstrates the use of the `wsf_html` library for web form handling.

			To simplify the code, it is also using the `WSF_RESPONSE.send (WSF_RESPONSE_MESSAGE)`,
			thus no need to write the expected http header here.

			The current code is a web interface form, returning html page as response.
					
			notes:
			* It is not using the `WSF_ROUTER` component to keep the example as simple as possible.
			* It is also possible to use the `WSF_REQUEST.form_parameter (...)` directly, 
				  but WSF_FORM provides advanced processing.
			* For a CRUD REST API, you can also use `WSF_FORM` to analyze the incoming POST values, 
				  however the html generation may be too verbose for a simple REST api.
				  
			warning: depending on your system and connector, you may need to use `WSF_REQUEST.set_uploaded_file_path (...)`
					to tell the server where to store the temporary uploaded files.
					(this should be a directory with write permission for the server).
					For that
						- inherit from WSF_REQUEST_EXPORTER
						- in `execute` add at the beginning the call `request.set_uploaded_file_path (path-to-wanted-directory)` 

		]"
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_EXECUTION

inherit
	WSF_EXECUTION
	
create
	make

feature -- Basic operations

	execute
		local
			msg: WSF_RESPONSE_MESSAGE
 		do
 			if request.path_info.same_string ("/form") then
 				if request.is_post_request_method then
	 				msg := form_submission_message
	 			elseif request.is_get_request_method then
	 				msg := form_message
				else
					create {WSF_METHOD_NOT_ALLOWED_RESPONSE} msg.make (request)
 				end
 			else
				msg := welcome_message --| Alternative: return a not found message.
 			end
 			response.send (msg)
		end

	welcome_message: WSF_HTML_PAGE_RESPONSE
		local
			l_html: STRING
		do
			Result := new_html_page_message ("Welcome")

			create l_html.make_empty
			l_html.append ("<h1>Welcome</h1>%N")
			l_html.append ("<p>Please <a href=%"" + request.script_url ("form") + "%">fill this form</a>.</p>")
			Result.set_body (l_html)
		end

	form_message: WSF_HTML_PAGE_RESPONSE
		local
			f: WSF_FORM
			l_html: STRING
		do
			Result := new_html_page_message ("Form")
			create l_html.make_empty
			l_html.append ("<h1>Fill the form</h1>%N")

				-- Build the Web form, and then generate the html into `l_html`
			f := new_form
			f.append_to_html (wsf_theme, l_html)
			Result.set_body (l_html)
		end

	form_submission_message: WSF_HTML_PAGE_RESPONSE
		local
			f: WSF_FORM
			l_html: STRING
		do
			create l_html.make_empty
			Result := new_html_page_message ("Form")

				-- Build the empty Web form
			f := new_form
				-- And fill it using the `request: WSF_REQUEST` object.
			f.process (request, Void, Void)
				-- Get the filled analyzed data from `f.last_data: WSF_FORM_DATA`
			if attached f.last_data as fd then
				if attached fd.errors as lst then
						-- The web form has validation errors
					l_html.append ("<h1>Fill the form</h1>%N")

					fd.apply_to_associated_form
					across
						lst as ic
					loop
						if attached {WSF_FORM_FIELD} ic.item.field as l_field then
							l_html.append ("<li>ERROR on field [" + l_field.name + "]</li>")
						end
					end
					f.append_to_html (wsf_theme, l_html)
				elseif
					attached fd.string_item (field_id_uuid) as l_uuid and then
					attached fd.string_item (field_id_first_name) as l_firstname and then
					attached fd.string_item (field_id_last_name) as l_lastname

				then
						-- No validation errors
						-- and we have the expected values.

					check
							-- see `set_is_required (True)` in `new_form`.
						required_value_set: not l_firstname.is_whitespace and not l_lastname.is_whitespace
					end
						--| Process the value to store in database, or anything ...
						--| here, we just display the value in the page.
					l_html.append ("<h1>Form: results</h1>")
					l_html.append ("<p>Thank you %"" + l_firstname + " " + l_lastname + "%" for your submission ("+ l_uuid.as_string_8 +").</p>")
					l_html.append ("<ul>")
						-- Use the html encoder to append the firstname and lastname that could be unicode or contain reserved html characters.

						-- Required values.
					l_html.append ("<li>first name: " + Result.html_encoded_string (l_firstname) + "</li>")
					l_html.append ("<li>last name: " + Result.html_encoded_string (l_lastname) + "</li>")

						-- Optional values
					if attached fd.string_item (field_id_birthday) as l_birthday and then not l_birthday.is_whitespace then
						l_html.append ("<li>birthday: " + l_birthday + "</li>")
					end
					if attached fd.string_item (field_id_email) as l_email and then not l_email.is_whitespace then
						l_html.append ("<li>email: " + l_email + "</li>")
					end
					if attached fd.string_item (field_id_priority) as l_priority then
						l_html.append ("<li>priority: " + l_priority.to_string_8 + "</li>")
					end
					if attached fd.table_item (field_id_tags) as l_tags then
						l_html.append ("<li>tags: ")
						across
							l_tags as ic
						loop
							if attached {WSF_STRING} ic.item as p_tag then
								l_html.append (Result.html_encoded_string (p_tag.value))
								l_html.append (" ")
							end
						end
						l_html.append ("</li>")
					end
					if attached fd.string_item (field_id_month) as l_month then
						l_html.append ("<li>month: " + Result.html_encoded_string (l_month) + "</li>")
					end
					if attached fd.string_item (field_id_comment) as l_comment then
						l_html.append ("<li>comment: <pre>" + Result.html_encoded_string (l_comment) + "</li>")
					end

						-- WARNING for uploaded file, the form will send the file content only if
						-- `{WSF_FORM}.set_multipart_form_data_encoding_type` is used.
						-- otherwise we get only the "filename"...
					if attached {WSF_UPLOADED_FILE} fd.item (field_id_attached_file) as l_uploaded_file then
						l_html.append ("<li>Attached file %"" + Result.html_encoded_string (l_uploaded_file.filename) + "%" (size=" + l_uploaded_file.size.out + ") ")
						if attached l_uploaded_file.tmp_path as l_tmp_path then
							l_html.append (" saved as %"")
							l_html.append (Result.html_encoded_string (l_tmp_path.name))
							l_html.append ("%"")
						end
						l_html.append ("</li>")
					elseif attached fd.string_item (field_id_attached_file) as l_file then
						l_html.append ("<li>Attached file %"" + Result.html_encoded_string (l_file) + "%".</li>")
					end

					l_html.append ("</ul>")
					save_form_results (l_uuid, fd)

					l_html.append ("<p>Fill again a <a href=%"" + request.script_url ("form") + "%">new form</a>.</p>")
				else
					l_html.append ("<h1>Fill the form</h1>%N")
						-- Missing form value!
					fd.apply_to_associated_form
					l_html.append ("<li>ERROR: missing at least one field value !</li>")
					f.append_to_html (wsf_theme, l_html)
				end
			end
			Result.set_body (l_html)
		end

feature -- Implementation

	new_html_page_message (a_title: READABLE_STRING_32): WSF_HTML_PAGE_RESPONSE
		do
			create Result.make
				-- The following style is in this example embedded, however for bigger style, it would be recommended to include the css style as a url.
			Result.head_lines.extend ("[
					<style>
						body { margin: 10px; padding: 10px; }
						form>fieldset {	width: 50%; }
						div.error { background-color: #fee; }
						.horizontal > * { padding-right: 10px; display: inline-block; }
					</style>
				]")
			Result.set_title (a_title)
		end

	new_form: WSF_FORM
			-- New form object.
		local
			l_set: WSF_FORM_FIELD_SET
			l_div: WSF_FORM_DIV
			l_hidden: WSF_FORM_HIDDEN_INPUT
			l_text_field: WSF_FORM_TEXT_INPUT
			l_birthday_field: WSF_FORM_DATE_INPUT
			l_email_field: WSF_FORM_EMAIL_INPUT
			l_submit: WSF_FORM_SUBMIT_INPUT
			l_radio: WSF_FORM_RADIO_INPUT
			l_checkbox: WSF_FORM_CHECKBOX_INPUT
			l_textarea_field: WSF_FORM_TEXTAREA
			l_file_field: WSF_FORM_FILE_INPUT
			l_select: WSF_FORM_SELECT
			l_select_opt: WSF_FORM_SELECT_OPTION
		do
			create Result.make ("/form", "a-form-id")
			Result.set_method_post
			Result.set_multipart_form_data_encoding_type

			create l_hidden.make_with_text (field_id_uuid, (create {UUID_GENERATOR}).generate_uuid.out)
			Result.extend (l_hidden)

			create l_set.make
			l_set.set_legend ("Personal information")
			Result.extend (l_set)

			create l_div.make
			l_div.add_css_class ("horizontal")
			l_set.extend (l_div)

				-- First name
			create l_text_field.make (field_id_first_name)
			l_text_field.set_label ("First name")
			l_text_field.set_placeholder ("Enter your first name")
			l_text_field.set_size (60)
			l_text_field.set_is_required (True)
			l_set.extend (l_text_field)

				-- Last name
			create l_text_field.make (field_id_last_name)
			l_text_field.set_label ("Last name")
			l_text_field.set_placeholder ("Enter your last name")
			l_text_field.set_size (60)
			l_text_field.set_is_required (True)
			l_set.extend (l_text_field)

				-- Birthday
			create l_birthday_field.make (field_id_birthday)
			l_birthday_field.set_label ("Birthday")
			l_birthday_field.set_placeholder ("YYYY-MM-DD")
			l_birthday_field.set_description ("Enter the date using the YYYY-MM-DD format.")
			l_birthday_field.set_validation_action (agent (fd: WSF_FORM_DATA)
					do
						if attached fd.string_item (field_id_birthday) as str then
							if is_valid_yyyy_mm_dd_date (str) then
									-- Ok
							else
								fd.report_invalid_field (field_id_birthday, "Invalid date format!")
							end
						end
					end)
			l_set.extend (l_birthday_field)

				-- Contact information
			create l_set.make
			l_set.set_legend ("Contact information")
			Result.extend (l_set)

				-- Email
			create l_email_field.make (field_id_email)
			l_email_field.set_label ("Primary email")
			l_set.extend (l_email_field)

			create l_div.make
			l_div.add_css_class ("horizontal") -- See the css style, this is a way to have simple column layout in form
			Result.extend (l_div)

				-- Radio
			create l_set.make
			l_set.set_legend ("Priority")
			l_div.extend (l_set)

			create l_radio.make_with_value (field_id_priority, "high")
			l_radio.set_label ("High")
			l_set.extend (l_radio)
			create l_radio.make_with_value (field_id_priority, "medium")
			l_radio.set_label ("Medium")
			l_set.extend (l_radio)
			create l_radio.make_with_value (field_id_priority, "low")
			l_radio.set_label ("Low")
			l_set.extend (l_radio)

				-- checkbox
			create l_set.make
			l_set.set_legend ("Tags")
			l_set.add_css_class ("horizontal")
			l_div.extend (l_set)

			create l_checkbox.make_with_value (field_id_tags + "[]", "application")
			l_checkbox.set_label ("Application")
			l_set.extend (l_checkbox)
			create l_checkbox.make_with_value (field_id_tags + "[]", "library")
			l_checkbox.set_label ("Library")
			l_set.extend (l_checkbox)
			create l_checkbox.make_with_value (field_id_tags + "[]", "testing")
			l_checkbox.set_label ("Testing")
			l_set.extend (l_checkbox)

				-- select
			create l_set.make
			l_div.extend (l_set)
			create l_select.make (field_id_month)
			l_select.set_label ("Choose a month")
			l_set.extend (l_select)

			create l_select_opt.make ("01", "January"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("02", "February"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("03", "March"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("04", "April"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("05", "May"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("06", "June"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("07", "July"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("08", "August"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("09", "September"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("10", "October"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("11", "November"); l_select.add_option (l_select_opt)
			create l_select_opt.make ("12", "December"); l_select.add_option (l_select_opt)

				-- Note

			create l_textarea_field.make (field_id_comment)
			l_textarea_field.set_label ("Post your comment")
			l_textarea_field.set_cols (60)
			l_textarea_field.set_rows (10)
			l_textarea_field.set_description ("Please leave a comment ...")
			Result.extend (l_textarea_field)


				-- File
			create l_file_field.make (field_id_attached_file)
			l_file_field.set_label ("Attach a file")
			Result.extend (l_file_field)

			create l_submit.make_with_text ("op", "Submit")
			Result.extend (l_submit)
		end

feature -- Constants

	field_id_uuid: STRING = "uuid"
	field_id_first_name: STRING = "first_name"
	field_id_last_name: STRING = "last_name"
	field_id_birthday: STRING = "birthday"
	field_id_email: STRING = "email"
	field_id_priority: STRING = "priority"
	field_id_tags: STRING = "tags"
	field_id_month: STRING = "month"
	field_id_comment: STRING = "comment"
	field_id_attached_file: STRING = "attached_file"

feature {NONE} -- Helpers	

	save_form_uploaded_file (a_uuid: READABLE_STRING_GENERAL; a_file: WSF_UPLOADED_FILE)
		local
			p: PATH
			d: DIRECTORY
		do
			p := (create {PATH}.make_current).extended ("forms").extended (a_uuid).extended ("files")
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			p := p.extended (a_file.safe_filename)
			if a_file.move_to (p.name) then
					-- Ok file, saved.
			else
					-- Failed to move the uploaded file!
			end
		end

	save_form_results (a_uuid: READABLE_STRING_GENERAL; fd: WSF_FORM_DATA)
		local
			p: PATH
			d: DIRECTORY
			f: PLAIN_TEXT_FILE
			conv: UTF_CONVERTER
			l_is_first: BOOLEAN
		do
			p := (create {PATH}.make_current).extended ("forms").extended (a_uuid)
			create d.make_with_path (p)
			if not d.exists then
				d.recursive_create_dir
			end
			create f.make_with_path (p.extended ("results.json"))
			if not f.exists or f.is_access_writable then
				f.create_read_write
				l_is_first := True
				f.put_character ('{')
				across
					fd as ic
				loop
					if l_is_first then
						l_is_first := False
					else
						f.put_character (',')
					end
					f.put_character ('"')
					f.put_string (conv.utf_32_string_to_utf_8_string_8 (ic.key))
					f.put_character ('"')
					f.put_character (':')
					if attached ic.item as obj then
						save_value_as_json_string (obj, f, a_uuid)
					else
						f.put_string ("Null")
					end
				end
				f.put_character ('}')
				f.close
			end
		end

	save_value_as_json_string (obj: ANY; a_file: FILE; a_uuid: READABLE_STRING_GENERAL)
			-- Pseudo json serialization.
			-- Suggestion: use the Eiffel json library for standard.
		local
			conv: UTF_CONVERTER
			s: STRING
			l_is_first: BOOLEAN
		do
			if attached {WSF_STRING} obj as str then
				s := conv.utf_32_string_to_utf_8_string_8 (str.value)
				s.prune_all ('%R')
				s.replace_substring_all ("%N", "\n")
				s.replace_substring_all ("'", "\'")
				a_file.put_character ('"')
				a_file.put_string (s)
				a_file.put_character ('"')
			elseif attached {WSF_UPLOADED_FILE} obj as fup then
				save_form_uploaded_file (a_uuid, fup)
				a_file.put_character ('"')
				a_file.put_string (conv.utf_32_string_to_utf_8_string_8 (fup.safe_filename))
				a_file.put_character ('"')
			elseif attached {WSF_TABLE} obj as tb then
				a_file.put_character ('{')
				l_is_first := True
				across
					tb as tb_ic
				loop
					if l_is_first then
						l_is_first := False
					else
						a_file.put_character (',')
					end
					a_file.put_character ('"')
					a_file.put_string (conv.utf_32_string_to_utf_8_string_8 (tb_ic.key))
					a_file.put_character ('"')
					a_file.put_character (':')
					save_value_as_json_string (tb_ic.item, a_file, a_uuid)
				end
				a_file.put_character ('}')
			end
		end

	wsf_theme: WSF_THEME
		do
			create {WSF_REQUEST_THEME} Result.make_with_request (request)
		end

	is_valid_yyyy_mm_dd_date (a_date: READABLE_STRING_GENERAL): BOOLEAN
		local
			i,j: INTEGER
			y,m,d: INTEGER
			str: STRING_32
			s: STRING_32
		do
			create str.make_from_string_general (a_date)
			str.left_adjust
			str.right_adjust
			Result := False
			i := 1
				-- YYYY-MM-DD
			j := str.index_of ('-', i)
			if j > i then
				s := str.substring (i, j - 1)
				if s.is_integer then
					y := s.to_integer
					i := j + 1
						-- MM-DD
					j := str.index_of ('-', i)
					if j > i then
						s := str.substring (i, j - 1)
						if s.is_integer then
							m := s.to_integer
							if 1 <= m and m <= 12 then
								i := j + 1
									-- DD
								s := str.substring (i, str.count)
								if s.is_integer then
									d := s.to_integer
									if 1 <= d and d <= 31 then
											-- This is just a basic validation.
										Result := True
									end
								end
							end
						end
					end
				end
			end
		end
end

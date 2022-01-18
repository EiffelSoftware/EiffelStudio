note
	description: "HTML output of verification."

class
	E2B_HTML_OUTPUT

inherit

	OUTPUT_WINDOW
		redefine
			add_class,
			add_feature,
			add_manifest_string
		end

feature

	print_header
			-- Print header of output.
		do
			open_style ("table", table_style)

			open ("thead")
			open_style ("tr", tr_header_style)
			open ("th")
			add ("Feature")
			close ("th")
			open ("th")
			add ("Line")
			close ("th")
			open ("th")
			add ("Result")
			close ("th")
			close ("tr")
			close ("thead")
			open ("tbody")
		end

	print_footer
			-- Print footer of output.
		do
			close ("tbody")
			close ("table")
		end

	print_verification_result (r: E2B_RESULT)
			-- Print `r' in HTML format.
		do
			across r.verification_results as i loop
				if attached {E2B_SUCCESSFUL_VERIFICATION} i as l_success then
					if l_success.original_errors /= Void and then not l_success.original_errors.is_empty then
						open_style ("tr", tr_twostep_style)
					else
						open_style ("tr", tr_success_style)
					end
					print_successful_verification (l_success)
				elseif attached {E2B_INCONCLUSIVE_RESULT} i as l_inconclusive then
					open_style ("tr", tr_failed_style)
					print_inconclusive_result (l_inconclusive)
				elseif attached {E2B_FAILED_VERIFICATION} i as l_failure then
					open_style ("tr", tr_failed_style)
					print_failed_verification (l_failure)
				elseif attached {E2B_AUTOPROOF_ERROR} i as l_error then
					open_style ("tr", tr_error_style)
					print_autoproof_error (l_error)
				else
					check internal_error: False end
				end
				close ("tr")
			end
		end

	print_successful_verification (a_success: E2B_SUCCESSFUL_VERIFICATION)
			-- Print successful verification information.
		do
			print_feature_information (a_success)
			open_style ("td", td_line_style)
			close ("td")
			open_style ("td", td_info_style)
			if a_success.original_errors = Void or else a_success.original_errors.is_empty then
				add ("Successfully verified.")
				add_new_line
			else
					-- Two-step verification result
				add ("Successfully verified after inlining.")
				add_new_line
				if a_success.suggestion /= Void then
					add (a_success.suggestion)
					add_new_line
				end
				add ("Original errors:")
				add_new_line
				across a_success.original_errors as i loop
					if @ i.cursor_index = 1 then
						add_new_line
					else
						add ("--------------------------------------")
						add_new_line
					end
					i.multi_line_message (Current)
					add_new_line
				end
			end
			close ("td")
		end

	print_failed_verification (a_failure: E2B_FAILED_VERIFICATION)
			-- Print failed verifcation information.
		do
			if a_failure.errors.is_empty then
				print_feature_information (a_failure)
				open_style ("td", td_line_style)
				close ("td")
				open_style ("td", td_info_style)
				close ("td")
			else
				across a_failure.errors as i loop
					if @ i.cursor_index = 1 then
						print_feature_information (a_failure)
					else
						close ("tr")
						open_style ("tr", tr_failed_style)
						open_style ("td", td_name_style)
						close ("td")
					end
					open_style ("td", td_line_style)
					if i.context_line_number > 0 then
						add (i.context_line_number.out)
					end
					close ("td")
					open_style ("td", td_info_style)
					i.single_line_message (Current)
					close ("td")
				end
			end
		end

	print_inconclusive_result (a_inconclusive: E2B_INCONCLUSIVE_RESULT)
			-- Print failed verifcation information.
		do
			print_feature_information (a_inconclusive)
			open_style ("td", td_line_style)
			close ("td")
			open_style ("td", td_info_style)
			add ("Inconclusive result (verifier timed out).")
			close ("td")
		end

	print_autoproof_error (a_error: E2B_AUTOPROOF_ERROR)
			-- Print failed verifcation information.
		do
			print_feature_information (a_error)
			open_style ("td", td_line_style)
			if a_error.context_line_number > 0 then
				add (a_error.context_line_number.out)
			end
			close ("td")
			open_style ("td", td_info_style)
			add (a_error.type)
			add (": ")
			a_error.single_line_message (Current)
			close ("td")
		end

	print_feature_information (a_proc: E2B_VERIFICATION_RESULT)
			-- Print feature information.
		local
			l_context: STRING
		do
			open_style ("td", td_name_style)
			open ("strong")
			if attached a_proc.context_class then
				add_class (a_proc.context_class.original_class)
			end
			if attached a_proc.context_feature then
				add (".")
				add_feature (a_proc.context_feature.e_feature, a_proc.context_feature.feature_name_32)
			end
			if attached a_proc.verification_context then
				add ("&nbsp;(")
				l_context := a_proc.verification_context.twin
				l_context.replace_substring_all (" ", "&nbsp;")
				add (l_context)
				add (")")
			end
			close ("strong")
			close ("td")
		end

	put_new_line
			-- <Precursor>
		do
			io.put_string ("<br/>")
			io.put_new_line
		end

	put_string (s: READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			t: UTF_CONVERTER
			s8: STRING_8
		do
			s8 := t.string_32_to_utf_8_string_8 (s.as_string_32)
			s8.replace_substring_all ("<", "&lt;")
			s8.replace_substring_all (">", "&gt;")
			s8.replace_substring_all ("%"", "&quot;")
			s8.replace_substring_all ("%N", "<br/>")
			io.put_string (s8)
		end

	put_string_no_encoding (s: STRING)
		do
			io.put_string (s)
		end

	open (a_tag: STRING)
			-- Open `a_tag'.
		do
			put_string_no_encoding ("<" + a_tag + ">")
		end

	open_style (a_tag: STRING; a_style: STRING)
			-- Open `a_tag'.
		do
			put_string_no_encoding ("<" + a_tag + " style=%"" + a_style + "%">")
		end

	close (a_tag: STRING)
			-- Close `a_tag'.
		do
			put_string_no_encoding ("</" + a_tag + ">")
		end

	add_class (class_i: CLASS_I)
		do
			open_style ("span", "color:blue")
			put_string (class_i.name.as_upper)
			close ("span")
		end

	add_feature (feat: E_FEATURE; str: READABLE_STRING_GENERAL)
		do
			open_style ("span", "color:green")
			put_string (str)
			close ("span")
		end

	add_manifest_string (s: READABLE_STRING_GENERAL)
		do
			open_style ("span", "color:orange")
			put_string (s)
			close("span")
		end

feature -- Styles

	table_style: STRING = "width:100%%"
	tr_header_style: STRING = "background-color:black;color:white"
	tr_success_style: STRING = "background-color: #dfd"
	tr_twostep_style: STRING = "background-color:#def"
	tr_failed_style: STRING = "background-color:#fdd"
	tr_error_style: STRING = "background-color:#ffd"
	td_name_style: STRING = "padding: 5px; padding-right:15px"
	td_line_style: STRING = "padding: 5px"
	td_info_style: STRING = "width: 100%%"

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2013-2014 ETH Zurich",
		"Copyright (c) 2018 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end

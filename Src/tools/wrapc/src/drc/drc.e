indexing

	description:

		"Application that explains C declarations in plain (err HTML) English"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class DRC

inherit

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	EPX_CGI
		rename
			make as make_epx_cgi
		end

create

	make

feature

	make is
			-- Create new EWG command line tool
		local
			drc_xhtml_writer: DRC_XHTML_WRITER
		do
			create error_handler.make
			create drc_xhtml_writer.make (Current)
			create drc_processor.make (drc_xhtml_writer)
			c_system.set_declaration_processor (drc_processor)
			create c_parser.make (error_handler)
			create log_handler.make (log_system_name)
			create logger.make (log_handler, log_system_name)

			source_code := default_source_code
			make_epx_cgi
		end

	execute is
		do
			read_submitted_values
			if is_msc_extension_enabled then
				c_parser.enable_msc_extensions
			end

			logger.log_single_field (logger.Usage, log_sub_system_name, "c-source-code-to-explain", source_code)
			execute_source_code_validator
			execute_preprocessor
			content_text_html
			doctype
			b_html
			generate_header
			generate_body
			e_html
		end

	read_submitted_values is
		do
			assert_key_value_pairs_created
			if has_key (source_code_text_area_name) then
				source_code := raw_value (source_code_text_area_name)
			end
			if has_key (msc_extension_check_box_name) then
				is_msc_extension_enabled := STRING_.same_string (value(msc_extension_check_box_name), enabled_name)
			end
		end

	generate_header is
		do
			b_head
			title ("Doctor C")
			style_sheet (style_sheet_url, Void, Void)
			new_line

			start_tag ("script")
			set_attribute ("type", "text/javascript")
			set_attribute ("src", explain_javascript_url)
			puts (" ")
			stop_tag
			new_line
			e_head
		end

	generate_body is
		do
			b_body
			generate_lead_in_explanation
			generate_form
			generate_validity_warning
			generate_lead_out
			generate_explanation
			e_body
		end

	generate_lead_in_explanation is
		do
			h1 ("Doctor C")

			b_p
			puts ("Doctor C can help you understand C code (to be precise: C declarations). ")
			puts ("Just type the C code you want to have explained into the")
			puts ("text area below and hit ")
			b_b
			puts ("submit")
			e_b
			puts (".")
			puts ("For more information please consider the following link:")
			e_p
			b_ul
			b_li
			a ("/drc/documentation.html", "Documentation")
			e_li
			e_ul
		end

	generate_lead_out is
		do
			b_p
			puts ("If you find any bugs please report them to ")
			a ("mailto:aleitner@raboof.at", "aleitner@raboof.at")
			puts (" (Andreas Leitner).")
			br
			puts ("Doctor C is a simple tool that has been written in ")
			a ("http://www.cetus-links.org/oo_eiffel.html", "Eiffel")
			puts (" using ")
			a ("http://ewg.sourceforge.net", "EWG")
			puts (". The source for Doctor C is included in ")
			a ("http://ewg.sourceforge.net", "EWG")
			puts (".")
			e_p
		end

	generate_form is
		do
			b_form_post (drc_url)
			b_table
			set_attribute ("border", "0")
			set_attribute ("cellpadding", "0")
			set_attribute ("cellspacing", "4")

			-- first row
			b_tr
			b_td
			puts ("Enter the C source code (")
			b_i
			puts ("declarations only!")
			e_i
			puts (") that you would like to get explained here:")
			e_td
			e_tr
			-- second row
			b_tr
			b_td
			b_textarea (source_code_text_area_name)
			set_attribute ("cols", "60")
			set_attribute ("rows", "5")
			puts (source_code)
			e_textarea
			e_td
			e_tr
			-- third row
			b_tr
			b_td
			b_checkbox (msc_extension_check_box_name, enabled_name)
			if is_msc_extension_enabled then
				set_attribute ("checked", "checked")
			end
			puts ("Enable Microsoft C extensions")
			e_checkbox
			e_td
			e_tr

			-- fourth row
			b_tr
			b_td
			button_submit ("submit", "Submit")
			nbsp
			button_reset
			e_td
			e_tr

			e_table
			e_form
		end

	execute_source_code_validator is
		local
			validator: DRC_C_CODE_VALIDATOR
			source_code_with_new_line: STRING
		do
			source_code_with_new_line := clone (source_code)
			source_code_with_new_line.append_string ("%R%N")
			source_code_validty_error_message := STRING_.make_empty
			create validator.make_from_string (source_code_with_new_line, source_code_validty_error_message)
			validator.run_process
			if source_code_validty_error_message.count > 0 then
				logger.log_message (logger.Usage, log_sub_system_name, "GCC had issues with the source")
			end
		end

	execute_preprocessor is
		local
			cpp: DRC_PREPROCESSOR
		do
			preprocesed_soure_code := STRING_.make_empty
			create cpp.make_from_string (source_code, preprocesed_soure_code)
			cpp.run_process
		end

	generate_validity_warning is
		require
			source_code_validty_error_message_not_void: source_code_validty_error_message /= Void
		do
			if source_code_validty_error_message.count > 0 then
				h2 ("Warning: gcc had to say the following about the above source code:")
				b_pre
				puts (source_code_validty_error_message)
				e_pre
			end
		end

	generate_explanation is
		require
			c_parser_not_void: c_parser /= Void
		local
			input: KL_STRING_INPUT_STREAM
		do
			create input.make (preprocesed_soure_code)
			error_handler.start_task ("parsing")
			error_handler.set_current_task_total_ticks (9999)

			h2 ("Here is what Doctor C has to say about the above matter:")
			c_parser.parse_buffer (input)
			error_handler.stop_task
			if c_parser.syntax_error then
				h2 ("Doctor C found syntax errors while parsing the source code!")
				logger.log_message (logger.Usage, log_sub_system_name, "EWG found syntax errors")
			end
		end

feature

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

	c_parser: EWG_C_PARSER
			-- c header parser

	drc_processor: DRC_PROCESSOR
			-- Vistor Pattern style processor that outputs English description of C AST

	source_code: STRING

	preprocesed_soure_code: STRING

	is_msc_extension_enabled: BOOLEAN

	logger: ULM_LOGGING

	log_handler: EPX_LOG_HANDLER

	source_code_validty_error_message: STRING

feature {NONE}

	log_sub_system_name: STRING is "ewg"

	log_system_name: STRING is "ewg"

	style_sheet_url: STRING is "/drc/styles/stylesheet.css"

	explain_javascript_url: STRING is "/drc/explain.js"

	drc_url: STRING is "/cgi-bin/drc"

	source_code_text_area_name: STRING is "source_code"

	default_source_code: STRING is "typedef void* foobar;"

	msc_extension_check_box_name: STRING is "is_msc_extension_enabled"

	enabled_name: STRING is "true"

end

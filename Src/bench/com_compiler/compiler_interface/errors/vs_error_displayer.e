indexing
	description: "Visual Studio Error Displayer."
	date: "$Date$"
	revision: "$Revision$"

class
	VS_ERROR_DISPLAYER

inherit
	DEFAULT_ERROR_DISPLAYER
		redefine
			trace_warnings,
			trace_errors
		end
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

create
	make_with_coclass

feature -- Initialization

	make_with_coclass (ow: like output_window; compiler: like compiler_coclass) is
			-- Initialize current with `output_window' to `ow'
		do
			output_window := ow
			compiler_coclass := compiler
		ensure
			set: ow = output_window
			compiler_set: compiler = compiler_coclass
		end

feature -- Property

	compiler_coclass: CEIFFEL_COMPILER_COCLASS
			-- Compiler coclass, where events are defined.

feature -- Output

	trace_warnings (handler: ERROR_HANDLER) is
			-- Display warnings messages from `handler'.
		local
			warning_list: LINKED_LIST [ERROR]
			warning: WARNING
		do
			if not retried then
				from
					warning_list := handler.warning_list
					warning_list.start
				until
					warning_list.after
				loop
					if display_warnings then
						warning ?= warning_list.item
						if warning /= Void then
							trace_warning (warning)
						end
					end
					warning_list.forth
				end
			else
				retried := False
			end
		rescue
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

	trace_errors (handler: ERROR_HANDLER) is
			-- Display error messages from `handler'.
		local
			error_list: LINKED_LIST [ERROR]
		do
			if not retried then
				from
					error_list := handler.error_list
					error_list.start
				until
					error_list.after

				loop
					trace_error (error_list.item)
					error_list.forth
				end
			else
				retried := False
			end
		rescue
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

feature {COMPILER} -- Compiler Implmentation

	display_warnings: BOOLEAN
			-- should all warnings be displayed?
	
	set_display_warnings (display: BOOLEAN) is
			-- set `display_warnings' to `display'
		do
			display_warnings := display
		ensure
			display_warnings_set: display_warnings = display
		end
		

feature {NONE} -- Implementation
	
	line_number (file_name: STRING; start_position: INTEGER): INTEGER is
			-- Calculate line number of the character in `start_position'.
		require
			non_void_file_name: file_name /= Void
			non_empty_file_name: not file_name.is_empty
		local
			file: RAW_FILE
			string: STRING
			i: INTEGER
		do
			create file.make (file_name)
			if file.exists then
				file.open_read
				file.start
				file.read_stream (start_position)
				string := file.last_string
				from
					i := 1
					Result := 1 -- This is because the last %N is never included.
				until
					i > start_position
				loop
					if string.item (i) = '%N' then
						Result := Result + 1
					end
					i := i + 1
				end
			end
		end
		
	trace_warning (warn: WARNING) is
			-- sends formatted `warn' to output
		require
			non_void_warn: warn /= Void
			non_void_compiler_coclass: compiler_coclass /= Void
		local
			obs_class: OBS_CLASS_WARN
			obs_feat: OBS_FEAT_WARN
			syn_warn: SYNTAX_WARNING
			unused_warn: UNUSED_LOCAL_WARNING
			full_error: STRING
			short_error: STRING
			file_name: STRING
			line_pos: INTEGER
			sf: STRING_FORMATTER
			st: STRUCTURED_TEXT
		do
			if warn.error_string.is_empty then
				create st.make
				warn.build_explain (st)
				create sf.make
				sf.process_text (st)
				full_error := sf.output
			else
				full_error := warn.error_string
			end

			unused_warn ?= warn
			if unused_warn /= Void then
				-- Unused local
				file_name := unused_warn.associated_feature.associated_class.file_name
				line_pos := unused_warn.associated_feature.ast.location.line_number
				short_error := "Warning: '" + unused_warn.associated_local + "' is declared but never used in feature '" + unused_warn.associated_feature.name + "'."
			else
				obs_feat ?= warn
				if obs_feat /= Void then
					-- Call to obsolete feature 
					file_name := obs_feat.a_feature.written_class.file_name
					line_pos := obs_feat.a_feature.ast.location.line_number
					short_error := "Warning: Feature '" + obs_feat.obsolete_feature.name + "' from '" +  
						obs_feat.obsolete_feature.written_class.name + "' is obsolete: '" + 
						obs_feat.obsolete_feature.obsolete_message + "'."
				else 
					obs_class ?= warn
					if obs_class /= Void then
						-- Using obsolete class
						file_name := obs_class.associated_class.file_name
						line_pos := obs_class.associated_class.ast.line_number
						short_error := "Warning: Class '" + obs_class.obsolete_class.name + "' is obsolete: '" + 
							obs_class.obsolete_class.obsolete_message + "'."
					else
						syn_warn ?= warn
						if syn_warn /= Void then
							-- Syntax warning
							file_name := syn_warn.file_name
							line_pos := syn_warn.line_number
							short_error := "Warning: " + syn_warn.warning_message
						else
							short_error := "Warning: " + clone (full_error)
						end
					end
				end
			end
			check
				non_void_full_error: full_error /= Void
				non_void_short_error: short_error /= Void
			end
			compiler_coclass.event_output_warning (full_error, short_error, warn.code, file_name, line_pos, 0)
		end

	trace_error (err: ERROR) is
			-- Send formatted `err' to output
		require
			non_void_err: err /= Void
			non_void_compiler_coclass: compiler_coclass /= Void
		local
			eif_err: EIFFEL_ERROR
			syn_err: SYNTAX_ERROR
			feat_err: FEATURE_ERROR
			interrupt_err: INTERRUPT_ERROR
			special_err: SPECIAL_ERROR
			full_error: STRING
			short_error: STRING
			file_name: STRING
			line_pos: INTEGER
			sf: STRING_FORMATTER
			st: STRUCTURED_TEXT
		do
			load_error_help_file (err)
			if last_help_file_text /= Void then
				full_error := last_help_file_text
			else
				create full_error.make_empty
			end
				
			if err.error_string.is_empty or err.error_string.is_equal ("Error") then
				-- load help file and add text to begining of error definition			
				special_err ?= err
				if special_err /= Void then
					full_error.append (special_err.error_case)
				else
					create st.make
					err.build_explain (st)
					create sf.make
					sf.process_text (st)
					full_error.append (sf.output)
				end
			else
				full_error.append (err.error_string)
			end
			
			eif_err ?= err
			if eif_err /= Void then
				feat_err ?= err
				if feat_err /= Void then
					-- Feature error
					file_name := feat_err.e_feature.written_class.file_name
					line_pos := feat_Err.line_number
					if not feat_err.error_string.is_empty then
						short_error := "Error: " + feat_err.error_string
					end
				else
					file_name := eif_err.class_c.file_name
					short_error := clone (full_error)
				end
			else
				interrupt_err ?= err
				if interrupt_err /= Void then
					short_error := "Compilation interrupted and halted."
				else
					syn_err ?= err
					if syn_err /= Void then
						-- Syntax error
						file_name := syn_err.file_name
						line_pos := syn_err.line_number
						short_error := "Error: " + syn_err.error_message
					else
						short_error := "Error: " + clone (full_error)
					end
				end
			end
			check
				non_void_full_error: full_error /= Void
				non_void_short_error: short_error /= Void
			end
			compiler_coclass.event_output_error (full_error, short_error, err.code, file_name, line_pos, 0)
		end
		
	load_error_help_file (err: ERROR) is
			-- loads error help file assoicated with `err' and sets `last_help_file_text'.
		require
			non_void_error: err /= Void
		local
			file_name: STRING
			help_file: PLAIN_TEXT_FILE
			eiffel_env: EIFFEL_ENV
		do
			last_help_file_text := Void
			
			check
				non_void_help_file_name: err.help_file_name /= Void
				valid_help_file_name: not err.help_file_name.is_empty
			end
			
			create eiffel_env
			file_name := eiffel_env.help_path.out
			file_name.append ("\short\" + err.help_file_name)
			
			create help_file.make (file_name)
			if help_file.exists then
				help_file.open_read
				from
					create last_help_file_text.make_empty
				until
					help_file.end_of_file
				loop
					help_file.read_line
					if not help_file.end_of_file then
						last_help_file_text.append (help_file.last_string + "%N")
					end
				end
			end
		end
		
	last_help_file_text: STRING
			-- text of last read help file
		
		
end -- class VS_ERROR_DISPLAYER

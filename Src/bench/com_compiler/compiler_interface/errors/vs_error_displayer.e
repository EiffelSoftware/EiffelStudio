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
			st: STRUCTURED_TEXT
			warning: WARNING
			obs_class_warning: OBS_CLASS_WARN
			obs_feat_warning: OBS_FEAT_WARN
			unused_local_warning: UNUSED_LOCAL_WARNING
			line_pos: INTEGER
			col_pos: INTEGER
			warning_file: STRING
			warning_string: STRING
			short_warning: STRING
		do
			if not retried then
				from
					create st.make
					warning_list := handler.warning_list
					warning_list.start
				until
					warning_list.after
				loop
					warning_file := Void
					line_pos := 0
					col_pos := 0
					
					-- Discover type of warning
					obs_class_warning ?= warning_list.item
					unused_local_warning ?= warning_list.item
					warning ?= warning_list.item

					if warning /= Void then
						-- not a real warning
						create st.make
						warning.trace (st)
						warning_string := st.image						
					
						if obs_class_warning /= Void then
							-- Obsolete class/feature warning
							warning_file := obs_class_warning.obsolete_class.file_name
							obs_feat_warning ?= obs_class_warning
							if obs_feat_warning /= Void then
								-- Obsolete feature
								line_pos := obs_feat_warning.a_feature.ast.location.line_number
								col_pos := obs_feat_warning.a_feature.ast.location.start_column_position
								short_warning := "Feature '" + obs_feat_warning.obsolete_feature.name + "' from '" +  
									obs_feat_warning.obsolete_feature.associated_class.name + "' is obsolete: '" + 
									obs_feat_warning.obsolete_feature.obsolete_message + "'."
							else
								-- Obsolete class
								line_pos := obs_class_warning.associated_class.ast.line_number
								short_warning := "Class '" + obs_class_warning.obsolete_class.name + "' is obsolete: '" + 
									obs_class_warning.obsolete_class.obsolete_message + "'."
							end
						elseif unused_local_warning /= Void then
							warning_file := unused_local_warning.associated_feature.associated_class.file_name
							line_pos := unused_local_warning.associated_feature.ast.location.line_number
							col_pos := unused_local_warning.associated_feature.ast.location.start_column_position
							short_warning := "'" + unused_local_warning.associated_local + "' is declared but never used."
						else
							short_warning := clone (warning_string)
						end
						if display_warnings then
							compiler_coclass.event_output_warning (warning_string, short_warning, warning.code, warning_file, line_pos, col_pos)							
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
			st: STRUCTURED_TEXT
			syntax_error: SYNTAX_ERROR
			feature_error: FEATURE_ERROR
			eiffel_error: EIFFEL_ERROR
			error: ERROR
			line_pos: INTEGER
			col_pos: INTEGER
			error_file: STRING
			error_string: STRING
			short_error: STRING
		do
			if not retried then
				from
					create st.make
					error_list := handler.error_list
					error_list.start
				until
					error_list.after

				loop
					error_file := Void
					line_pos := 0
					col_pos := 0
					
					syntax_error ?= error_list.item
					feature_error ?= error_list.item
					eiffel_error ?= error_list.item
					error := error_list.item

					if error /= Void then
						
						create st.make
						error.trace (st)
						error_string := st.image
						
						if eiffel_error /= Void then
							if eiffel_error.class_c /= Void then
								error_file := eiffel_error.class_c.file_name
							end
						end
						if feature_error /= Void then
							line_pos := feature_error.line_number
							short_error := "Feature error: " + feature_error.error_string
						elseif syntax_error /= Void then
							line_pos := syntax_error.line_number
							col_pos := syntax_error.start_position
							short_error := "Syntax Error: " + syntax_error.syntax_message
						else
							short_error := clone (error_string)
						end
						compiler_coclass.event_output_error (error_string, short_error, error.code, error_file, line_pos, col_pos)
					end
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
		
end -- class VS_ERROR_DISPLAYER

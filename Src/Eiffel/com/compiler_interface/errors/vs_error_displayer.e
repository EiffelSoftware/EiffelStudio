indexing
	description: "Visual Studio Error Displayer."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			item: STRING
		do
			if not is_valid_error_string (warn.error_string) then
				create st.make
				warn.trace (st)
				create sf.make
				sf.process_text (st)
				full_error := clone (sf.output)
			else
				full_error := warn.error_string.twin
			end

			unused_warn ?= warn
			if unused_warn /= Void then
				-- Unused local
				file_name := unused_warn.associated_feature.associated_class.file_name
				line_pos := unused_warn.associated_feature.ast.start_location.line
				short_error := "Warning: '"
				from 
					unused_warn.unused_locals.start
				until
					unused_warn.unused_locals.after
				loop
					item ?= unused_warn.unused_locals.item @ 1
					if item /= Void then
						short_error.append (item)
						unused_warn.unused_locals.forth
						if not unused_warn.unused_locals.off then
							short_error.append ("', '")
						else
							if unused_warn.unused_locals.count = 1 then
								short_error.append ("' is")
							else
								short_error.append ("' are")
							end
							
						end	
					end
				end
				short_error.append (" declared but never used in feature '" + unused_warn.associated_feature.name + "'.")
			else
				obs_feat ?= warn
				if obs_feat /= Void then
					-- Call to obsolete feature 
					file_name := obs_feat.a_feature.written_class.file_name
					line_pos := obs_feat.a_feature.ast.start_location.line
					short_error := "Warning: Feature '" + obs_feat.obsolete_feature.name + "' from '" +  
						obs_feat.obsolete_feature.written_class.name + "' is obsolete: '" + 
						obs_feat.obsolete_feature.obsolete_message + "'."
				else 
					obs_class ?= warn
					if obs_class /= Void then
						-- Using obsolete class
						file_name := obs_class.associated_class.file_name
						line_pos := 1
						short_error := "Warning: Class '" + obs_class.obsolete_class.name + "' is obsolete: '" + 
							obs_class.obsolete_class.obsolete_message + "'."
					else
						syn_warn ?= warn
						if syn_warn /= Void then
							-- Syntax warning
							file_name := syn_warn.file_name
							line_pos := syn_warn.line
							short_error := "Warning: " + syn_warn.warning_message
						end
					end
				end
			end
			if short_error = Void then
				short_error := clone (full_error)				
			end
			check
				non_void_full_error: full_error /= Void
				non_void_short_error: short_error /= Void
			end
			short_error := format_error (short_error)
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
			if not is_valid_error_string (err.error_string) then
				-- load help file and add text to begining of error definition			
				special_err ?= err
				if special_err /= Void then
					full_error := clone (special_err.error_case)
				else
					create st.make
					err.trace (st)
					create sf.make
					sf.process_text (st)
					full_error := clone (sf.output)
				end
			else
				full_error := clone (err.error_string)
			end
			
			eif_err ?= err
			if eif_err /= Void then
				feat_err ?= err
				if feat_err /= Void then
						-- Feature error
					line_pos := feat_err.line
					if feat_err.e_feature /= Void then
						file_name := feat_err.e_feature.written_class.file_name
					end
					if is_valid_error_string (feat_err.error_string) then
						short_error := "Error: " + feat_err.error_string
					end
				else
					file_name := eif_err.class_c.file_name
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
						line_pos := syn_err.line
						if is_valid_error_string (syn_err.error_string) then
							short_error := "Error: " + syn_err.error_message
						end
					end
				end
			end
			if short_error = Void then
				short_error := clone (full_error)				
			end
			short_error := format_error (short_error)
			if file_name = Void then
				file_name := "<no file>"
			end
			check
				non_void_full_error: full_error /= Void
				non_void_short_error: short_error /= Void
				non_void_file_name: file_name /= Void
			end
			compiler_coclass.event_output_error (full_error, short_error, err.code, file_name, line_pos, 0)
		end

	is_valid_error_string (err_string: STRING): BOOLEAN is
			-- is `err_string' a valid error string
		do
			Result := err_string /= Void and (not err_string.is_empty) and (not err_string.is_equal ("Error")) and (not err_string.is_equal ("Warning"))
		end
		
	format_error (a_error: STRING): STRING is
			-- formates `a_error' and returns result.
			-- Used to remove new line formatting presented in EiffelStudio
		require
			non_void_error: a_error /= Void
		do
			Result := clone (a_error)
			Result.replace_substring_all ("%N  ", " ")
		ensure
			non_void_Result: result /= Void
		end
		
		
		
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class VS_ERROR_DISPLAYER

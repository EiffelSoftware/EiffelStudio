indexing
	description: "Spell checker wrapper."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SPELL_CHECKER	

feature -- Access

	text: STRING
			-- Text being spell checked

	spell_error: BOOLEAN
	
	speller: SPELLING
			-- Spell checker

feature -- Basic Operations

	spell_check_documents (docs: ARRAYED_LIST [DOCUMENT]) is
			-- Spell check all `docs'
		do
			initialize_speller
			documents := docs
			from
			until
				document_index = docs.count
			loop
				spell_check (docs.i_th (document_index + 1).name)
			end
		end		

	spell_check (a_filename: STRING) is
			-- Spell check `a_text'
		require
			file_not_void: a_filename /= Void			
		local
			l_file: PLAIN_TEXT_FILE
		do			
			create l_file.make (a_filename)
			file_stack.put (l_file)
			changed.put (False)
			if l_file.exists then
				l_file.open_read
				l_file.read_stream (l_file.count)
				text := l_file.last_string
				l_file.close
				initialize_speller		
				speller. set_text (text)
				spell_error := speller.spell_check
				if spell_error then
					events_processing := True
					(create {EV_ENVIRONMENT}).application.process_events_until_stopped					
				end
			end
			file_stack.remove
		end

feature {NONE} -- Implementation

	initialize_speller is
			-- 		
		local	
			l_eof_text_handler: END_OF_TEXT_EVENT_HANDLER_IN_SPELLING
			l_replaced_word_handler: REPLACED_WORD_EVENT_HANDLER_IN_SPELLING
		do
			if not speller_initialized then
				speller_initialized := True
				create speller.make
				create l_eof_text_handler.make (Current, $spelling_end_of_text)
				create l_replaced_word_handler.make (Current, $spelling_replaced_word)
				speller.add_end_of_text (l_eof_text_handler)
				speller.add_replaced_word (l_replaced_word_handler)
				speller.set_dictionary (dictionary)
				speller.set_alert_complete (False)
			end
		end		

	speller_initialized: BOOLEAN
	
	changed: ARRAYED_STACK [BOOLEAN] is
			-- Was file modified during spell check?
		once
			create Result.make (10)
		end

	documents: ARRAYED_LIST [DOCUMENT]
			-- Documents

	document_index: INTEGER

	dictionary: WORD_DICTIONARY is
			-- Word dictionary
		local
			l_app_const: SHARED_OBJECTS
			l_english_loc,
			l_user_loc: FILE_NAME
		once
			create l_app_const
			create l_english_loc.make_from_string (l_app_const.shared_constants.application_constants.templates_path)
			l_english_loc.extend ("en-US.dic")
			create l_user_loc.make_from_string (l_app_const.shared_constants.application_constants.templates_path)
			l_user_loc.extend ("eiffel.dic")
			create Result.make
			Result.set_dictionary_file (l_english_loc.string)
			Result.set_user_file (l_user_loc.string)			
		end		
		
	file_stack: ARRAYED_STACK [PLAIN_TEXT_FILE] is
			-- File stack
		once
			create Result.make (10)
		end		
		
feature {NONE} -- Event Handling

	events_processing: BOOLEAN

	spelling_deleted_word (sender: SYSTEM_OBJECT; e: SPELLING_EVENT_ARGS) is
			-- Word was deleted
		do			
			changed.remove
			changed.extend (True)
		end

	spelling_replaced_word (sender: SYSTEM_OBJECT; e: REPLACE_WORD_EVENT_ARGS) is
			-- Word was replaced
		do
			changed.remove
			changed.extend (True)
		end
	
	spelling_end_of_text (sender: SYSTEM_OBJECT; e: EVENT_ARGS) is
			-- End of text was reached
		local
			l_new_text: STRING
			l_file: PLAIN_TEXT_FILE
		do	
			if changed.item and then not file_stack.is_empty then
				l_new_text := speller.suggestion_form.text_being_checked.text				
				l_file := file_stack.item				
				l_file.wipe_out
				l_file.open_write				
				l_file.put_string (l_new_text)
				l_file.close
			end			
			document_index := document_index + 1
			if events_processing then			
				events_processing := False
				(create {EV_ENVIRONMENT}).application.stop_processing												
				spell_check_documents (documents)
			end
		end
		
invariant
	has_speller: speller /= Void

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
end -- class SPELL_CHECKER

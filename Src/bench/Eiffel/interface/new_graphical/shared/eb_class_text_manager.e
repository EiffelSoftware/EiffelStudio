indexing
	description:
		"Provides access to a class text, where it does not matter whether%N%
		%it is 0, 1 or more class edit tools."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TEXT_MANAGER

inherit
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

feature -- Access

	class_text (a_class: CLASS_I): STRING is
			-- Most recent version of `a_class'-text.
			-- (from a file or from an editor).
		require
			a_class_not_void: a_class /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			unchanged_editor, changed_editor: EB_DEVELOPMENT_WINDOW
			editor: EB_SMART_EDITOR
		do
			l := Window_manager.development_windows_with_class (a_class.name)
			if not l.is_empty then
				from
					l.start
				until
					l.after
				loop
						-- Wait for the editor to read class text.
					editor := l.item.editor_tool.text_area
					from
						ev_application.process_events
					until
						editor.text_is_fully_loaded
					loop
					end

					if editor.is_editable then
						if l.item.changed then
							changed_editor := l.item
						else
							unchanged_editor := l.item
						end
					end
					l.forth
				end
				if changed_editor /= Void then
					Result := changed_editor.text
				elseif unchanged_editor /= Void then
					Result := unchanged_editor.text
				else
					Result := a_class.text
				end					
			else
				Result := a_class.text
			end
		end

feature -- Element change

	set_class_text (a_class: CLASS_I; a_text: STRING) is
			-- Set class text of `a_class' to `a_text' in an editor
			-- if open; if not, save it.
		require
			a_class_not_void: a_class /= Void
			a_text_not_void: a_text /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			in_tool: BOOLEAN
		do
			l := Window_manager.development_windows_with_class (a_class.name)
			from
				l.start
			until
				l.after
			loop
				if l.item.editor_tool.text_area.is_editable then
					l.item.editor_tool.text_area.no_save_before_next_load
					l.item.set_text (a_text)
					in_tool := True
				end
				l.forth
			end
			if not in_tool then
				save_class_text (a_class, a_text)
			end
		end

feature {NONE} -- Implementation

	save_class_text (a_class: CLASS_I; a_text: STRING) is
			-- Overwrite file with class text of `a_class' with `a_text'.
		require
			a_class_not_void: a_class /= Void
			a_text_not_void: a_text /= Void
		local
			a_file: RAW_FILE
			platform: PLATFORM_CONSTANTS
		do
			create a_file.make (a_class.file_name)
			if a_file.exists and then a_file.is_writable then
				a_file.open_write
				a_text.prune_all ('%R')
				create platform
				if platform.is_unix then
					a_file.put_string (a_text)
					if a_text.item (a_text.count) /= '%N' then
							-- Add a carriage return like `vi' if there's none at the end 
						a_file.new_line
					end
				else
					a_text.replace_substring_all ("%N", "%R%N")
					a_file.putstring (a_text)
				end
				a_file.close
			end
		end

end -- class EB_CLASS_TEXT_MANAGER

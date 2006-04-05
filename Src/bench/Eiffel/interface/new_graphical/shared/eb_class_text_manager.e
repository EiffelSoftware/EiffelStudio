indexing
	description:
		"Provides access to a class text, where it does not matter whether%N%
		%it is 0, 1 or more class edit tools."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_TEXT_MANAGER

inherit
	ANY

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SAVE_FILE
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
					l.item.window.set_pointer_style (default_pixmaps.wait_cursor)
					from
						process_events_and_idle
					until
						editor.text_is_fully_loaded
					loop
							-- Because editor text is loaded on idle, unless idle_actions are called EiffelStudio
							-- stays in an infinite loop.
						ev_application.idle_actions.call ([])
					end
					l.item.window.set_pointer_style (default_pixmaps.standard_cursor)

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
				save (a_class.file_name, a_text)
			end
		end

feature {NONE} -- Implementation

	default_pixmaps: EV_STOCK_PIXMAPS is
			-- Default pixmaps and cursors.
		once
			create Result
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

end -- class EB_CLASS_TEXT_MANAGER

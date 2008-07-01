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

	class_text (a_class: CLASS_I): STRING_32 is
			-- Most recent version of `a_class'-text.
			-- (from a file or from an editor).
		require
			a_class_not_void: a_class /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			unchanged_editor, changed_editor: EB_SMART_EDITOR
			editor: ARRAYED_LIST [EB_SMART_EDITOR]
			l_app: like ev_application
		do
			l := Window_manager.development_windows_with_class (a_class.file_name)
			if not l.is_empty then
				from
					l_app := ev_application
					l.start
				until
					l.after
				loop
						-- Wait for the editor to read class text.
					editor := l.item.editors_manager.editor_editing (a_class)
					if not editor.is_empty then
						from
							l.item.window.set_pointer_style (default_pixmaps.wait_cursor)
						until
							l.item.editors_manager.full_loaded
						loop
								-- As editor text is loaded on idle, unless idle_actions are called EiffelStudio
								-- stays in an infinite loop.
							l_app.process_events
						end
						l.item.window.set_pointer_style (default_pixmaps.standard_cursor)

						if editor.first.is_editable then
							if l.item.changed then
								changed_editor := editor.first
							else
								unchanged_editor := editor.first
							end
						end
					end
					l.forth
				end
				if changed_editor /= Void then
					Result := changed_editor.wide_text
				elseif unchanged_editor /= Void then
					Result := unchanged_editor.wide_text
				else
					Result := a_class.text
				end
			else
				Result := a_class.text
			end
		end

feature -- Element change

	set_class_text (a_class: CLASS_I; a_text: STRING_32) is
			-- Set class text of `a_class' to `a_text' in an editor
			-- if open; if not, save it.
		require
			a_class_not_void: a_class /= Void
			a_text_not_void: a_text /= Void
		local
			l: LIST [EB_DEVELOPMENT_WINDOW]
			in_tool: BOOLEAN
			l_editor: EB_SMART_EDITOR
			l_editors: ARRAYED_LIST [EB_SMART_EDITOR]
			l_encoding: ENCODING
		do
			l := Window_manager.development_windows_with_class (a_class.file_name)
			from
				l.start
			until
				l.after
			loop
				l_editors := l.item.editors_manager.editor_editing (a_class)
				if not l_editors.is_empty then
					from
						l_editors.start
					until
						l_editors.after or l_editor /= Void
					loop
						if l_editors.item.is_editable then
							l_editor := l_editors.item
						end
						l_editors.forth
					end
					if l_editor /= Void then
						l_editor.no_save_before_next_load
						l_editor.set_editor_text (a_text)
						in_tool := True
					end
				end
				l.forth
			end
			if not in_tool then
				l_encoding ?= a_class.encoding
				save (a_class.file_name, a_text, l_encoding)
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

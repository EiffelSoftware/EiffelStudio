indexing
	description: "[
		A command that all Errors and Warnings tool {ES_ERRORS_AND_WARNINGS_TOOL} commands are based on.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	ES_ERROR_LIST_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_RECYCLABLE

feature {NONE} -- Initialization

	make (a_commander: like tool_commander)
			-- Initialize command using a tool commander
			--
			-- `a_commander': A errors and warnings tool commander
		require
			a_commander_attached: a_commander /= Void
		do
			tool_commander := a_commander
		ensure
			tool_commander_set: tool_commander = a_commander
		end

	set_global_shortcut (a_preference: SHORTCUT_PREFERENCE)
			-- Sets a global shortcut from a preference `a_preference'
			--
			-- `a_preference': A preference to set a shortcut from
		require
			a_preference_attached: a_preference /= Void
		do
			create accelerator.make_with_key_combination (a_preference.key, a_preference.is_ctrl, a_preference.is_alt, a_preference.is_shift)
			set_referred_shortcut (a_preference)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Clean up

	internal_recycle is
			-- Recycle
		do
			if accelerator /= Void then
				accelerator.actions.wipe_out
				accelerator := Void
			end
			tool_commander := Void
			collect_destroyed_accelerators
		ensure then
			tool_commander_detached: tool_commander = Void
			accelerator_detached: accelerator = Void
		end

feature -- Access

	frozen pixmap: EV_PIXMAP is
			-- Pixmap representing the command.
		local
			l_item: like internal_pixmap
		do
			l_item := internal_pixmap
			if l_item = Void then
				create l_item
				internal_pixmap := l_item
				if pixel_buffer /= Void then
					l_item.put (pixel_buffer.to_pixmap)
				end
			end
			Result := l_item.item
		ensure then
			result_consistent: Result = Result
		end

	pixel_buffer: EV_PIXEL_BUFFER is
			-- Pixel buffer which representing the command.
		deferred
		ensure then
			result_consistent: Result = Result
		end

	name: STRING_GENERAL is
			-- Name of the command. Use to store the command in the
			-- preferences.
		do
			Result := generating_type
		end

feature {NONE} -- Access

	tool_commander: ES_ERROR_LIST_COMMANDER_I
			-- Tool commander interface for interacting with the errors and warnings tool

feature {NONE} -- Internal implementation cache

	internal_pixmap: CELL [like pixmap]
			-- Cached version of `pixmap'
			-- Note: Do not use directly!

invariant
	tool_commander_attached: tool_commander /= Void

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

end

indexing
	description	: "Abstract notion of a command"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud  PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EB_COMMAND

inherit
	E_CMD

	EB_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	accelerator: EV_ACCELERATOR;
			-- Key combination that executes `Current'.

	referred_shortcut: MANAGED_SHORTCUT
			-- A referred managed shortcut.

	shortcut_string: STRING_GENERAL is
			-- Shortcut string.
		do
			if referred_shortcut /= Void then
				Result := referred_shortcut.display_string
			elseif accelerator /= Void then
				Result := accelerator.out
			else
				Result := ""
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status report

	shortcut_available: BOOLEAN is
			-- Is shortcut available?
		do
			if referred_shortcut /= Void then
				Result := not referred_shortcut.is_wiped
			elseif accelerator /= Void then
				Result := True
			end
		end

feature -- Status Change

	set_referred_shortcut (a_shortcut: like referred_shortcut) is
			-- Set `referred_shortcut' with `a_shortcut'.
		do
			referred_shortcut := a_shortcut
		ensure
			referred_shortcut_set: referred_shortcut = a_shortcut
		end

	update (a_window: EV_WINDOW) is
			-- Update `accelerator' and interfaces according to `referred_shortcut'.
		require
			a_window_not_void: a_window /= Void
		do
			update_accelerator (a_window)
		end

feature {NONE} -- Implementation

	update_accelerator (a_window: EV_WINDOW) is
			-- Change `accelerator' according to `referred_shortcut' and
			-- update it in `a_window'.
		require
			a_window_not_void: a_window /= Void
		local
			l_accelerators: EV_ACCELERATOR_LIST
			l_accelerator: like accelerator
			l_compare_object: BOOLEAN
		do
			if accelerator /= Void and then referred_shortcut /= Void then
				l_accelerators := a_window.accelerators
					-- Remove accelerator from related window.
				l_compare_object := l_accelerators.object_comparison
				l_accelerators.compare_references
				if l_accelerators.has (accelerator) then
					l_accelerators.prune_all (accelerator)
				end
				if l_compare_object then
					l_accelerators.compare_objects
				end

					-- Modify `accelerator' accordingly
				if not referred_shortcut.is_wiped then
					l_accelerator := accelerator
					l_accelerator.set_key (referred_shortcut.key)
					if referred_shortcut.is_ctrl then
						l_accelerator.enable_control_required
					else
						l_accelerator.disable_control_required
					end
					if referred_shortcut.is_alt then
						l_accelerator.enable_alt_required
					else
						l_accelerator.disable_alt_required
					end
					if referred_shortcut.is_shift then
						l_accelerator.enable_shift_required
					else
						l_accelerator.disable_shift_required
					end
						-- Add new accelerator to `a_window'
					l_accelerators.extend (l_accelerator)
				end
			end
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

end -- class EB_COMMAND

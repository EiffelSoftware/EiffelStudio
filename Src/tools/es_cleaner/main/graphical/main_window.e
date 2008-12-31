note
	description: "[
		The graphical application's primary top-level window.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"


class
	MAIN_WINDOW

inherit
	MAIN_WINDOW_IMP

	SITE [PACKAGE]
		export
			{PACKAGE} all
		undefine
			default_create,
			copy,
			is_equal
		redefine
			siteable_entities
		end

feature {NONE} -- Initialization

	user_initialization
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
				-- Set up UI
			create release_mode_item.make_with_text ("Release")
			create workbench_mode_item.make_with_text ("Workbench")
			cbx_mode.extend (release_mode_item)
			cbx_mode.extend (workbench_mode_item)

			show_actions.extend (agent on_mode_changed)
		end

feature {NONE} -- Access

	siteable_entities: !ARRAYED_LIST [!SITE [PACKAGE]]
			-- List of siteable entities to automatically site when `Current' is sited
		do
			Result := Precursor {SITE}
			Result.extend (page_cleaning.as_attached)
			Result.extend (page_restoration.as_attached)
		end

	release_mode_item: EV_LIST_ITEM

	workbench_mode_item: EV_LIST_ITEM
			-- Application mode items

feature -- Status report

	frozen use_workbench_settings: BOOLEAN
			-- Inidicates if workbench settings should be used
		do
			Result := cbx_mode.selected_item = workbench_mode_item
		end

feature {NONE} -- Implementation

	on_mode_changed
			-- Called by `change_actions' of `cbx_mode'.
		do
			if site /= Void then
				site.set_is_workbench_mode (use_workbench_settings)
			end
		end

	on_close
			-- Called by `select_actions' of `btn_close'.
		local
			l_app: EV_APPLICATION
		do
			l_app := (create {EV_SHARED_APPLICATION}).ev_application
			if not l_app.is_destroyed then
				hide
				destroy
				l_app.destroy
			end
		end

;note
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

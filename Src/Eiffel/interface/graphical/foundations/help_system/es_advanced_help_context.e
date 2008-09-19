indexing
	description: "[
			An advanced help context which supplies helper context based on focused widgets.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_ADVANCED_HELP_CONTEXT

inherit
	ES_HELP_CONTEXT
		rename
			help_context_id as internal_help_context_id,
			help_context_section as internal_help_context_section
		redefine
			internal_help_context_section
		end

feature {NONE} -- Access

	help_context_id: !STRING_GENERAL
			-- A contextual identifer to link an associated help through, when no applicable widget is
			-- selected.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	help_context_ids: !LIST [!TUPLE [widget: EV_WIDGET; id: !STRING_GENERAL; section: ?HELP_CONTEXT_SECTION_I]]
			-- Contextual identifers to link an associated help through, binding context id's to a specific
			-- widget.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

	help_context_section: ?HELP_CONTEXT_SECTION_I
			-- An optional sub-section in the help document, located using `help_context_id' to navigate to,
			-- when no applicable widget is selected.
		require
			is_interface_usable: is_interface_usable
		do
		end

feature {NONE} -- Implementation: Internal

	frozen internal_help_context_id: !STRING_GENERAL
			-- <Precursor>
		local
			l_ids: !like help_context_ids
			l_item: !TUPLE [widget: EV_WIDGET; id: !STRING_GENERAL; section: ?HELP_CONTEXT_SECTION_I]
			l_widget: ?EV_WIDGET
			l_result: ?STRING_GENERAL
			l_stop: BOOLEAN
		do
			l_widget := (create {EV_SHARED_APPLICATION}).ev_application.focused_widget
			if l_widget /= Void then
				l_ids := help_context_ids
				from l_ids.start until l_stop or l_ids.after loop
					l_item := l_ids.item
					if l_item.widget = l_widget then
						l_stop := True
						l_result := l_item.id
					end
					l_ids.forth
				end

				if not l_stop then
						-- Second attempt, check widget-level focus because no widget
						-- mapped has direct focus.
					from l_ids.start until l_stop or l_ids.after loop
						l_item := l_ids.item
						if l_item.widget.has_focus then
							l_stop := True
							l_result := l_item.id
						end
						l_ids.forth
					end
				end
			end
			if l_result = Void then
					-- Use the default id.
				Result := help_context_id
			else
				Result := l_result
			end
		end

	frozen internal_help_context_section: ?HELP_CONTEXT_SECTION_I
			-- <Precursor>
		local
			l_ids: !like help_context_ids
			l_item: !TUPLE [widget: EV_WIDGET; id: !STRING_GENERAL; section: ?HELP_CONTEXT_SECTION_I]
			l_widget: ?EV_WIDGET
			l_result: ?HELP_CONTEXT_SECTION_I
			l_stop: BOOLEAN
		do
			l_widget := (create {EV_SHARED_APPLICATION}).ev_application.focused_widget
			if l_widget /= Void then
				l_ids := help_context_ids
				from l_ids.start until l_stop or l_ids.after loop
					l_item := l_ids.item
					if l_item.widget = l_widget then
						l_stop := True
						l_result := l_item.section
					end
					l_ids.forth
				end

				if not l_stop then
						-- Second attempt, check widget-level focus because no widget
						-- mapped has direct focus.
					from l_ids.start until l_stop or l_ids.after loop
						l_item := l_ids.item
						if l_item.widget.has_focus then
							l_stop := True
							l_result := l_item.section
						end
						l_ids.forth
					end
				end
			end
			if l_result = Void then
				if internal_help_context_id.is_equal (help_context_id)  then
						-- Use the default section.
					Result := help_context_section
				end
			else
				Result := l_result
			end
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

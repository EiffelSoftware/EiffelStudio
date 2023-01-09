note
	description: "Object that represents basic utilities used in Vision2 support"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_UTILITY

inherit
	EV_SHARED_APPLICATION

feature{NONE} -- Agent registration

	safe_register_agent (a_agent: PROCEDURE; a_action_sequence: ACTION_SEQUENCE [TUPLE])
			-- If `a_action_sequence' doesn't has `a_agent' already, register `a_agent' into `a_action_sequence'.
		require
			a_agent_attached: a_agent /= Void
			a_action_sequence_attached: a_action_sequence /= Void
		do
			if not a_action_sequence.has (a_agent) then
				a_action_sequence.extend (a_agent)
			end
		ensure
			a_agent_registered: a_action_sequence.has (a_agent)
		end

	safe_remove_agent (a_agent: PROCEDURE; a_action_sequence: ACTION_SEQUENCE [TUPLE])
			-- If `a_action_sequence' has `a_agent', remove it from `a_action_sequence'.
		require
			a_agent_attached: a_agent /= Void
			a_action_sequence_attached: a_action_sequence /= Void
		do
			if a_action_sequence.has (a_agent) then
				a_action_sequence.prune_all (a_agent)
			end
		ensure
			a_agent_removed: not a_action_sequence.has (a_agent)
		end

feature -- Accelerator

	is_accelerator_matched (a_key: EV_KEY; a_accelerator: EV_ACCELERATOR): BOOLEAN
			-- Does `a_accelerator' match current keyboard status?
		require
			a_key_attached: a_key /= Void
		local
			l_ev_app: like ev_application
		do
			l_ev_app := ev_application
			Result := a_accelerator /= Void and then
					 a_accelerator.key.code = a_key.code and then
					 a_accelerator.alt_required = l_ev_app.alt_pressed and then
					 a_accelerator.shift_required = l_ev_app.shift_pressed and then
					 a_accelerator.control_required = l_ev_app.ctrl_pressed
		ensure
			good_result: Result implies (a_accelerator /= Void and then
			  						   a_accelerator.key.code = a_key.code and then
							 		   a_accelerator.alt_required = ev_application.alt_pressed and then
					 				   a_accelerator.shift_required = ev_application.shift_pressed and then
					 				   a_accelerator.control_required = ev_application.ctrl_pressed)
		end

feature -- Focus

	has_focus_on_widgets_content (a_widget: EV_WIDGET): BOOLEAN
			-- Does `a_widget' or its sub-widgets if it is a container has focus?
		do
			if attached {EV_CONTAINER} a_widget as l_container then
				if attached l_container.linear_representation as l_linear_representation and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after or Result
					loop
						if l_linear_representation.item.has_focus then
							Result := True
						else
							Result := has_focus_on_widgets_content (l_linear_representation.item)
						end
						l_linear_representation.forth
					end
				elseif l_container.has_focus then
					Result := True
				end
			elseif a_widget.has_focus then
				Result := True
			end
		end

feature -- Fonts

	grid_row_height_for_fonts (a_fonts: SPECIAL [EV_FONT]): INTEGER
			-- Suitable row height in pixel to display all fonts in `a_fonts' and pixmaps with height `a_pixmap_height'
		require
			a_fonts_attached: a_fonts /= Void
		local
			l_font: EV_FONT
			l_index: INTEGER
			l_upper: INTEGER
		do
			from
				l_index := a_fonts.lower
				l_upper := a_fonts.upper
			until
				l_index > l_upper
			loop
				l_font := a_fonts.item (l_index)
				if l_font /= Void then
					Result := Result.max (l_font.line_height)
				end
				l_index := l_index + 1
			end
		ensure
			instance_free: class
		end

note
        copyright:	"Copyright (c) 1984-2023, Eiffel Software and others"
        license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

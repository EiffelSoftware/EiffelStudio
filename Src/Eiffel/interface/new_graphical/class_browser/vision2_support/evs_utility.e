indexing
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

	safe_register_agent (a_agent: PROCEDURE [ANY, TUPLE]; a_action_sequence: ACTION_SEQUENCE [TUPLE]) is
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

	safe_remove_agent (a_agent: PROCEDURE [ANY, TUPLE]; a_action_sequence: ACTION_SEQUENCE [TUPLE]) is
			-- If `a_action_sequence' has `a_agent', remove it from `a_action_sequence'.
		require
			a_agent_attached: a_agent /= Void
			a_action_sequence_attached: a_action_sequence /= Void
		do
			a_action_sequence.search (a_agent)
			if not a_action_sequence.exhausted then
				a_action_sequence.prune_all (a_agent)
			end
		ensure
			a_agent_removed: not a_action_sequence.has (a_agent)
		end


feature -- Accelerator

	is_accelerator_matched (a_key: EV_KEY; a_accelerator: EV_ACCELERATOR): BOOLEAN is
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

	has_focus_on_widgets_content (a_widget: EV_WIDGET): BOOLEAN is
			-- Does `a_widget' or its sub-widgets if it is a container has focus?
		local
			l_container: EV_CONTAINER
			l_linear_representation: LINEAR [EV_WIDGET]
		do
			l_container ?= a_widget
			if l_container /= Void then
				l_linear_representation := l_container.linear_representation
				if l_linear_representation /= Void and then not l_linear_representation.is_empty then
					from
						l_linear_representation.start
					until
						l_linear_representation.after or Result
					loop
						if l_linear_representation.item.has_focus then
							Result := true
						else
							Result := has_focus_on_widgets_content (l_linear_representation.item)
						end
						l_linear_representation.forth
					end
				elseif l_container.has_focus then
					Result := true
				end
			elseif a_widget.has_focus then
				Result := true
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


end

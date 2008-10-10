indexing
	description: "[
			Represents a analyzer's state persistent information.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EDITOR_ANALYZER_STATE_INFO

create
	make,
	make_with_feature

feature {NONE} -- Initialization

	make (a_class: !like context_class; a_token: !like current_token; a_line: !like current_line)
			-- Initialize a state result using a context class and an initial editor token and hosting line.
			--
			-- `a_class': The context class, used to resolve any type or feature information.
			-- `a_token': The state's current token.
			-- `a_line' : The state's current line, where the supplied token is resident.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		do
			create frames.make (1)
			context_class := a_class
			set_current_line (a_line, a_token)
		ensure
			context_class_set: context_class ~ a_class
			current_line_set: current_line ~ a_line
			current_token_set: current_token ~ a_token
		end

	make_with_feature (a_class: !like context_class; a_feature: !like context_feature; a_token: !like current_token; a_line: !like current_line)
			-- Initialize a state result using a context class and an initial editor token and hosting line.
			--
			-- `a_class'  : The context class, used to resolve any type or feature information.
			-- `a_feature': The context feature to initialize the state info for.
			-- `a_token'  : The state's current token.
			-- `a_line'   : The state's current line, where the supplied token is resident.
		require
			a_line_has_a_token: a_line.has_token (a_token)
		do
			context_feature := a_feature
			make (a_class, a_token, a_line)
		ensure
			context_class_set: context_class ~ a_class
			context_feature_set: context_feature ~ a_feature
			current_line_set: current_line ~ a_line
			current_token_set: current_token ~ a_token
		end

feature -- Access

	context_class: !CLASS_C
			-- The context class

	context_feature: ?FEATURE_I
			-- The context feature

	current_token: !EDITOR_TOKEN assign set_current_token
			-- Last editor token processed.

	current_line: !EDITOR_LINE
			-- Last editor line processed.

	current_frame: !ES_EDITOR_ANALYZER_FRAME
			-- Current class context frame, used for local entity storage.
		require
			has_current_frame: has_current_frame
		do
			Result := frames.item
		end

feature {NONE} -- Access

	frames: !ARRAYED_STACK [!ES_EDITOR_ANALYZER_FRAME]
			-- Stack of context frames used for local entity storage.

feature -- Element change

	set_current_token (a_token: !like current_token)
			-- Sets the current token.
			-- Note: Setting the current token in this fashion assumes the token belongs to the current
			--       line. Use `set_current_line' when changing lines and tokens.
			--
			-- `a_token': The new token to set on the state result.
		require
			current_line_has_a_token: current_line.has_token (a_token)
		do
			current_token := a_token
		ensure
			current_token_set: current_token ~ a_token
		end

	set_current_line (a_line: !like current_line; a_initial_token: !like current_token)
			-- Stets the current line and current token
			--
			-- `a_line'         : The new line to set on the state result.
			-- `a_initial_token': The initial line token to set on the state result.
		require
			a_line_has_a_initial_token: a_line.has_token (a_initial_token)
		do
			current_line := a_line
			set_current_token (a_initial_token)
		ensure
			current_line_set: current_line ~ a_line
			current_token_set: current_token ~ a_initial_token
		end

feature -- Status report

	has_context_feature: BOOLEAN
			-- Indicates if there is a context feature set for more specific analysis.
		do
			Result := context_feature /= Void
		ensure
			context_feature_attached: Result implies context_feature /= Void
		end

	has_current_frame: BOOLEAN
			-- Indicates if there is a current frame.
		do
			Result := not frames.is_empty
		end

	has_runout: BOOLEAN assign set_has_runout
			-- Indicates if the scanner has run out of tokens to process

feature -- Status setting

	set_has_runout (a_runout: like has_runout)
			-- Sets runout token state.
			--
			-- `a_runout': True if there are no more tokens to process; False otherwise.
		do
			has_runout := a_runout
		ensure
			has_runout_set: has_runout = a_runout
		end

feature -- Basic operation

	increment_current_frame (a_force_new: BOOLEAN)
			-- Increments the current local frame. `current_frame' will be affected as a result.
			--
			-- `a_force_new': True to create a new stop frame; False otherwise.
		require
			has_context_feature: has_context_feature
		local
			l_frame: ?like current_frame
			l_feature: ?like context_feature
		do
			if not a_force_new and has_current_frame then
				l_frame := current_frame
			end
			l_feature := context_feature
			if l_feature /= Void then
				if l_frame = Void then
					create l_frame.make (context_class, l_feature)
				else
					create l_frame.make_parented (context_class, l_feature, l_frame)
				end
				frames.extend (l_frame)
			else
				check False end
			end
		ensure
--			current_frame_changed: old has_current_frame and then current_frame /~ old current_frame
--			current_frame_is_stop_frame: a_force_new implies current_frame.is_stop_frame
--			current_frame_parented: (old current_frame /= Void and not a_force_new) implies not current_frame.is_stop_frame
		end

	decrement_current_frame
			-- Decrements the current frame.
		require
			has_current_frame: has_current_frame
		do
			frames.remove
		end

invariant
	current_line_has_current_token: current_line.has_token (current_token)

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

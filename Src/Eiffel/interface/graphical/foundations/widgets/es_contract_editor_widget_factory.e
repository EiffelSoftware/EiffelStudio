indexing
	description: "[
		A factory for creating a contract editor widgets.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CONTRACT_EDITOR_WIDGET_FACTORY

feature -- Access

	context_class: EIFFEL_CLASS_I
			-- Currently class being edited

	context_root: CLASS_AS
			-- Root AS node of edited class

	context_feature: FEATURE_AS
			-- Feature node of edited feature

	context_line: INTEGER
			-- Contextual line number

feature {NONE} -- Access

	parser: !EIFFEL_PARSER
			-- Eiffel parser used to extract live data
		once
			create Result.make_with_factory (create {AST_FACTORY})
		end

feature -- Element change

	set_context (a_class: !like context_class; a_class_text: !STRING_GENERAL; a_line: like context_line)
			-- Sets factory contextual information.
			-- Note: The information set here may be in full or in part depending on what context objects can be extracted.
			--       Check `has_full_context' to ensure all required context objects were set during this operation.
			--
			-- `a_class': The actually system class displayed in the editor.
			-- `a_class_text': The live class text as shown in the editor.
			-- `a_line': The line number where the context is to fetch from.
		local
			l_parser: like parser
			l_class: CLASS_AS
			l_feature: FEATURE_AS
		do
			reset_context

			context_class := a_class
			context_line := a_line

			l_parser := parser
			l_parser.parse_from_string (a_class_text.as_string_8)
			l_class := l_parser.root_node
			if l_class /= Void then
				context_root := l_class

				l_feature := l_class.feature_of_position (a_line)
				if l_feature /= Void then
					context_feature := l_feature
				end
			end
		end

feature -- Status report

	has_full_context: BOOLEAN
			-- Indicate if the factory has enough context for creating a contract widget.
		do
			Result := context_class /= Void and then context_root /= Void and then context_feature /= Void
		ensure
			context_class_attached: Result implies context_class /= Void
			context_root_attached: Result implies context_root /= Void
			context_feature_attached: Result implies context_feature /= Void
		end

feature -- Basic operations

	reset_context
			-- Reset set all held context information.
		do
			context_root := Void
			context_feature := Void
			context_line := 0
		ensure
			not_has_full_context: not has_full_context
			context_root_detached: context_root = Void
			context_feature_detatched: context_feature = Void
			context_line_reset: context_line = 0
		end

feature -- Factory

	create_precondition_widget: !EV_WIDGET
			-- Creates a contract editor widget for editing a feature's precondition.
		require
			has_full_context: has_full_context
--		local
--			l_widget: !ES_CONTRACT_EDITOR_WIDGET
		do
--			create l_widget.make
--			Result := ({!EV_WIDGET}) #? l_widget.widget
			Result := create_coming_soon_widget
		end

	create_postcondition_widget: !EV_WIDGET
			-- Creates a contract editor widget for editing a feature's postconditions.
		require
			has_full_context: has_full_context
--		local
--			l_widget: !ES_CONTRACT_EDITOR_WIDGET
		do
--			create l_widget.make
--			Result := ({!EV_WIDGET}) #? l_widget.widget
			Result := create_coming_soon_widget
		end

	create_invalid_context_widget: !EV_WIDGET
			-- Creates a widget when there is an invalid context
		require
			not_has_full_context: not has_full_context
		do
			if context_class = Void then
				Result := create_parse_error_widget
			else
				Result := create_parse_error_widget
			end
		end

feature {NONE} -- Factory

	create_parse_error_widget: !EV_WIDGET
			-- Create a widget to notify the user a contract widget is unavailable due to class parse errors.
		local
			l_widget: !ES_ERROR_WIDGET
		do
			create l_widget.make_with_text (
				"The contract editor cannot be displayed%N%
				%due to class syntax errors.%N%N%
				%Please fix the errors and try again."
			)
			Result := ({!EV_WIDGET}) #? l_widget.widget
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

	create_coming_soon_widget: !EV_WIDGET
			-- Temporary
		local
			l_widget: !ES_ERROR_WIDGET
		do
			create l_widget.make_with_text (
				"The contract editor is coming soon!%N%N%
				%Please report any annoyances or happering intrusions%N%
				%of the new pop-up UI so we may improve it before the release.%N%N%
				%Press ESC or click anywhere outside this message to discard."
			)
			Result := ({!EV_WIDGET}) #? l_widget.widget
		ensure
			not_result_is_destroyed: not Result.is_destroyed
		end

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

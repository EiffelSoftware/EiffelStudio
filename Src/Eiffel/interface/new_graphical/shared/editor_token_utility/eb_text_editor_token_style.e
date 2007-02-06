indexing
	description: "Style to generate editor tokens for a given string"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_EDITOR_TOKEN_STYLE

inherit
	EB_AGENT_EDITOR_TOKEN_STYLE

feature -- Setting

	set_source_text, st_normal_text (a_source_text: STRING) is
			-- Set `source_text' to be generated in `text' as normal text.
		require
			a_source_text_attached: a_source_text /= Void
		do
			set_editor_token_function (agent normal_text_agent (a_source_text))
		end

	set_symbol_text (a_symbol: STRING) is
			-- Set `source_text' to be generated in `text' as symbol text.
		require
			a_symbol_attached: a_symbol /= Void
		do
			set_editor_token_function (agent symbol_text_agent (a_symbol))
		end

	set_number_text (a_number: STRING) is
			-- Set `source_text' to be generated in `text' as number text.
		require
			a_number_attached: a_number /= Void
		do
			set_editor_token_function (agent number_text_agent (a_number))
		end

feature{NONE} -- Agents

	generated_editor_token (a_text_processor_function: FUNCTION [ANY, TUPLE [like token_writer], PROCEDURE [ANY, TUPLE [STRING_GENERAL]]]; a_text: STRING_GENERAL): LIST [EDITOR_TOKEN] is
			-- Process `a_text' using agent returned from `a_text_processor_function' and returned generated editor tokens.
		require
			a_text_processor_function_attached: a_text_processor_function /= Void
			a_text_attached: a_text /= Void
		local
			l_writer: like token_writer
		do
			l_writer := token_writer
			l_writer.new_line
			a_text_processor_function.item ([l_writer]).call ([a_text])
			Result := l_writer.last_line.content
		ensure
			result_attached: Result /= Void
		end

	normal_text_agent (a_text: STRING): LIST [EDITOR_TOKEN] is
			-- Editor token representation of `a_text' in normal text style
		require
			a_text_attached: a_text /= Void
		do
			Result := generated_editor_token (
				agent (a_writer: like token_writer): PROCEDURE [ANY, TUPLE [STRING_GENERAL]] do Result := agent a_writer.add end ,
				a_text
			)
		ensure
			result_attached: Result /= Void
		end

	symbol_text_agent (a_text: STRING): LIST [EDITOR_TOKEN] is
			-- Editor token representation of `a_text' in symbol style
		require
			a_text_attached: a_text /= Void
		do
			Result := generated_editor_token (
				agent (a_writer: like token_writer): PROCEDURE [ANY, TUPLE [STRING_GENERAL]] do Result := agent a_writer.process_symbol_text end ,
				a_text
			)
		ensure
			result_attached: Result /= Void
		end

	number_text_agent (a_text: STRING): LIST [EDITOR_TOKEN] is
			-- Editor token representation of `a_text' in number style
		require
			a_text_attached: a_text /= Void
		do
			Result := generated_editor_token (
				agent (a_writer: like token_writer): PROCEDURE [ANY, TUPLE [STRING_GENERAL]] do Result := agent a_writer.process_number_text end ,
				a_text
			)
		ensure
			result_attached: Result /= Void
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

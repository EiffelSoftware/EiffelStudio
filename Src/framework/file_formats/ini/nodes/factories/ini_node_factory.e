note
	description: "Factory interface for create INI abstract syntax nodes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INI_NODE_FACTORY

feature {INI_PARSER}

	new_id_node (a_id: STRING; a_span: INI_TEXT_SPAN): INI_ID_NODE
			--
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_span_attached: a_span /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_value_node (a_value: STRING; a_span: INI_TEXT_SPAN): INI_VALUE_NODE
			--
		require
			a_value_attached: a_value /= Void
			not_a_value_is_empty: not a_value.is_empty
			a_span_attached: a_span /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_symbol_node (a_symbol: STRING; a_span: INI_TEXT_SPAN): INI_SYMBOL_NODE
			--
		require
			a_symbol_attached: a_symbol /= Void
			not_a_symbol_is_empty: not a_symbol.is_empty
			a_span_attached: a_span /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_section_node (a_open: INI_SYMBOL_NODE; a_label: INI_ID_NODE; a_close: INI_SYMBOL_NODE): INI_SECTION_NODE
			--
		require
			a_open_attached: a_open /= Void
			a_label_attached: a_label /= Void
			a_close_attached: a_close /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_property_node (a_id: INI_ID_NODE; a_assigner: INI_SYMBOL_NODE; a_value: INI_VALUE_NODE): INI_PROPERTY_NODE
			--
		require
			a_id_set: a_value = Void implies a_id /= Void
			a_assigner_attached: a_assigner /= Void
			a_value_attached: a_id = Void implies a_value /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

	new_literal_node (a_id: STRING; a_span: INI_TEXT_SPAN): INI_LITERAL_NODE
			--
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
			a_span_attached: a_span /= Void
		deferred
		ensure
			result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class {INI_AST_FACTORY}

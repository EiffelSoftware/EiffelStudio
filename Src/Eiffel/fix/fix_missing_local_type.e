note
	description: "Fix of {MISSING_LOCAL_TYPE} by adding a type declaration."

class	FIX_MISSING_LOCAL_TYPE

inherit
	FIX_FEATURE
	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Creation

	make (e: MISSING_LOCAL_TYPE_ERROR)
			-- Associate a fix with the error `e'.
		require
			is_class_writable: not e.written_class.lace_class.is_read_only
		do
			source := e
		end

feature {NONE} -- Access

	source: MISSING_LOCAL_TYPE_ERROR
			-- Associated warning.

feature -- Access

	source_class: CLASS_I
			-- Descriptor of a class to be fixed.
		do
			Result := source.written_class.lace_class
		end

	source_feature: E_FEATURE
			-- Descriptor of a feature to be fixed.
		do
			Result := source.e_feature
		end

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format_action_missing_local_type
				(t, agent (create {AST_TYPE_OUTPUT_STRATEGY}).process (source.suggested_type, ?, source_class.compiled_class, source_feature.associated_feature_i))
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format_description_missing_local_type
				(t, agent (create {AST_TYPE_OUTPUT_STRATEGY}).process (source.suggested_type, ?, source_class.compiled_class, source_feature.associated_feature_i))
		end

feature -- Basic operations

	apply (s: FEATURE_AS; l: LEAF_AS_LIST)
			-- Attempt to apply the fix to the source AST `s'.
		do
			(create {FIX_MISSING_LOCAL_TYPE_APPLICATION}.make (source.suggested_type, source_class.compiled_class, source_feature.associated_feature_i, source.identifiers, s, l)).do_nothing
		end

feature {NONE} -- Formatting

	locals: ITERABLE [PROCEDURE[TEXT_FORMATTER]]
			-- Collection of formatters to add unused local variables.
		do
			create {ITERABLE_FUNCTION [PROCEDURE[TEXT_FORMATTER], INTEGER_32]} Result.make
				(agent (local_name: INTEGER_32): PROCEDURE[TEXT_FORMATTER]
					do
						Result := agent {TEXT_FORMATTER}.add_local (names_heap.item_32 (local_name))
					end,
				source.identifiers)
		end

	message: FIX_MESSAGE
			-- A message formatter.
		once
			create Result
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

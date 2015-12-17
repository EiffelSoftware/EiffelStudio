note
	description: "Fix of {UNUSED_LOCAL_WARNING} by removing associated locals."

class	FIX_UNUSED_LOCAL

inherit
	FIX_FEATURE
	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Creation

	make (w: UNUSED_LOCAL_WARNING)
			-- Associate a fix with the warning `w'.
		require
			is_class_writable: not w.associated_class.lace_class.is_read_only
		do
			source := w
		end

feature {NONE} -- Access

	source: UNUSED_LOCAL_WARNING
			-- Associated warning.

feature -- Access

	source_class: CLASS_I
			-- <Precursor>
		do
			Result := source.associated_class.lace_class
		end

	source_feature: E_FEATURE
			-- <Precursor>
		do
			Result := source.associated_feature
		end

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format_action_unused_local (t, locals)
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message.format_description_unused_local (t, locals)
		end

feature -- Basic operations

	apply (s: FEATURE_AS; l: LEAF_AS_LIST)
			-- Attempt to apply the fix to the source AST `s'.
		do
			(create {FIX_UNUSED_LOCAL_APPLICATION}.make (source.unused_locals, s, l)).do_nothing
		end

feature {NONE} -- Formatting

	locals: ITERABLE [PROCEDURE[TEXT_FORMATTER]]
			-- Collection of formatters to add unused local variables.
		do
			create {ITERABLE_FUNCTION [PROCEDURE[TEXT_FORMATTER], TUPLE [name: INTEGER_32; type: TYPE_A]]} Result.make
				(agent (local_declaration: TUPLE [name: INTEGER_32; type: TYPE_A]): PROCEDURE[TEXT_FORMATTER]
					do
						Result := agent {TEXT_FORMATTER}.add_local (names_heap.item_32 (local_declaration.name))
					end,
				source.unused_locals)
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

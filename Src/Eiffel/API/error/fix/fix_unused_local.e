note
	description: "Fix of {UNUSED_LOCAL_WARNING} by removing associated locals."

class	FIX_UNUSED_LOCAL

inherit
	FIX_CLASS
	SHARED_NAMES_HEAP

create {UNUSED_LOCAL_WARNING}
	make

feature {NONE} -- Creation

	make (w: UNUSED_LOCAL_WARNING)
			-- Associate a fix with the given warning.
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
			-- Descriptor of a class to be fixed.
		do
			Result := source.associated_class.lace_class
		end

	source_feature: E_FEATURE
			-- Descriptor of a feature to be fixed.
		do
			Result := source.associated_feature
		end

feature -- Output

	append_name (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message_formatter.format (t, "Remove {1|, }", <<message_formatter.list (add_list, locals)>>)
		end

	append_description (t: TEXT_FORMATTER)
			-- <Precursor>
		do
			message_formatter.format (t, "Remove declarations of the local variables {1|, }.", <<message_formatter.list (add_list, locals)>>)
		end

feature -- Basic operations

	apply (s: FEATURE_AS; l: LEAF_AS_LIST)
			-- Attempt to apply the fix to the source AST `s'.
		do
			(create {FIX_UNUSED_LOCAL_APPLICATION}.make (source.unused_locals, s, l)).do_nothing
		end

feature {NONE} -- Formatting

	locals: ITERABLE_FUNCTION [PROCEDURE[ANY, TUPLE [TEXT_FORMATTER]], TUPLE [name: INTEGER_32; type: TYPE_A]]
			-- Collection of formatters to add unused local variables.
		do
			create Result.make
				(agent (local_declaration: TUPLE [name: INTEGER_32; type: TYPE_A]): PROCEDURE[ANY, TUPLE [TEXT_FORMATTER]]
					do
						Result := agent (n: READABLE_STRING_GENERAL; t: TEXT_FORMATTER) do t.add_local (n) end (names_heap.item_32 (local_declaration.name), ?)
					end,
				source.unused_locals)
		end

	add_list: PROCEDURE [ANY, TUPLE [detachable FORMAT_SPECIFICATION, TEXT_FORMATTER, ITERABLE [PROCEDURE [ANY, TUPLE [TEXT_FORMATTER]]]]]
			-- Agent to add list of items to the output.
		do
			Result := agent (f: detachable FORMAT_SPECIFICATION; t: TEXT_FORMATTER; i: ITERABLE [PROCEDURE [ANY, TUPLE [TEXT_FORMATTER]]])
				local
					delimiter: detachable READABLE_STRING_GENERAL
				do
					across
						i as c
					loop
						if attached delimiter then
								-- This is not a first iteration, add `delimiter' before item.
							t.add (delimiter)
						elseif attached f then
								-- First iteration, set delimiter for subsequent iterations from the format specification.
							delimiter := f.item
						else
								-- First iteration, set delimiter for subsequent iterations to the default  one.
							delimiter := {STRING_32} ", "
						end
						c.item (t)
					end
				end
		end

	message_formatter: COMPOSITE_FORMATTER [TEXT_FORMATTER]
			-- Formatter of the fix message(s).
		once
				-- TODO: Add features to handle substrings to TEXT_FORMATTER.
			create Result.make (
				agent (t: TEXT_FORMATTER; s: READABLE_STRING_GENERAL; start_index, end_index: INTEGER_32)
						-- Add a substring of `s' with valid index positions between `start_index' and `end_index' to `t'.
					do
						t.add (s.substring (start_index, end_index))
					end)
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

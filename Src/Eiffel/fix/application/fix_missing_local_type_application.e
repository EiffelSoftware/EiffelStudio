note
	description: "Application of {FIX_MISSING_LOCAL_TYPE} to a source code."

class
	FIX_MISSING_LOCAL_TYPE_APPLICATION

inherit
	AST_ITERATOR
		redefine
			process_local_dec_list_as
		end
	INTERNAL_COMPILER_STRING_EXPORTER

create

	make

feature {NONE} -- Creation

	make (local_type: TYPE_A; source_class: CLASS_C; source_feature: FEATURE_I; identifiers: ITERABLE [INTEGER_32]; ast: FEATURE_AS; tokens: LEAF_AS_LIST)
			-- Add type `local_type' for untyped locals with identifiers `identifiers' written in `source_class' to `tokens' corresponding to `ast'.
		do
			type := local_type
			locals := identifiers
			written_class := source_class
			written_feature := source_feature
			token_list := tokens
			ast.process (Current)
		end

feature {NONE} -- Access

	type: TYPE_A
			-- Type of `locals'.

	written_class: CLASS_C
			-- Class where the type `type' is written.

	written_feature: FEATURE_I
			-- Feature where the type `type' is written.

	locals: ITERABLE [INTEGER_32]
			-- List of unused local variables.

	token_list: LEAF_AS_LIST
			-- List of tokens.

feature {AST_EIFFEL} -- Visitor

	process_local_dec_list_as (a: LOCAL_DEC_LIST_AS)
			-- <Precursor>
		local
			t: AST_TYPE_OUTPUT_STRATEGY
			y: YANK_STRING_WINDOW
			u: UTF_CONVERTER
		do
			if attached a.locals as l then
					-- Iterate over all local declarations.
				from
					l.start
				until
					l.after
				loop
						-- Look only at the local declarations without type.
						-- Check that all local names are in `locals'.
					if not attached l.item.type and then
						across l.item.id_list as i all
							across locals as j all j.item = i.item end
						end
					then
						create y.make
						create t
						t.process (type, y, written_class, written_feature)
						l.item.append_text (": " + u.string_32_to_utf_8_string_8 (y.stored_output), token_list)
					end
						-- Advance to the next declaration.
					l.forth
				end
			end
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

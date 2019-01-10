note
	description	: "Stone representing an eiffel feature, local or argument stone."
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_ID_STONE

inherit
	AST_STONE
		rename
			make as ast_stone_make,
			make_class_c as class_stone_make
		redefine
			is_valid, synchronized_stone,
			history_name, same_as, origin_text, header, stone_signature,
			file_name,
			stone_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_class_c: CLASS_C; a_ast: detachable AST_EIFFEL)
		do
			ast_stone_make (a_class_c, a_ast)
			set_stone_cursor (cursors.cur_metric_local)
			set_x_stone_cursor (cursors.cur_x_metric_local)
		end

feature -- Access

	local_name: STRING_32
			-- Variable name.
		do
			if attached {ACCESS_AS} ast as l_access then
				Result := l_access.access_name_32
			else
				create Result.make_from_string_general (class_name)
				Result.append (".???")
			end
		end

	history_name: STRING_32
			-- Name used in the history list
		local
			s: STRING_32
		do
			create s.make_from_string (Interface_names.s_local_stone)
			s.append_string (local_name)
			Result := interface_names.l_from (s, Precursor {AST_STONE})
		end

	stone_name: READABLE_STRING_32
			-- Name of Current stone
		do
			if is_valid then
				Result := Precursor {AST_STONE} + ":local=" + local_name
			else
				Result := Precursor {AST_STONE}
			end
		end

feature -- Status report

	same_as (other: STONE): BOOLEAN
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same local from same feature?
		do
			Result := attached {ACCESS_ID_STONE} other as other_stone and then
					Precursor {AST_STONE} (other_stone) and then local_name.same_string (other_stone.local_name)
		end

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			Result := local_name /= Void and then Precursor {AST_STONE}
		end

feature -- dragging

	origin_text: STRING
			-- Text of the feature
		do
			Result := Precursor {AST_STONE}
		end

	file_name: like {ERROR}.file_name
			-- The one from class origin of `e_feature'
		do
			Result := Precursor {AST_STONE}
		end

	stone_signature: STRING_32
			-- Signature of Current feature
		do
			Result := Precursor {AST_STONE}
		end

	header: STRING_GENERAL
			-- Name for the stone.
		do
			Result := Precursor {AST_STONE}
		end


	update
			-- Update current feature stone.
		do
		end

	synchronized_stone: CLASSI_STONE
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			if e_class /= Void then
				create {ACCESS_ID_STONE} Result.make (e_class, ast)
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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

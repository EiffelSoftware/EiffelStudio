note
	date: "$Date$"
	revision: "$Revision$"

class
	ACCESS_ID_FEATURE_STONE

inherit
	ACCESS_ID_STONE
		redefine
			is_valid, synchronized_stone,
			history_name, same_as, origin_text, header, stone_signature,
			file_name,
			stone_name,
			update
		end

	FEATURE_STONE
		rename
			make as feature_stone_make
		undefine
			stone_cursor, x_stone_cursor
		redefine
			is_valid, synchronized_stone,
			history_name, same_as, origin_text, header, stone_signature,
			file_name,
			stone_name,
			line_number,
			update
		end


create
	make_with_feature

feature {NONE} -- Initialization

	make_with_feature (a_feature: E_FEATURE; a_ast: detachable AST_EIFFEL)
		do
			feature_stone_make (a_feature)
			make (a_feature.written_class, a_ast)
		end

	history_name: STRING_32
			-- Name used in the history list
		local
			s: STRING_32
		do
			create s.make_from_string (Interface_names.s_local_stone)
			s.append_string (local_name)
			Result := interface_names.l_from (s, Precursor {FEATURE_STONE})
		end

	stone_name: READABLE_STRING_32
			-- Name of Current stone
		do
			if is_valid then
				Result := Precursor {FEATURE_STONE} + ":local=" + local_name
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

feature -- Status report

	same_as (other: STONE): BOOLEAN
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same local from same feature?
		do
			Result := attached {ACCESS_ID_FEATURE_STONE} other as other_stone and then
					Precursor {ACCESS_ID_STONE} (other_stone) and then
					Precursor {FEATURE_STONE} (other_stone) and then
					local_name.same_string (other_stone.local_name)
		end

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			Result := local_name /= Void and then
				Precursor {ACCESS_ID_STONE} and then
				Precursor {FEATURE_STONE}
		end

feature -- Access

	associated_text: detachable STRING_32

feature -- Change	

	set_associated_text (s: detachable READABLE_STRING_GENERAL)
		do
			if s = Void then
				associated_text := Void
			else
				associated_text := s.to_string_32
			end
		end

feature -- dragging

	origin_text: STRING_32
			-- Text of the feature
		do
			Result := Precursor {ACCESS_ID_STONE}
		end

	file_name: like {ERROR}.file_name
			-- The one from class origin of `e_feature'
		do
			Result := Precursor {ACCESS_ID_STONE}
		end

	stone_signature: STRING_32
			-- Signature of Current feature
		do
			Result := Precursor {ACCESS_ID_STONE}
		end

	header: STRING_GENERAL
			-- Name for the stone.
		do
			Result := Precursor {ACCESS_ID_STONE}
		end

	line_number: INTEGER
			-- Line number of local text
		do
			update
			Result := internal_start_line_number
		end

	update
			-- Update current feature stone.
		do
			if
				internal_start_position = -1 and then
				e_feature /= Void
			then
					-- Position has not been initialized
				if attached ast as l_loc_ast then
					internal_start_position := l_loc_ast.character_start_position
					internal_end_position := l_loc_ast.character_end_position
					internal_start_line_number := l_loc_ast.start_location.line
				elseif
					not e_feature.is_il_external and then
					attached {FEATURE_AS} e_feature.ast as l_body_as
				then
					internal_start_position := l_body_as.character_start_position
					internal_end_position := l_body_as.character_end_position
					internal_start_line_number := l_body_as.start_location.line
				else
					internal_start_position := 1
					internal_end_position := 1
					internal_start_line_number := 1
				end
			end
		end

	synchronized_stone: detachable CLASSI_STONE
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			fok: BOOLEAN
		do
			if e_class /= Void then
				create {ACCESS_ID_STONE} Result.make (e_class, ast)

				if e_feature /= Void and then e_feature.is_valid then
					if attached e_feature.updated_version as new_e_feature then
						create {ACCESS_ID_FEATURE_STONE} Result.make_with_feature (new_e_feature, ast)
						fok := Result.is_valid
					end
				end
					-- Even if the feature has been removed or is now in a class out of the system,
					-- we try to create a valid Result.
				if not fok then
					Result := Precursor {ACCESS_ID_STONE}
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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

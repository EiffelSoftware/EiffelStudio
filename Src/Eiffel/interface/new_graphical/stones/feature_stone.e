indexing
	description	: "Stone representing an eiffel feature stone."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision $"

class
	FEATURE_STONE

inherit
	CLASSC_STONE
		rename
			make as class_stone_make
		redefine
			is_valid, synchronized_stone,
			history_name, same_as, origin_text, header, stone_signature,
			file_name, stone_cursor, x_stone_cursor,
			stone_name
		end

	SHARED_EIFFEL_PROJECT

	E_FEATURE_COMPARER
		export
			{NONE} all
		end

	SHARED_TEXT_ITEMS

create
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE) is
			-- Initialize feature stone.
		require
			a_feature_not_void: a_feature /= Void
		local
			l_feature: E_FEATURE
		do
			if a_feature.is_inline_agent then
				l_feature := a_feature.associated_feature_i.enclosing_feature.api_feature (a_feature.written_in)
			else
				l_feature := a_feature
			end
			class_stone_make (l_feature.written_class)
			e_feature := l_feature
			internal_start_position := -1
			internal_end_position := -1
			internal_start_line_number := -1
		end

feature -- Properties

	e_feature: E_FEATURE
		-- Feature associated with stone

	start_position: INTEGER is
			-- Start position of the feature in
			-- the origin file
		do
			update
			Result := internal_start_position
		end

	end_position: INTEGER is
			-- End position of the feature in
			-- the origin file
		do
			update
			Result := internal_end_position
		end

feature -- Access

	feature_name: STRING is
			-- Feature name of feature
		do
			check
				e_feature_not_void: e_feature /= Void
			end
			Result := e_feature.name
		end

	origin_name: STRING is
			-- Name of the feature in its written class.
		local
			f: E_FEATURE
		do
			if e_feature /= Void then
				f := e_feature.written_feature
				if f /= Void then
					Result := f.name
				else
					Result := e_feature.name
				end
			else
				Result := feature_name
			end
		end

	history_name: STRING_GENERAL is
			-- Name used in the history list
		do
			Result := interface_names.l_from (Interface_names.s_feature_stone.as_string_32 + feature_name, e_class.class_signature)
		end

	stone_name: STRING_GENERAL is
			-- Name of Current stone
		do
			if is_valid then
				Result := class_i.name + ti_dot + feature_name
			else
				Result := Precursor
			end
		end

feature -- Status report

	same_as (other: STONE): BOOLEAN is
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same feature?
		do
			Result := {fns: FEATURE_STONE} other and then same_feature (e_feature, fns.e_feature)
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := e_feature /= Void and then e_feature.is_valid and then Precursor {CLASSC_STONE}
		end

feature -- dragging

	origin_text: STRING is
			-- Text of the feature
		local
			temp: STRING
		do
			if e_feature /= Void then
				Result := "-- Version from class: "
				Result.append (e_feature.written_class.name_in_upper)
			else
				Result := feature_name.twin
			end
			Result.append ("%N%N%T")

			temp := Precursor {CLASSC_STONE}

			if temp /= Void then
				if
					temp.count >= end_position and
					start_position < end_position
				then
					temp := temp.substring (start_position + 1, end_position)
					Result.append (temp)
				end
			end
			Result.append ("%N")
		end

	file_name: FILE_NAME is
			-- The one from class origin of `e_feature'
		do
			if e_feature /= Void and then e_feature.is_valid then
				create Result.make_from_string (e_feature.written_class.file_name)
			end
		end

	stone_signature: STRING is
			-- Signature of Current feature
		do
			check
				e_feature_not_void: e_feature /= Void
			end
			Result := e_feature.feature_signature
		end

	header: STRING_GENERAL is
			-- Name for the stone.
		local
			l_feature_name: STRING_32
			l_file_name: FILE_NAME
		do

			create l_feature_name.make (20)
			l_feature_name.append ("{")
			l_feature_name.append (e_class.name_in_upper)
			l_feature_name.append ("}.")
			l_feature_name.append (feature_name)
			if class_i /= Void then
				l_file_name := class_i.file_name
			end

			if not e_class.is_precompiled then
				Result := interface_names.l_feature_header (eiffel_system.name,
															eiffel_universe.target_name,
															e_class.group.name,
															l_feature_name,
															l_file_name)
			else
				Result := interface_names.l_feature_header_precompiled (eiffel_system.name,
															eiffel_universe.target_name,
															e_class.group.name,
															l_feature_name)
			end

		end

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor representing `Current' when dropping is allowed.
		once
			Result := Cursors.cur_feature
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor representing `Current' when dropping is forbidden.
		once
			Result := Cursors.cur_X_feature
		end

	line_number: INTEGER is
			-- Line number of feature text
		require
			is_valid: is_valid
		do
			update
			Result := internal_start_line_number
		end

	update is
			-- Update current feature stone.
		do
			if internal_start_position = -1 and then e_feature /= Void then
					-- Position has not been initialized
				if not e_feature.is_il_external and then {l_body_as: FEATURE_AS} e_feature.ast then
					internal_start_position := l_body_as.start_position
					internal_end_position := l_body_as.end_position
					internal_start_line_number := l_body_as.start_location.line
				else
					internal_start_position := 1
					internal_end_position := 1
					internal_start_line_number := 1
				end
			end
		end

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_e_feature: like e_feature
			fok: BOOLEAN
		do
			if e_class /= Void then
				if e_feature /= Void then
					new_e_feature := e_feature.updated_version
					if new_e_feature /= Void then
						create {FEATURE_STONE} Result.make (new_e_feature)
						fok := Result.is_valid
					end
				end
					-- Even if the feature has been removed or is now in a class out of the system,
					-- we try to create a valid Result.
				if not fok then
					create {CLASSC_STONE} Result.make (e_class)
					Result := Result.synchronized_stone
				end
			end
		end

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := e_class.name.hash_code
		end

feature {NONE} -- Implementation

	internal_start_position: INTEGER
			-- Start position for feature

	internal_end_position: INTEGER
			-- End position for feature

	internal_start_line_number: INTEGER;
			-- Line number of `internal_start_position'.

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

end -- class FEATURE_STONE

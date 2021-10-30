note
	description: "[
		Handles icon resource managment, preventing duplication of loaded resources.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_PIXMAP_RESOURCE_HANDLER

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the resource handler.
		do
			create matrices.make (10)
		end

feature {NONE} -- Access

	matrices: STRING_TABLE [EV_PIXEL_BUFFER]
			-- Table of loaded matrices.
			--
			-- Key: Matrix file name, sans extension.
			-- Value: The matrix loaded from the given file name.

	pixmap_file_extension: STRING
			-- File extension of EiffelStudio pixmap files
		once
			Result := "png"
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
		end

feature -- Query

	matrix_file_name (a_name: READABLE_STRING_GENERAL): PATH
			-- Retrieves the actual file name for a moniker name.
			--
			-- `a_name': A moniker or a file name sans extension.
			-- `Result': A generated file name to a matrix image file.
		require
			not_a_name_is_empty: a_name /= Void and then not a_name.is_empty
		do
			Result := eiffel_layout.bitmaps_path.
				extended (pixmap_file_extension).
				extended (a_name).
				appended_with_extension (pixmap_file_extension)
		ensure
			not_result_is_empty: Result /= Void and then not Result.is_empty
		end

	retrieve_matrix (a_name: READABLE_STRING_GENERAL): detachable EV_PIXEL_BUFFER
			-- Attempts to retrieve a matrix from a given file name or other moniker.
			--
			-- `a_name': A file name, without extension, or another moniker used to load a pixmap file.
			-- `Result': A loaded
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_matrices: like matrices
		do
			l_matrices := matrices
			if l_matrices.has (a_name) then
				Result := l_matrices.item (a_name)
			end

			if Result = Void then
				Result := retrieve_matrix_at_location (matrix_file_name (a_name), a_name)
			end
		ensure
			not_result_is_destroyed: attached Result implies not Result.is_destroyed
			matrices_has_a_name: attached Result implies matrices.has (a_name)
		end

	retrieve_matrix_at_location (a_location: PATH; a_optional_name: detachable READABLE_STRING_GENERAL): detachable EV_PIXEL_BUFFER
			-- Attempts to retrieve a matrix from location `a_location`, and cache it as `a_location.name` or `a_optional_name` if set.
			--
			-- `a_location`: a path name used to load a pixmap file.
			-- `a_optional_name`: the name to use when caching in `matrices`.
			-- `Result`: the loaded pixmap matrix.
		require
			not_a_location_is_empty: not a_location.is_empty
			a_optional_name_void_or_not_empty: a_optional_name = Void or else not a_optional_name.is_empty
		local
			l_matrices: like matrices
			l_file_name: like matrix_file_name
			l_matrix_name: READABLE_STRING_GENERAL
			l_buffer: EV_PIXEL_BUFFER
			u: FILE_UTILITIES
		do
			l_matrices := matrices
			if a_optional_name /= Void then
				l_matrix_name := a_optional_name
			else
				l_matrix_name := a_location.name
			end
			if l_matrices.has (l_matrix_name) then
				Result := l_matrices.item (l_matrix_name)
			end

			if Result = Void then
					-- Load the pixmap file from disk, if it exists
				l_file_name := a_location
				if attached eiffel_layout.user_priority_file_name (l_file_name, True) as l_user_file_name then
						-- The user has replaced the pixmaps.
					l_file_name := l_user_file_name
				end
				if u.file_path_exists (l_file_name) then
					create l_buffer
					l_buffer.set_with_named_path (l_file_name)

						-- Ensure only successful loads are cached!
					l_matrices.force (l_buffer, l_matrix_name)
					Result := l_buffer
				end
			end
		ensure
			not_result_is_destroyed: attached Result implies not Result.is_destroyed
			matrices_has_a_location: attached Result implies matrices.has (if a_optional_name /= Void then a_optional_name else a_location.name end)
		end

invariant
	matrices_attached: attached matrices

;note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

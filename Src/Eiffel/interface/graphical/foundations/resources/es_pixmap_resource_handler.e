indexing
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
	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

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
			create matrices.make_default
		end

feature {NONE} -- Access

	matrices: !DS_HASH_TABLE [!EV_PIXEL_BUFFER, !STRING]
			-- Table of loaded matrices.
			--
			-- Key: Matrix file name, sans extension.
			-- Value: The matrix loaded from the given file name.

	pixmap_file_extension: !STRING
			-- File extension of EiffelStudio pixmap files
		once
			Result := "png"
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Query

	matrix_file_name (a_name: !STRING): !STRING
			-- Retrieves the actual file name for a moniker name.
			--
			-- `a_name': A moniker or a file name sans extension.
			-- `Result': A generated file name to a matrix image file.
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_file_name: !FILE_NAME
		do
			create l_file_name.make_from_string (eiffel_layout.bitmaps_path)
			l_file_name.extend (pixmap_file_extension)
			l_file_name.set_file_name (a_name)
			l_file_name.add_extension (pixmap_file_extension)
			Result ?= l_file_name.string
		ensure
			not_result_is_empty: not Result.is_empty
		end

	retrieve_matrix (a_name: !STRING): ?EV_PIXEL_BUFFER
			-- Attempts to retrieve a matrix from a given file name or other moniker.
			--
			-- `a_name': A file name, sans extension, or another moniker used to load a pixmap file.
			-- `Result': A loaded
		require
			not_a_name_is_empty: not a_name.is_empty
		local
			l_matrices: !like matrices
			l_file_name: !STRING
			l_buffer: !EV_PIXEL_BUFFER
		do
			l_matrices := matrices
			if l_matrices.has (a_name) then
				Result := l_matrices.item (a_name)
			end

			if Result = Void then
					-- Load the pixmap file from disk, if it exists
				l_file_name := matrix_file_name (a_name)
				if {l_user_file_name: FILE_NAME} eiffel_layout.user_priority_file_name (l_file_name, True) then
						-- The user has replaced the pixmaps.
					l_file_name := l_user_file_name
				end
				if file_system.file_exists (l_file_name) then
					create l_buffer
					l_buffer.set_with_named_file (l_file_name)

						-- Ensure only successful loads are cached!
					l_matrices.force_last (l_buffer, a_name)
					Result := l_buffer
				end
			end
		ensure
			not_result_is_destroyed: Result /= Void implies not Result.is_destroyed
			matrices_has_a_name: Result /= Void implies matrices.has (a_name)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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


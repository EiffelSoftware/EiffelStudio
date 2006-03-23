indexing
	description: "Objects that provide common routines for pixmap handling."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PIXMAP_HANDLER

feature -- Status report		

	valid_file_extension (extension: STRING): BOOLEAN is
			-- Is `extension' a valid file format for
			-- a pixmap on the current platform?
		require
			extension_length_3: extension.count = 3
		do
			Result := environment.supported_image_formats.has (extension.as_upper)
		end

	invalid_type_warning: STRING is
			-- `Result' is message informing of the valid
			-- file types supported.
		local
			types: LINEAR [STRING_32]
			arrayed: ARRAYED_LIST [STRING]
			counter: INTEGER
		do
			Result := "File type not supported. "--unsupported_pixmap_type
			types := environment.supported_image_formats

				-- We must convert the LINEAR into an ARRAYED_LIST, as otherwise
				-- we cannot check to see if we are before the final position.
				-- This must be done so that we can correctly build the text formatting.
			create arrayed.make (3)
			from
				types.start
			until
				types.off
			loop
				arrayed.extend (types.item)
				types.forth
			end
				-- Now add supported types to `Result'.
			from
				counter := 1
			until
				counter > arrayed.count
			loop
				Result.append (arrayed.i_th (counter))
				if counter + 1 < arrayed.count  then
					Result.append (", ")
				elseif counter + 1 = arrayed.count then
					Result.append (" and ")
				end
				counter := counter + 1
			end
			Result.append (" types supported.")
		ensure
			Result_not_void: Result /= Void
			Result_not_empty: not Result.is_empty
		end

feature {NONE} -- Implementation

	environment: EV_ENVIRONMENT is
			-- Access to Vision2 Environment class.
		deferred
		end

indexing
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


end -- class GB_EV_PIXMAP_HANDLER

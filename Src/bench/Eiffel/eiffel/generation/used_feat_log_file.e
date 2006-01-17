indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class USED_FEAT_LOG_FILE

inherit
	PLAIN_TEXT_FILE

create
	make

feature

	add (class_type: CLASS_TYPE; feature_name, encoded_name: STRING) is
			-- Add `class_type', `feature_name' and `encoded_name' in TRANSLAT file.
		require
			class_type_not_void: class_type /= Void
			feature_name_not_void: feature_name /= Void
			encoded_name_not_void: encoded_name /= Void
		local
			s: GENERATION_BUFFER
		do
			put_string (class_type.associated_class.cluster.cluster_name)
			put_character ('%T')
			create s.make (128)
			class_type.type.dump (s)
			s.put_in_file (Current)
			put_character ('%T')
			put_string (feature_name)
			put_character ('%T')
			put_string (encoded_name)
			put_character ('%T')
			put_string (class_type.relative_file_name)
			put_new_line
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

end


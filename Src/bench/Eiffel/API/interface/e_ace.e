indexing

	description:
		"Ace description of System."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class E_ACE

inherit

	SHARED_WORKBENCH

feature -- Properties

	file_name: STRING is
			-- Path to the universe/system description
		do
			Result := Lace.file_name
		end

feature -- Access
	date_has_changed: BOOLEAN is
			-- Has the date changed for the lace file
		do
			Result := Lace.date_has_changed
		end

	successful: BOOLEAN is
			-- Was the last compilation of the Ace file successful?
		do
			Result := Lace.successful
		end

	text: STRING is
			-- Text of the Lace file.
			-- Void if unreadable file
		require
			non_void_file_name: file_name /= Void
		local
			a_file: RAW_FILE
		do
			create a_file.make (file_name)
			if a_file.exists and then a_file.is_readable then
				a_file.open_read
				a_file.read_stream (a_file.count)
				a_file.close
				Result := a_file.last_string.twin
			end
		end

	valid_file_name (f_name: STRING): BOOLEAN is
			-- Is `f_name' a valid file name (i.e
			-- does it exist and is it readable)?
		require
			valid_f_name: f_name /= Void
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make (f_name);
			Result := f.exists and then f.is_readable
		end

feature -- Setting

	set_file_name (f_name: STRING) is
			-- Set lace_file_name to `f_name'.
		do
			if f_name /= Void then
				Lace.set_file_name (f_name)
			end
		ensure
			file_name_set: f_name /= Void implies equal (f_name, file_name)
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

end -- class E_ACE

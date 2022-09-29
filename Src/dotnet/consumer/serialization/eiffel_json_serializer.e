note
	description: "Store objects."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EIFFEL_JSON_SERIALIZER

inherit
	EIFFEL_SERIALIZER

	SHARED_LOGGER
		export
			{NONE} all
		undefine
			default_create
		end

feature -- Serialization

	last_file_position: INTEGER

	successful: BOOLEAN

	error_message: detachable STRING_32
			-- Reason for failure

	serialize (a: ANY; path: READABLE_STRING_GENERAL; is_appending: BOOLEAN)
		local
			v: CONSUMED_OBJECT_TO_JSON
			sav: JSON_TO_FILE
			f: RAW_FILE
			p: PATH
			err: STRING_32
			retried: BOOLEAN
		do
			if not retried then
				error_message := Void
				successful := True

				create v.make
--				create {CONSUMED_OBJECT_TO_JSON_DBG} v.make
				
				if attached v.to_json (a) as j then
					create p.make_from_string (path)
					create f.make_with_path (p)
					if f.exists and is_appending then
						open_file_appended (f)
					else
						f.create_read_write
					end
					create sav.make (f)
					j.accept (sav)
					f.put_new_line
					f.flush
					f.close
					last_file_position := f.count
					successful := True
				else
					successful := False
					error_message := {STRING_32} "No JSON serialization for object"
				end
			else
				successful := False
				create err.make (path.count + 20)
				err.append_string_general ("Cannot store into ")
				err.append_string_general (path)
				error_message := err
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	open_file_appended (f: FILE)
			-- Open file `f`, and retry max 5 times,
			-- in case the file is locked temporary by the OS.
		local
			retried: INTEGER
		do
			if retried < 5 then
				if retried > 0 then
					(create {EXECUTION_ENVIRONMENT}).sleep (10_000_000)
				end
				f.open_append
				f.finish
			end
		rescue
			retried := retried + 1
			retry
		end

note
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


end

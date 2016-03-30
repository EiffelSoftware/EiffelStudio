note
	description: "Summary description for {ES_CACHE_UTILITIES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CACHE_UTILITIES

inherit
	ANY

	EIFFEL_LAYOUT
		export
			{NONE} all
			{ANY} is_eiffel_layout_defined
		end

feature -- Helper		

	cached_data (a_name: READABLE_STRING_GENERAL): detachable ANY
		local
			p: PATH
			f: RAW_FILE
			retried: BOOLEAN
			sed: SED_STORABLE_FACILITIES
			sed_rw: SED_MEDIUM_READER_WRITER
			l_deserializer: detachable SED_RECOVERABLE_DESERIALIZER
		do
			if not retried then
				p := eiffel_layout.temporary_path.extended (a_name)
				create f.make_with_path (p)
				if f.exists and then f.is_readable then
					f.open_read
					create sed
					create sed_rw.make_for_reading (f)
						--| Read only if it is a "recoverable" storable file.
						--| and thus, avoid trying to load old data stored
						--| using basic_store ...
					sed_rw.read_header
					if sed_rw.read_natural_32 = sed.eiffel_recoverable_store then
						create l_deserializer.make (sed_rw)
						l_deserializer.decode (False)
						if not l_deserializer.has_error then
							Result := l_deserializer.last_decoded_object
							sed_rw.read_footer
						end
					end
					f.close
				end
			end
		rescue
			retried := True
			retry
		end

	cache_data (a_data: detachable ANY; a_name: READABLE_STRING_GENERAL)
		local
			p: PATH
			f: RAW_FILE
			retried: BOOLEAN
			sed: SED_STORABLE_FACILITIES
			sed_rw: SED_MEDIUM_READER_WRITER
		do
			if not retried then
				p := eiffel_layout.temporary_path.extended (a_name)
				create f.make_with_path (p)
				if a_data /= Void then
					if f.exists and then not f.is_writable then
							-- Ignored but should not occured.
						check False end
					else
						f.create_read_write
						create sed
						create sed_rw.make_for_writing (f)
						sed.store (a_data, sed_rw)
						f.close
					end
				else
					if f.exists then
						f.delete
					end
				end
			end
		rescue
			retried := True
			retry
		end

	cache_date (a_name: READABLE_STRING_GENERAL): detachable DATE_TIME
		local
			p: PATH
			f: RAW_FILE
		do
			p := eiffel_layout.temporary_path.extended (a_name)
			create f.make_with_path (p)
			if f.exists then
				create Result.make_from_epoch (f.date)
			end
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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

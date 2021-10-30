note
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LIBRARY_INDEX_PROVIDER

inherit
	ES_LIBRARY_PROVIDER

	EIFFEL_LAYOUT
		export
			{NONE} all
			{ANY} is_eiffel_layout_defined
		end

	CONF_VALIDITY

feature -- Access

	identifier: STRING = "index"
			-- Provider identifier.

	description: detachable READABLE_STRING_32
			-- Optional description
		do
			Result := {STRING_32} "Search in library indexed information (including by class name)."
		end

	libraries (a_query: detachable READABLE_STRING_32; a_target: CONF_TARGET): ARRAYED_LIST [ES_LIBRARY_PROVIDER_ITEM]
		local
			q: LIBRARY_DATABASE_CLASS_QUERY
			elt: ES_LIBRARY_PROVIDER_ITEM
			l_info: LIBRARY_INFO
		do
			if
				attached class_query_from (a_query) as s and then
				attached library_index as db
			then
				create q.make (db, s)
				q.execute
				create Result.make (q.items.count)
				across
					q.items as ic
				loop
					l_info := @ ic.key
					create elt.make (1.0, l_info, l_info.name + " (" + l_info.uuid.out + ")")
					elt.set_info (ic, "classes")
					Result.force (elt)
				end
			else
				create Result.make (0)
			end
		end

	class_query_from (q: detachable READABLE_STRING_32): detachable STRING_32
		do
			if attached q then
				create Result.make_from_string (q)
				Result.adjust
				if Result.is_empty then
					Result := Void
				elseif Result.starts_with ("class:") then
						-- FIXME: check it is a simple query (not an expression).
					Result.remove_head (6)
				elseif Result.starts_with ("class=") then
						-- FIXME: check it is a simple query (not an expression).
					Result.remove_head (6)
				end
			end
		end

	library_index_location: PATH
		do
			if is_eiffel_layout_defined then
				Result := eiffel_layout.temporary_path
			else
				create Result.make_current
			end
			Result := Result.extended ("libraries_index.db")
		end

	library_index: detachable LIBRARY_DATABASE
		local
			ctx: LIBRARY_DATABASE_CONTEXT
			dbm: LIBRARY_DATABASE_MANAGER
			dbr: LIBRARY_DATABASE_READER
			dbw: LIBRARY_DATABASE_WRITER
			fn: PATH
		do
			create ctx.make
			ctx.use_any_settings (True)
			if is_eiffel_layout_defined then
				fn := library_index_location
				create dbr
				dbr.read (fn, ctx)
				Result := dbr.last_database
				dbr.reset
				if Result = Void then
					create Result.make (ctx)
					create dbm.make_with_database (Result)
						-- Per library, we want only system classes (not all subclasses).
					dbm.set_is_stopping_at_library (True)
					dbm.set_is_indexing_class (True)

					dbm.import_folders (<<
								eiffel_layout.library_path,
								eiffel_layout.eiffel_library.extended ("contrib").extended ("library"),
								eiffel_layout.eiffel_library.extended ("unstable").extended ("library")
							>>,
							True
						)
					create dbw
					dbw.set_variable (eiffel_layout.eiffel_library.name, "ISE_LIBRARY")
					dbw.store (Result, fn)
				end
			end
		end

	updated_date (a_target: CONF_TARGET): detachable DATE_TIME
			-- Date of last update.
		local
			f: RAW_FILE
		do
			create f.make_with_path (library_index_location)
			if f.exists then
				create Result.make_from_epoch (f.date)
			end
		end

feature -- Reset

	reset (a_target: CONF_TARGET)
		local
			f: RAW_FILE
		do
			create f.make_with_path (library_index_location)
			if f.exists and then f.is_access_writable then
				f.delete
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
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

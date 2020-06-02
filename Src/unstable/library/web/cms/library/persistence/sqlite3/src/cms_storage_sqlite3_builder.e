note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_STORAGE_SQLITE3_BUILDER

inherit
	CMS_STORAGE_SQL_BUILDER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
		end

feature -- Factory

	storage (cfg: DATABASE_CONFIGURATION; a_setup: CMS_SETUP; a_error_handler: ERROR_HANDLER): detachable CMS_STORAGE_SQLITE3
		local
			s: detachable READABLE_STRING_32
			p: PATH
			conn: detachable SQLITE_DATABASE
			l_source: SQLITE_FILE_SOURCE
			i,j: INTEGER
		do
			if cfg.driver.is_case_insensitive_equal ("sqlite3") then
				s := cfg.database_string
				i := s.substring_index ("Database=", 1)
				if i > 0 then
					i := s.index_of ('=', i) + 1
					j := s.index_of (';', i)
					if j = 0 then
						j := s.count + 1
					end
					create p.make_from_string (s.substring (i, j - 1))
				else
					create p.make_from_string (s)
				end

				if attached reuseable_connection.item as d then
					conn := d.conn
					if
						cfg.is_connection_reusable and
						p.same_as (d.path)
					then
							-- Keep `conn`
					else
						conn.close
						conn := Void
						reuseable_connection.replace (Void)
					end
				end
				if conn = Void or else conn.is_closed then
					create l_source.make (p.name)
					create conn.make (l_source)
					if l_source.exists then
						conn.open_read_write
					else
						conn.open_create_read_write
					end
				end
				if not conn.is_closed then
					conn.set_busy_timeout (1_000) -- FIXME

					create Result.make (conn)
					if cfg.is_connection_reusable then
						Result.set_is_reuseable (True)
						reuseable_connection.replace ([p, conn])
					end

--						set_map_zero_null_value (False)	--| This way we map 0 to 0, instead of Null as default.
					if Result.is_available then
						if not Result.is_initialized then
							initialize (a_setup, Result)
						end
					end
				else
					a_error_handler.add_custom_error (0, "Could not connect to the SQLITE3 storage", Void)
				end
			else
				-- Wrong mapping between storage name and storage builder!
				a_error_handler.add_custom_error (0, "Wrong mapping between storage and builder!", Void)
			end
		end

	reuseable_connection: CELL [detachable TUPLE [path: PATH; conn: SQLITE_DATABASE]]
		once
			create Result.put (Void)
		end

end

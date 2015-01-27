note
	description: "Object that represent Database configuration settings"
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_CONFIGURATION

create
	make

feature {NONE} -- Initialization

	make (a_driver: READABLE_STRING_32; a_connection: READABLE_STRING_32)
			-- Create a database configuration setting: `driver' with `a_driver',
			-- `database_string' with `a_connection'.
		do
			driver := a_driver
			database_string := a_connection
		ensure
			driver_set: driver = a_driver
			server_set: database_string = a_connection
		end

feature -- Access

	driver: READABLE_STRING_32
			--Database driver.

	database_string: READABLE_STRING_32
			-- Database connection.	

	connection_string: READABLE_STRING_32
			-- Connection string
		do
			Result := "Driver={" + driver + "};" + database_string
		end

	item (a_param: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		local
			s: READABLE_STRING_32
			lower_s: READABLE_STRING_32
			i,j: INTEGER
			k: STRING_32
		do
			create k.make_from_string_general (a_param)
			k.to_lower

			s := database_string
			lower_s := s.as_lower
			i := lower_s.substring_index (k + {STRING_32} "=", 1)
			if i > 0 then
				if i = 1 or else s[i-1] = ';' then
					j := s.index_of (';', i + k.count + 1)
					if j = 0 then
						j := s.count + 1
					end
					Result := s.substring (i + k.count + 1, j - 1)
				end
			end
		end

	server_name: detachable READABLE_STRING_32
		do
			Result := item ("Server")
		end

	port: INTEGER
		do
			if
				attached item ("Port") as l_port and then
				l_port.is_integer
			then
				Result := l_port.to_integer
			end
		end

	database_name: detachable READABLE_STRING_32
		do
			Result := item ("Database")
		end

	user_id: detachable READABLE_STRING_32
		do
			Result := item ("Uid")
		end

	user_password: detachable READABLE_STRING_32
		do
			Result := item ("Pwd")
		end


note
	copyright: "2011-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

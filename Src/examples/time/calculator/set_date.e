note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	SET_DATE

inherit
    COMMAND_DATE

feature -- Access

    execute (d: DATE): DATE
            -- Date choosen par user
		local
			year, month: INTEGER
        do
            Result := d
			print (display_help)
			print ("%Nyear: ")
			io.read_integer
			year:= io.last_integer
			print ("month: ")
			io.read_integer
			month:= io.last_integer
			print ("day: ")
 			io.read_integer
			Result.make (year, month, io.last_integer)
        end

    display_help: STRING
        do
            Result := "Enter new year then new month and new day"
        end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

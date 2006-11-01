indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class CONTROL_ACTION 

inherit 

	ACTION
		redefine start,execute
	end

	SHARED_CURSOR

feature

		
    start is
        do
			io.putstring("Beginning action")
        end

    execute is
		local
			one_object : MT_OBJECT
        do
			one_object ?= one_cursor.data
			io.putstring("Handling object #") io.putint(one_object.oid) io.new_line
        end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CONTROL_ACTION


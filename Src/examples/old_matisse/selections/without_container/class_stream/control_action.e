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

end -- class CONTROL_ACTION

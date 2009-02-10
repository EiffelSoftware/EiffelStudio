indexing
	metadata: create {OBSOLETE_ATTRIBUTE}.make () end
		
class TEST

create
	make

feature {NONE} -- Initialization

	make is
			-- Run test.
		local
			o: SYSTEM_OBJECT
		do
			o := Current
			print (o.get_type.get_custom_attributes_type ({OBSOLETE_ATTRIBUTE}, true))
			io.put_new_line
		end

end

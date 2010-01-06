indexing
	metadata: 
		create {A}.make [
			["property", "Success"]
		] end
		
class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_asm: ASSEMBLY
			l_attributes: NATIVE_ARRAY [NATIVE_ATTRIBUTE]
			l_attribute: A
			l_count, i: INTEGER
		do
			l_attributes := {NATIVE_ATTRIBUTE}.get_custom_attributes (({TEST}).to_cil, {A})
			if l_attributes /= Void and then l_attributes.count > 0 then
				l_count := l_attributes.count 
				from i := 0 until i = l_count loop
					l_attribute ?= l_attributes.item (0)
					if l_attribute /= Void then
						print (l_attribute.property)
						print ("%N")
					end
					i := i + 1
				end
			end			
		end

end

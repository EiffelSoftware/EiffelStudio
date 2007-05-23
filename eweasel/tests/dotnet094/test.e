indexing
	assembly_metadata: 
		create {ASSEMBLY_TITLE_ATTRIBUTE}.make ("Class TEST") end
class
	TEST

create
	make

feature {NONE} -- Initialization

	make is
		local
			l_asm: ASSEMBLY
			l_attributes: NATIVE_ARRAY [NATIVE_ATTRIBUTE]
			l_attribute: ASSEMBLY_TITLE_ATTRIBUTE
			l_count, i: INTEGER
		do
			l_attributes := {NATIVE_ATTRIBUTE}.get_custom_attributes ({ASSEMBLY}.get_executing_assembly, {ASSEMBLY_TITLE_ATTRIBUTE})
			if l_attributes /= Void and then l_attributes.count > 0 then
				l_count := l_attributes.count 
				from i := 0 until i = l_count loop
					l_attribute ?= l_attributes.item (0)
					if l_attribute /= Void then
						print (l_attribute.title)
						print ("%N")
					end
					i := i + 1
				end
			end			
		end
		
	a: A
		-- For inclusion
			
end

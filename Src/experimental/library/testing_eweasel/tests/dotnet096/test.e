indexing
	assembly_metadata: 
		create {DESCRIPTION_ATTRIBUTE}.make ("assembly: on assembly") end
		
	class_metadata:
		create {DESCRIPTION_ATTRIBUTE}.make ("on class") end
		
	interface_metadata:
		create {DESCRIPTION_ATTRIBUTE}.make ("on interface") end
		
	metadata:
		create {DESCRIPTION_ATTRIBUTE}.make ("on class and interface") end
	
class
	TEST

inherit
	BASE

create {TEST}
	default_create
	
create
	make

feature {NONE} -- Initialization

	make is
		local
			l_so: SYSTEM_OBJECT
			l_type: SYSTEM_TYPE
			l_type_impl: SYSTEM_TYPE
		do
			print ("Assembly%N")
				-- Print assembly
			print_descriptions ({ASSEMBLY}.get_executing_assembly)
		
			print ("%NInterface%N")
				-- Print interface
			l_type := {TEST}
			print_descriptions (l_type)
			print_member_descriptions (l_type.get_members)

			print ("%NImplementation%N")
				-- Print implementation
			l_so ?= (create {TEST})
			l_type_impl := l_so.get_type
			print_descriptions (l_so.get_type)
			print_member_descriptions (l_type_impl.get_members)
		end
		
	print_descriptions (a_provider: ICUSTOM_ATTRIBUTE_PROVIDER)
			-- Print descriptions
		require
			a_provider_attached: a_provider /= Void
		local
			l_attributes: NATIVE_ARRAY [SYSTEM_OBJECT]
			l_attribute: DESCRIPTION_ATTRIBUTE
			l_descriptions: NATIVE_ARRAY [SYSTEM_STRING]
			l_member_info: MEMBER_INFO
			l_type: SYSTEM_TYPE
			l_sb: STRING_BUILDER
			l_count, i: INTEGER
		do
			l_attributes := a_provider.get_custom_attributes ({DESCRIPTION_ATTRIBUTE}, False)
			if l_attributes /= Void then
				l_count := l_attributes.count

				l_member_info ?= a_provider
				if l_member_info /= Void then
					l_type ?= l_member_info
					if l_type = Void then
						l_type := l_member_info.declaring_type
					end
				end
				
				create l_descriptions.make (l_count)
				from i :=0 until i = l_count loop
					l_attribute ?= l_attributes.item (i)
					create l_sb.make (100)
					if l_member_info /= Void then
						
						if l_type/= Void then
							l_sb := l_sb.append (l_type.full_name)
						end
						l_sb := l_sb.append ("(")
						l_sb := l_sb.append (l_member_info.name)
						l_sb := l_sb.append ("): ")
					end
					l_sb := l_sb.append (l_attribute.description)
					l_descriptions.put (i, l_sb.to_string)
					i := i + 1
				end
				
				{SYSTEM_ARRAY}.sort (l_descriptions)
				from i :=0 until i = l_count loop
					print (l_descriptions.item (i))
					print ("%N")
					i := i + 1
				end
			end
		end
		
	print_member_descriptions (a_members: NATIVE_ARRAY [MEMBER_INFO])
		require
			a_members_attached: a_members /= Void
		local
			l_count, i: INTEGER
		do
			l_count := a_members.count
			from i := 0 until i = l_count loop
				print_descriptions (a_members.item (i))
				i := i + 1
			end
		end
		
feature -- Tests
		
	method: SYSTEM_STRING is
		indexing
			class_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class") end

			interface_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on interface") end

			metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class and interface") end
		do
		end
		
	property: SYSTEM_STRING assign set_property
		indexing
			property: auto
			class_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class attribute") end

			interface_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on interface attribute") end

			metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class and interface attribute") end
				
			property_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on property") end

				-- Currently not supported				
--			attribute_metadata:
--				create {DESCRIPTION_ATTRIBUTE}.make ("on attribute") end
		end
		
	set_property (a_property: like property)
		indexing
			class_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class") end

			interface_metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on interface") end

			metadata:
				create {DESCRIPTION_ATTRIBUTE}.make ("on class and interface") end
		do
		end

end

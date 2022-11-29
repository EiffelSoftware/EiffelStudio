note
	description: "[
		class to hold custom attributes.  only parses them at this point, so that
		you can retrieve attributes from .net assemblies if you want to.  if you
		want to generate them you are on your own.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_CUSTOM_ATTRIBUTE_CONTAINER

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
		do
			create attributes.make (0)
			create {ARRAYED_SET [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR]}descriptors.make (0)
		end


	attributes: HASH_TABLE [ LIST [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR], PE_CUSTOM_ATTRIBUTE]

	descriptors: SET [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR]
			-- To be checked
			-- it seems it's not used by the C++ code.
			--| C++ implementation uses a hash_set
			--| std::set<CustomAttributeDescriptor *, CustomAttributeDescriptor> descriptors;


feature -- Access

	lookup (a_attribute: PE_CUSTOM_ATTRIBUTE): LIST [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR]
		do
			fixme ("To be checked.")
			attributes.compare_objects
			if attached attributes.item (a_attribute) as l_result then
				Result := l_result
			else
				create {ARRAYED_LIST [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR]}Result.make (0)
			end
		end

	has (a_attribute: PE_CUSTOM_ATTRIBUTE; a_name: STRING_32; a_data: detachable ARRAY [NATURAL_8]; a_size: NATURAL_64): BOOLEAN
		do
			fixme ("To be checked")
			attributes.compare_objects
			if attached {LIST [CIL_CUSTOM_ATTRIBUTE_DESCRIPTOR]} attributes.item (a_attribute) as l_elements then
				across l_elements  as item loop
					if item.name.same_string_general (a_name) then
						if a_data = Void or else attached a_data as l_data and then (a_size = item.size and then attached item.data as t_data) and then
							l_data.same_items (t_data)
						then
							Result := True
						end
					end
				end
			end
		end

end

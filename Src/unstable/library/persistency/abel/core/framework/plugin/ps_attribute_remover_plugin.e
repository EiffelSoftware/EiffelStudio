note
	description: "Summary description for {PS_ATTRIBUTE_REMOVER_PLUGIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ATTRIBUTE_REMOVER_PLUGIN

inherit
	PS_PLUGIN

feature

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_TRANSACTION)
		do
		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_TRANSACTION): like args
		do
			Result := args
		end

	after_retrieve (object: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction:PS_TRANSACTION)
			-- Sort out all superfluous attributes, in case the backend didn't do it by itself.
		do
			across
				object.attributes.twin as attr
			loop
				if across attributes as attr2 all not attr.item.is_equal (attr2.item) end then
					object.remove_attribute (attr.item)
				end
			end
		end

end

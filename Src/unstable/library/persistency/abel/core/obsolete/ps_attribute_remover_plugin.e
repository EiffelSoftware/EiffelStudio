note
	description: "Removes all attributes which are not listed in the projection array."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_ATTRIBUTE_REMOVER_PLUGIN

inherit
	PS_PLUGIN

feature

	before_write (object: PS_BACKEND_OBJECT; transaction: PS_INTERNAL_TRANSACTION)
		do
		end

	before_retrieve (args: TUPLE[type: PS_TYPE_METADATA; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]]; transaction: PS_INTERNAL_TRANSACTION): like args
		do
			Result := args
		end

	after_retrieve (object: PS_BACKEND_OBJECT; criterion: detachable PS_CRITERION; attributes: PS_IMMUTABLE_STRUCTURE [STRING]; transaction:PS_INTERNAL_TRANSACTION)
			-- Sort out all superfluous attributes, in case the backend didn't do it by itself.
		do
--			across attributes as c from print ("in plugin%N") loop print ("filter: " + c.item + "%N")  end
			across
				object.attributes.twin as attr
			loop
				if
--					not attr.item.is_equal (object.root_key) and then
					across
						attributes as attr2
					all
						not attr.item.is_equal (attr2.item)
					end
				then
--					print ("attribute remover: " + attr.item + "%N")
					object.remove_attribute (attr.item)
				end
			end
		end

end

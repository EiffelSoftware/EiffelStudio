indexing
	description: "ARCH_EHCR defines ehcr archetype specifics."
	keywords:    "archetype"
	revision:    "%%A%%"
	source:	     "%%P%%"
	requirements:""

class ARCH_DEF_EHCR

inherit
	ARCH_DEFINITION

feature -- Status
        is_valid:BOOLEAN is
		do
			Result := True
		end

feature -- Initialisation
	create_prototypes is
		local
			a_db_item:DB_ITEM
		do
			-- INFO_ITEMs
			!EHCR!a_db_item.make("PROTOTYPE")	db_items.extend(a_db_item)
		end

	init_structures is
		do
		end

feature -- Output
	print_out is
		do
		end

end

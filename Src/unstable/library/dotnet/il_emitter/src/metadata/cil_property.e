note
	description: "[
	   A property, note we are only supporting classic properties here, not any
     * extensions that are allowed in the image file format
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_PROPERTY

create
	make

feature {NONE} -- Intialization

	make
		do
			create name.make_empty
			flags := Special_name
		end

feature -- Access

	parent: detachable CIL_DATA_CONTAINER
			-- The parent container (always a class).
			-- Add an invariant.

	instance: BOOLEAN
			-- It is an instance member or an static property.

	name: STRING_32

	type: detachable CIL_TYPE

	getter: detachable CIL_METHOD
			-- the getter

	setter: detachable CIL_METHOD
			-- the setter.

	flags: INTEGER

feature -- Enums

	Special_name: INTEGER = 0x200

    RT_special_name: INTEGER = 0x400

    Has_default: INTEGER = 0x1000


feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			
		end

end

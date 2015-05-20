note
	description: "The result of ANY.generating_type may be on the wrong processor, which can cause a deadlock."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make, make_type, default_create

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			type_creator: separate TEST
			other: separate TEST
		do
				-- Create the type object on a different processor.
			create type_creator.make_type
			sync (type_creator)

				-- Create another test instance and compare types.
			create other
			if get_type (other) = generating_type.type_id then
				print ("OK: Equal types.%N")
			else
				print ("ERROR: Different types.%N")
			end
		end

	make_type
			-- Make sure that the type object is created.
		do
			generating_type.out.do_nothing
		end

feature -- Basic operations

	sync (obj: separate ANY)
		do
			obj.out.do_nothing
		end

	get_type (obj: separate ANY): INTEGER
			-- Get the type id of 'obj'.
			-- This may deadlock when the type object returned by generating_type
			-- happens to be on a different processor than `obj'.
		do
			Result := obj.generating_type.type_id
		end

end

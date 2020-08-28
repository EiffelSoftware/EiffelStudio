note

	description: "Original values of the attributes of a mismatched object."
	instructions: "[
		This object will contain the original values of the attributes
		of a retrieved object for which a mismatched was detected at
		retrieval time. The value are indexed by the name of the attribute
		in the stored object. One extra entry is provided to contain the
		original name of the class in the storing system, indexed by the
		string 'class'. This allows `correct_mismatch' to determine the
		original name of its generating class in case class-name
		translation is in effect.
		]"
	date: "$Date$"
	revision: "$Revision$"
	status: "See notice at end of class"

class MISMATCH_INFORMATION

inherit

	HASH_TABLE [ANY, STRING]
		redefine
			default_create,
			out
		end

create

	default_create

feature -- Initialization

	default_create
			-- Make container with default size
		do
			make (5)
		end

	set_callback_pointers
			-- Sets call-back pointers in the run-time
		once
			set_mismatch_information_access (Current, $clear_all, $internal_put)
		end

feature -- Access

	class_name: STRING
			-- Name of generating class which held attribute values
		do
			check has_class_entry: has (Class_key) end
			Result ?= item (Class_key)
		ensure
			result_exists: Result /= Void
		end

feature -- Output

	out: STRING
			-- Printable representation of attributes values
		do
			from
				create Result.make (20 + class_name.count + 40 * count)
				Result.append ("Attributes of original class ")
				Result.append (class_name)
				Result.append (": ")
				Result.append_integer (count - 1)
				Result.append (" item")
				if count - 1 /= 1 then Result.append_character ('s') end
				Result.append_character ('%N')
				start
			until
				after
			loop
				if not key_for_iteration.is_equal (Class_key) then
					Result.append ("  ")
					Result.append (key_for_iteration)
					Result.append (": ")
					if item_for_iteration = Void then
						Result.append ("Void")
					else
						Result.append (item_for_iteration.out)
					end
					Result.append_character ('%N')
				end
				forth
			end
		end

feature {NONE} -- Implementation

	Class_key: STRING = "class"

	internal_put (value: ANY; ckey: POINTER)
			-- Allows run-time to insert items into table
		local
			key: STRING
		do
			create key.make_from_c (ckey)
			put (value, key)
		end

feature {NONE} -- Externals

	set_mismatch_information_access (obj: ANY; init, add: POINTER)
		external
			"C"
		end

note

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
--| Copyright (c) 1993-2006 University of Southern California and contributors.
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"


end

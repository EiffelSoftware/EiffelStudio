indexing
	description: "Style list representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_STYLE_LIST

inherit
	LINKED_LIST [TDS_STYLE]

creation
	make

feature	-- Query

	is_present (a_style: TDS_STYLE) : BOOLEAN is
			-- Is `a_style' present in the TDS_STYLE_LIST?
		require
			a_style_not_void: a_style /= Void
		local
			found: BOOLEAN
		do
			from
				start
			until
				after or found

			loop
				found := item.is_style_equal (a_style)
				forth
			end

			Result := found
		end

	is_almost_present (a_style: TDS_STYLE) : BOOLEAN is
			-- Is a part of `a_style' present in the TDS_STYLE_LIST?
		require
			a_style_not_void: a_style /= Void
		local
			found: BOOLEAN
		do
			from
				start
			until
				(after) or (found)

			loop
				found := item.is_style_almost_equal (a_style)
				forth
			end

			Result := found
		end

feature -- Code generation

	display is
		do
			from
				start
			until
				after
			loop
				io.putstring (" ")
				item.display
                                				
				forth
			end
 		end

	generate_resource_file (a_resource_file: PLAIN_TEXT_FILE) is
			-- Generate `a_resource_file' from the tds memory structure.
		require
			a_resource_file_exists: a_resource_file.exists
		do
			from
				start
			until
				after
			loop
				item.generate_resource_file (a_resource_file)
				forth

				if (not after) then
					a_resource_file.putstring (" | ") 
				end
			end
 		end

end -- class TDS_STYLE_LIST

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing
	description: "Options representation in the tds"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TDS_OPTIONS

inherit
	LINKED_LIST [STRING]

creation
	make

feature -- Code generation

	display is
		do
			io.putstring ("%NOptions : ")

			from
				start
			until
				after
			loop
				io.putstring (item)
				io.putstring (" ")

				forth
			end
			io.new_line
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
				a_resource_file.putstring (item)
				a_resource_file.putstring (" ")

				forth
			end
		end

feature -- Access

	caption: STRING
			-- Caption

feature -- Setting

	set_characteristic (v: STRING) is
			-- Assign `v' to `characteristic'.
		do
		end

	set_language (v: STRING) is
			-- Assign `v' to `language'
		do
		end

	set_version (v: STRING) is
			-- Assign `v' to `version'
		do
		end

	set_caption (v: STRING) is
			-- Assign `v' to `caption'
		do
		end

	set_class (v: STRING) is
			-- Assign `v' to `class'
		do
		end

	set_menu (v: STRING) is
			-- Assign `v' to `menu'
		do
		end

	set_style (s: TDS_STYLE) is
			-- Assign `v' to `style'
		do
		end

	set_font_size (s: INTEGER) is
			-- Assign `v' to `font_size'
		do
		end

	set_font_type (v: STRING) is
			-- Assign `v' to `font_type'
		do
		end

	set_font_weight (v: INTEGER) is
			-- Assign `v' to `weight'
		do
		end

	set_font_italic (b: BOOLEAN) is
			-- Assign `v' to `font_italic'
		do
		end

end -- class TDS_OPTIONS

--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------
indexing
	description: "This class represents a font that has been enumerated"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ENUMERATED_FONT_WINDOWS

inherit
	COMPARABLE

	WEL_FONT_FAMILY_ENUMERATOR
		rename
			make as get_families
		export
			{FONT_BOX_IMP} get_families
		undefine
			is_equal
		end

create
	make

feature -- Initialization

	make (a_name: STRING) is
			-- Create the enumerated font details
		require
			a_name_exists: a_name /= Void
		do
			name := a_name.twin
			create details.make
		ensure
			name_set: name.is_equal (a_name)
		end

feature -- Access

	name: STRING
			-- Name of the font

	details: LINKED_LIST [ENUMERATED_FONT_DETAILS_WINDOWS]
			-- details of the font

feature -- Status report

	not_raster: BOOLEAN
			-- Is this not a raster font?

feature -- Status setting

	fill (styles, sizes: WEL_SINGLE_SELECTION_LIST_BOX) is
			-- Fill the style and size details
		local
			c : CURSOR
		do
			from
				c := details.cursor
				details.start
				styles.reset_content
			until
				details.after
			loop
				styles.add_string (details.item.style)
				details.forth
			end
			details.first.fill_sizes (sizes)
			details.go_to (c)
		end

	set_not_raster is
			-- Set this to be a Truetype font
		do
			not_raster := True
		end

	action (elf: WEL_ENUM_LOG_FONT; tm: WEL_TEXT_METRIC; font_type: INTEGER) is
			-- Called for each font found.
			-- `elf', `tm' and `font_type' contain informations
			-- about the font.
			-- See class WEL_FONT_TYPE_ENUM_CONSTANTS for
			-- `font_type' values.
		local
			efdw: ENUMERATED_FONT_DETAILS_WINDOWS
			display_style: STRING
		do
			from
				details.start
				display_style := elf.style
				if display_style.is_empty then
					if tm.weight = 400 then
						display_style := "Regular"
					else
						display_style := "Bold"
					end
				end
			until
				efdw /= Void or details.after
			loop
				if display_style.is_equal (details.item.style) then
					efdw := details.item
				end
				details.forth
			end
			if efdw = Void then
				create efdw.make (name, display_style)
				details.extend (efdw)
			end
			if not not_raster then
				efdw.add (elf.log_font)
				debug ("enumerated_font")
					io.putstring (name)
					io.putchar (' ')
					io.putstring (display_style)
					io.putchar (' ')
					io.putstring (tm.height.out)
					io.putchar (' ')
					io.putstring (tm.ascent.out)
					io.putchar (' ')
					io.putstring (tm.descent.out)
					io.putchar (' ')
					io.putstring (tm.internal_leading.out)
					io.putchar (' ')
					io.putstring (tm.external_leading.out)
					io.putchar (' ')
					io.putstring (tm.average_character_width.out)
					io.putchar (' ')
					io.putstring (tm.maximum_character_width.out)
					io.new_line
				end
			else
				efdw.set_truetype_log_font (elf.log_font)
			end
		end

	find_style (style: STRING): ENUMERATED_FONT_DETAILS_WINDOWS is
			-- find style in the details.
		local
			c: CURSOR
		do
			from
				c := details.cursor
				details.start
			until
				details.after or Result /= Void
			loop
				if details.item.style.is_equal (style) then
					Result := details.item
				end
				details.forth
			end
			details.go_to (c)
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := name < other.name
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ENUMERATED_FONT_WINDOWS


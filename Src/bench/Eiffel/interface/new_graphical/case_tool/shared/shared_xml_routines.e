indexing
	description: "Common routines for XML extraction"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_XML_ROUTINES

inherit
	EXCEPTIONS
    	rename
    		tag_name as exceptions_tag_name,
    		class_name as exceptions_class_names
    	end

feature {SHARED_XML_ROUTINES} -- Status report

	valid_tags: INTEGER
			-- Number of valid tags read.

feature {SHARED_XML_ROUTINES} -- Status setting
	
	reset_valid_tags is
			-- Reset `valid_tags'.
		do
			valid_tags := 0
		ensure
			valid_tags_is_nul: valid_tags = 0
		end

	valid_tags_read is
			-- A valid tag was just read.
		do
			valid_tags := valid_tags + 1
		ensure
			valid_tags_incremented: valid_tags = old valid_tags + 1
		end

feature -- Processing

	xml_integer (elem: XML_ELEMENT; a_name: STRING): INTEGER is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XML_ELEMENT
			cd: XML_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.string.is_integer then
							Result := cd.string.to_integer
							valid_tags_read
						end
					end
				end
			end
		end

	xml_boolean (elem: XML_ELEMENT; a_name: STRING): BOOLEAN is
			-- Find in sub-elememt of `elem' boolean item with tag `a_name'.
		local
			e: XML_ELEMENT
			cd: XML_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.string.is_boolean then
							Result := cd.string.to_boolean
							valid_tags_read
						end
					end
				end
			end
		end

	xml_double (elem: XML_ELEMENT; a_name: STRING): DOUBLE is
			-- Find in sub-elememt of `elem' integer item with tag `a_name'.
		local
			e: XML_ELEMENT
			cd: XML_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						if cd.string.is_double then
							Result := cd.string.to_double
							valid_tags_read
						end
					end
				end
			end
		end

	xml_string (elem: XML_ELEMENT; a_name: STRING): STRING is
			-- Find in sub-elememt of `elem' string item with tag `a_name'.
		local
			e: XML_ELEMENT
			cd: XML_CHARACTER_DATA
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				if not e.is_empty then
					cd ?= e.first
					if cd /= Void then
						Result := cd.string
						valid_tags_read
					end
				end
			end
		end

	xml_color (elem: XML_ELEMENT; a_name: STRING): EV_COLOR is
			-- Find in sub-elememt of `elem' color item with tag `a_name'.
		local
			e: XML_ELEMENT
			cd: XML_CHARACTER_DATA
			s: STRING
			sc1, sc2: INTEGER
			r, g, b: INTEGER
		do
			e := element_by_name (elem, a_name)
			if e /= Void then
				cd ?= e.first
				if cd /= Void then
					s := cd.string
				end
			end
			if s /= Void then
				check
					two_semicolons: s.occurrences (';') = 2
				end
				sc1 := s.index_of (';', 1)
				r := s.substring (1, sc1 - 1).to_integer
				sc2 := s.index_of (';', sc1 + 1)
				g := s.substring (sc1 + 1, sc2 - 1).to_integer
				b := s.substring (sc2 + 1, s.count).to_integer
				create Result.make_with_8_bit_rgb (r, g, b)
				valid_tags_read
			end
		end

	element_by_name (e: XML_ELEMENT; n: STRING): XML_ELEMENT is
			-- Find in sub-elemement of `e' an element with tag `n'.
		require
			e_not_void: e /= Void
		local
			i: INTEGER
			f: XML_ELEMENT
		do
			from i := 1 until Result /= Void or i > e.count loop
				f ?= e.item (i)
				if f /= Void and then f.name.is_equal (n) then
					Result := f
				end
				i := i + 1
			end
		end

	xml_string_node (a_parent: XML_ELEMENT; s: STRING): XML_CHARACTER_DATA is
			-- New node with `s' as content.
		do
			create Result.make_from_content (
				a_parent,
				create {XML_CHARACTER_ARRAY}.make_from_string (s)
			)
		end

	xml_node (a_parent: XML_ELEMENT; tag_name, content: STRING): XML_ELEMENT is
			-- New node with `s' as content and named `tag_name'.
		do
			create Result.make (a_parent, tag_name)
			Result.put_last (xml_string_node (Result, content))
		end
	
feature {NONE} -- Implementation

	error_window: EV_WARNING_DIALOG
			-- Window that warns user of wrong ".ead" file.

end -- class SHARED_XML_ROUTINES

indexing

	description:
		"General export status of a feature clause.";
	date: "$Date$";
	revision: "$Revision $"

class EXPORT_SET_I 

inherit

	EXPORT_I
		redefine
			is_all, is_none, is_set
		end
	LINKED_SET [STRING]
		rename
			make as make_lset
		redefine
			extend
		end
	SHARED_TEXT_ITEMS

creation {PROCESS_FEATURE_CLAUSE}

	make_lset

creation

	make_any, make_default, make_none, make_from_storer

feature {NONE} -- Initialization

	make_any, make_default is
			-- Create a default export clause, ie the empty one
			-- (equivalent to exporting to ANY)
		do
			make_lset
		end

	make_from_storer (s_export: S_EXPORT_I) is
		local
			sesi: S_EXPORT_SET_I
			storer_count: INTEGER
		do
			sesi ?= s_export
			if sesi = Void then
					--| for compatibility
				if s_export.is_all then
					make_any
				else
					check
						is_none: s_export.is_none
					end
					make_none
				end
			else
				from
					make_lset
					sesi.start
					storer_count := sesi.count
				variant
					progressing: storer_count - count
				until
					sesi.off
				loop
					fast_extend (sesi.item)
					sesi.forth
				end
			end
		end

	make_none is
			-- Create a private export clause, ie "{NONE}"
		do
			make_lset
			fast_extend (None_string)
		end

feature -- Properties

	is_all: BOOLEAN is
			-- Is the current export the empty export, or "{ANY}"?
        do
			Result := (count = 0) or else
				((count = 1) and then Any_string.is_equal(i_th(1)))
		end

	is_none: BOOLEAN is
			-- Is the current export "{NONE}"?
        do
			Result := (count = 1) and then None_string.is_equal(i_th(1))
		end

	is_set: BOOLEAN is
			-- Is the current object an instance of EXPORT_SET_I ?
			--| Kept for compatibility.
		do
			Result := True
		end

feature -- Comparison

	same_as (other: EXPORT_I): BOOLEAN is
			-- Is `other' the same as Current ?
		local
			other_set: EXPORT_SET_I
			one_client: STRING
			pos: INTEGER
			c1, c2: CURSOR
		do
			if other.is_all then
				Result := is_all
			elseif other.is_none then
				Result := is_none
			else
				other_set ?= other
				if other_set /= Void and then count = other_set.count then
					c1 := cursor
					c2 := other_set.cursor
					from
						Result := True
						start
					until
						after or else not Result
					loop
						one_client := item
						other_set.start
						other_set.search (one_client)
						Result := 	(not other_set.after)
									and then
									one_client.is_equal (other_set.item)
						forth
					end
					go_to (c1)
					other_set.go_to (c2)
				end
			end
		end
	
feature -- Element change

	extend (v: like item) is
			-- Add `v' to end.
			-- Do not move cursor.
		local
			p: like first_element
		do
			p := new_cell (v)
			if empty then
				first_element := p
				active := p
			elseif not has (v) then
				last_element.put_right (p)
				if after then 
					active := p 
				end
			end
			count := count + 1
		end

feature -- Output

	generate (text_area: TEXT_AREA) is
			-- Generate text corresponding to Current into `text_area'
		do
			text_area.append_string (export_string)
		end

	generate_c (text_area:TEXT_AREA) is
			-- Generate C...
		do
			text_area.append_string (export_string_c)
		end

	export_list_string: STRING is
			-- String containing the list of authorized clients 
			-- (without brackets)
		local
			minus_one, i: INTEGER
			comma_str: STRING
		do
			if empty then
				Result := ""
			else
				comma_str := ", "
				!! Result.make (count * 10)
				from
					minus_one := count - 1
					i := 1
					start
				variant
					remaining: minus_one - i
				until
					i > minus_one
				loop
					Result.append (item)
					Result.append (comma_str)
					forth
					i := i + 1
				end
				check
					empty_or_last_one: empty or else islast
				end
				Result.append (item)
			end
		end

feature {COMPILER_EXPORTER}

	format (ctxt: FORMAT_CONTEXT) is
		local
			minus_one, i: INTEGER
			comma_str: STRING
		do
			comma_str := ", "
			ctxt.put_text_item (ti_L_curly)
			from
				minus_one := count - 1
				i := 1
				start
			variant
				remaining: minus_one - i
			until
				i > minus_one
			loop
				ctxt.put_string (item)
				ctxt.put_string (comma_str)
				forth
				i := i + 1
			end
			check
				last_one: islast
			end
			ctxt.put_string (item)
			ctxt.put_text_item_without_tabs (ti_R_curly)
		end

feature {COMPILER_EXPORTER} -- Case storage

	storage_info: S_EXPORT_SET_I is
		do
			!! Result.make (count)
			from
				start
			variant
				remaining_elements: count - index
			until
				after
			loop
				Result.extend (item)
				forth
			end
		end

feature {NONE} -- Implementation properties

	Any_string: STRING is "ANY"

	None_string: STRING is "NONE"

feature {NONE} -- Implementation

	fast_extend (v: like item) is
			-- Add `v' to end, without checking if `v' if already there.
			-- (must be used only when there may be no duplicate insertions).
			-- Do not move cursor.
		local
			p: like first_element
		do
			p := new_cell (v)
			if empty then
				first_element := p
				active := p
			else
				last_element.put_right (p)
				if after then 
					active := p 
				end
			end
			count := count + 1
		end

end -- class EXPORT_SET_I

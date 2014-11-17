note
	description: "[
		JSON_ARRAY represent an array in JSON.
		An array in JSON is an ordered set of names.
		Examples
		array
		    []
		    [elements]
	]"
	author: "$Author$"
	date: "$date$"
	revision: "$Revision$"

class
	JSON_ARRAY

inherit

	JSON_VALUE

	ITERABLE [JSON_VALUE]

	DEBUG_OUTPUT

create
	make, make_empty,
	make_array

feature {NONE} -- Initialization

	make (nb: INTEGER)
			-- Initialize JSON array with capacity of `nb' items.
		do
			create items.make (nb)
		end

	make_empty
			-- Initialize empty JSON array.
		do
			make (0)
		end

	make_array
			-- Initialize JSON Array
		obsolete
			"Use `make' Sept/2014"
		do
			make (10)
		end

feature -- Access

	i_th alias "[]" (i: INTEGER): JSON_VALUE
			-- Item at `i'-th position
		require
			is_valid_index: valid_index (i)
		do
			Result := items.i_th (i)
		end

	representation: STRING
		do
			Result := "["
			across
				items as ic
			loop
				if Result.count > 1 then
					Result.append_character (',')
				end
				Result.append (ic.item.representation)
			end
			Result.append_character (']')
		end

feature -- Visitor pattern

	accept (a_visitor: JSON_VISITOR)
			-- Accept `a_visitor'.
			-- (Call `visit_json_array' procedure on `a_visitor'.)
		do
			a_visitor.visit_json_array (Current)
		end

feature -- Access

	new_cursor: ITERATION_CURSOR [JSON_VALUE]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Mesurement

	count: INTEGER
			-- Number of items.
		do
			Result := items.count
		end

feature -- Status report

	valid_index (i: INTEGER): BOOLEAN
			-- Is `i' a valid index?
		do
			Result := (1 <= i) and (i <= count)
		end

feature -- Change Element

	put_front (v: JSON_VALUE)
		require
			v_not_void: v /= Void
		do
			items.put_front (v)
		ensure
			has_new_value: old items.count + 1 = items.count and items.first = v
		end

	add, extend (v: JSON_VALUE)
		require
			v_not_void: v /= Void
		do
			items.extend (v)
		ensure
			has_new_value: old items.count + 1 = items.count and items.has (v)
		end

	prune_all (v: JSON_VALUE)
			-- Remove all occurrences of `v'.
		require
			v_not_void: v /= Void
		do
			items.prune_all (v)
		ensure
			not_has_new_value: not items.has (v)
		end

	wipe_out
			-- Remove all items.
		do
			items.wipe_out
 		end

feature -- Report

	hash_code: INTEGER
			-- Hash code value
		local
			l_started: BOOLEAN
		do
			across
				items as ic
			loop
				if l_started then
					Result := ((Result \\ 8388593) |<< 8) + ic.item.hash_code
				else
					Result := ic.item.hash_code
					l_started := True
				end
			end
			Result := Result \\ items.count
		end

feature -- Conversion

	array_representation: ARRAYED_LIST [JSON_VALUE]
			-- Representation as a sequences of values.
			-- be careful, modifying the return object may have impact on the original JSON_ARRAY object.		
		do
			Result := items
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := count.out + " item(s)"
		end

feature {NONE} -- Implementation

	items: ARRAYED_LIST [JSON_VALUE]
			-- Value container

invariant
	items_not_void: items /= Void

note
	copyright: "2010-2014, Javier Velilla and others https://github.com/eiffelhub/json."
	license: "https://github.com/eiffelhub/json/blob/master/License.txt"
end

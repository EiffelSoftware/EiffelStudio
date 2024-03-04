note
	description: "[
			Index that could be associated to different metadata tables.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	PE_CODED_INDEX_BASE

inherit
	PE_INDEX_BASE
		redefine
			is_coded_index,
			token,
			binary_value,
			render,
			get,
			large,
			accepts,
			is_equal
		end

create
	make_with_tag_and_index

feature {NONE} -- Initialization	

	make_with_tag_and_index (a_tag: INTEGER; a_index: NATURAL_32)
		do
			make_with_index (a_index)
			tag := a_tag
		ensure
			tag_set: tag = a_tag
			index_set: index = a_index
		end

feature -- Access

	tag: INTEGER
			-- Indicate which table the index belongs to.	

	token: NATURAL_32
			-- Associated token for information.
		do
			Result := (tag.to_natural_32 |<< 24) | index
		end

	binary_value: NATURAL_32
			-- Value expected to be written in the binary.
		do
			Result := (index |<< get_index_shift) + tag.to_natural_32
		end

feature -- Coded related

	get_index_shift: INTEGER
		do
				-- to be redefined
				--| Declared in C++ as virtual int GetIndexShift() const = 0;
				--| it's a pure virtual function. So the function doesn't change
				--| the data of the class.
				--| In Eiffel we could declared it as deferred.
		end

	large (a_x: NATURAL_32): BOOLEAN
		do
			Result := (a_x |<< get_index_shift) > 0xffff
		end

feature -- Operations

	render (a_sizes: ARRAY [NATURAL_32]; a_dest: ARRAY [NATURAL_8]; a_pos: NATURAL_32): NATURAL_32
			-- Number of bytes written to the destination `a_dest`
		local
			v: NATURAL_32
		do
				--  Calculate the value to be written to the destination `a_dest`.
			v := (index |<< get_index_shift) + tag.to_natural_32

			if has_index_overflow (a_sizes) then
					-- write the value as NATURAL_32 to the destination `a_dest`
				{BYTE_ARRAY_HELPER}.put_natural_32 (a_dest, v, a_pos.to_integer_32)

				Result := 4
			else
					-- write the value as NATURAL_16 to the destination `a_dest`
				{BYTE_ARRAY_HELPER}.put_natural_16 (a_dest, v.to_natural_16, a_pos.to_integer_32)
				Result := 2
			end
		end

	get (a_sizes: ARRAY [NATURAL_32]; a_src: ARRAY [NATURAL_8]; a_pos: NATURAL_32): NATURAL_32
			-- Number of bytes read from the source `a_src`	at position `a_pos`
		local
			v: NATURAL_32
		do
				-- Determine the size of the value to read from the source `a_src`
			if has_index_overflow (a_sizes) then
					-- Use a 32-bit Natural to store the value
					-- and set the return value to 4.
				v := {BYTE_ARRAY_HELPER}.natural_32_at (a_src, a_pos.to_integer_32)
				Result := 4
			else
					-- Use a 16-bit Natural to store the value
					-- and set the return value to 2.
				v := {BYTE_ARRAY_HELPER}.natural_16_at (a_src, a_pos.to_integer_32).to_natural_32
				Result := 2
			end
				-- Compute the index and tag values
			index := v |>> get_index_shift
			tag := (v & (({INTEGER} 1 |<< get_index_shift - 1)).to_natural_32).to_integer_32
		end

feature -- Comparison

	is_table_same_as_tag (tb_id: NATURAL_32): BOOLEAN
		do
			Result := tag = tag_for_table (tb_id)
		end

	is_equal (other: like Current): BOOLEAN
			-- Is `other' equal to the current object?
		do
			Result := tag = other.tag and then Precursor (other)
		end

feature -- Element change

	update_coded_index (idx: like index; tb_id: NATURAL_32)
			-- Update code index `idx` on table `tb_id`.
			-- This is relevant for index that are related to multiple tables
			-- such as MethodDefOrMemberRef.
		require
			is_coded_index
		do
			if tag = tag_for_table (tb_id) then
				index := idx
			else
				do_nothing
			end
		end

feature -- Access		

	tag_for_table (a_table_id: NATURAL_32): INTEGER_32
		do
				-- To be redefined
			Result := -1
		end

feature -- Status report

	is_coded_index: BOOLEAN = True

feature -- Visitor

	accepts (vis: MD_VISITOR)
		do
			vis.visit_coded_index (Current)
		end

invariant
	expected_index_shift: get_index_shift > 0
	is_coded_index: is_coded_index

end

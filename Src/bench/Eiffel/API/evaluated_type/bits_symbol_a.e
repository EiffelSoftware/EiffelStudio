indexing
	description: "Actual type for bits_symbol."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class BITS_SYMBOL_A

inherit
	BITS_A
		rename
			make as make_with_count
		redefine
			solved_type, dump, ext_append_to,
			is_equivalent, is_full_named_type, process
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create {COMPILER_EXPORTER}
	make

feature {NONE} -- Initialization

	make (f: FEATURE_I; c: like bit_count) is
		do
			make_with_count (c)
			feature_name_id := f.feature_name_id
			current_class_id := System.current_class.class_id
			rout_id := f.rout_id_set.first
		end

feature -- Visitor

	process (v: TYPE_A_VISITOR) is
			-- Process current element.
		do
			v.process_bits_symbol_a (Current)
		end

feature -- Properties

	feature_name_id: INTEGER

	rout_id: INTEGER

	current_class_id: INTEGER
			-- Class declaring current

	is_full_named_type: BOOLEAN is False
			-- Current is not fully named

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := bit_count = other.bit_count and then
				rout_id = other.rout_id and then
				feature_name_id = other.feature_name_id and then
				current_class_id = other.current_class_id
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			create Result.make (9)
			Result.append ("BIT ")
			Result.append (names_heap.item (feature_name_id))
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_Bit_class)
			st.add_space
			st.add_string (names_heap.item (feature_name_id))
		end

feature {COMPILER_EXPORTER}

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): BITS_SYMBOL_A is
			-- Calculated type in function of the feauure `f' which has
			-- the type Current and the feautre table `feat_table
		local
			anchor_feature: FEATURE_I
			vtbt: VTBT
			veen: VEEN
			constant: CONSTANT_I
			bits_value: INTEGER
			error: BOOLEAN
			int_value: INTEGER_CONSTANT
		do
			if not (System.current_class.class_id = current_class_id) then
				anchor_feature := System.class_of_id (current_class_id).feature_table
								.item_id (feature_name_id)
			else
				anchor_feature := feat_table.item_id (feature_name_id)
			end
			if anchor_feature = Void then
				create veen
				veen.set_class (System.current_class)
				veen.set_feature (f)
				veen.set_identifier (names_heap.item (feature_name_id))
				Error_handler.insert_error (veen)
				Error_handler.raise_error
			else
				constant ?= anchor_feature
				error := constant = Void
				if not error then
					int_value ?= constant.value
					error := int_value = Void
					if not error then
						bits_value := int_value.integer_32_value
						error :=
							bits_value <= 0 or else
							bits_value > {EIFFEL_SCANNER_SKELETON}.Maximum_bit_constant
					end
				end
				if error then
					create vtbt
					vtbt.set_class (feat_table.associated_class)
					vtbt.set_feature (f)
					vtbt.set_value (bits_value)
					Error_handler.insert_error (vtbt)
						-- Cannot go on here
					Error_handler.raise_error
				end
				bit_count := bits_value
			end
			rout_id := anchor_feature.rout_id_set.first
			Result := twin
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.

			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).

			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.

			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class BITS_SYMBOL_A

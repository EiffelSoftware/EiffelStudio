indexing
	description: "Compiled class TUPLE"
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_CLASS_B

inherit
	CLASS_C
		redefine
			actual_type,
			init_types, update_types, is_tuple, partial_actual_type
		end

create
	make

feature -- Status report

	is_tuple: BOOLEAN is True
			-- Current class is TUPLE.

feature -- types

	init_types is
			-- Standard initialization of attribute `types'
			-- Special treatment for TUPLEs
		require else
			True
		local
			class_type: CLASS_TYPE
			type_i: TUPLE_TYPE_I
		do
			create type_i.make (class_id)
			type_i.set_true_generics (Void)
			type_i.set_meta_generic (Void)
			class_type := new_type (type_i)
			types.extend (class_type)
			System.insert_class_type (class_type)
		end

	update_types (data: CL_TYPE_I) is
			-- Update `types' with `data'.
			-- For TUPLE we make sure that only one type is
			-- inserted.
		local
			filter: CL_TYPE_I
			l_gen_type: GEN_TYPE_I
		do
			if not derivations.has_derivation (class_id, data) then
					-- The recursive update is done only once
				derivations.insert_derivation (class_id, data)
				
				if types.is_empty then
						-- Found a new type for the class
					init_types

						-- If the $ operator is used in the class,
						-- an encapsulation of the feature must be generated

					if System.address_table.class_has_dollar_operator (class_id) then
						System.set_freeze
					end

						-- Mark the class `changed4' because there is a new
						-- type
					changed4 := True
					Degree_2.insert_new_class (Current)
						-- Insertion of the new class type
				end

					-- Propagation along the filters since we have a new type
					-- Clean the filters. Some of the filters can be obsolete
					-- if the base class has been removed from the system
				filters.clean
				l_gen_type ?= data
				from
					filters.start
				until
					filters.after
				loop
						-- Instantiation of the filter with `data'
					if l_gen_type /= Void then
						filter := filters.item.instantiation_in (l_gen_type)
					else
						filter := filters.item
					end
					filter.base_class.update_types (filter)
					filters.forth
				end
			end
		end

feature -- Actual class type

	actual_type: TUPLE_TYPE_A is
			-- Actual type of the class
		local
			i, count: INTEGER
			actual_generic: ARRAY [FORMAL_A]
			formal: FORMAL_A
		do
			if generics /= Void then
				from
					i := 1
					count := generics.count
					create actual_generic.make (1, count)
				until
					i > count
				loop
					create formal
					formal.set_position (i)
					actual_generic.put (formal, i)
					i := i + 1
				end
			else
				create actual_generic.make (1, 0)
			end
			create Result.make (class_id, actual_generic)
		end

feature {CLASS_TYPE_AS} -- Actual class type

	partial_actual_type (gen: ARRAY [TYPE_A]; is_ref: BOOLEAN; is_exp: BOOLEAN; is_sep: BOOLEAN): CL_TYPE_A is
			-- Actual type of `current depending on the context in which it is declared
			-- in CLASS_TYPE_AS. That is to say, it could have generics `gen' but not
			-- be a generic class. Or it could be a reference even though it is an
			-- expanded class. It simplifies creation of `CL_TYPE_A' instances in
			-- CLASS_TYPE_AS when trying to resolve types, by using dynamic binding
			-- rather than if statements.
		do
			if gen /= Void then
				create {TUPLE_TYPE_A} Result.make (class_id, gen)
			else
				create {TUPLE_TYPE_A} Result.make (class_id, create {ARRAY [TYPE_A]}.make (1, 0))
			end
				-- Note that TUPLE is not expanded by default.
			Result.set_is_expanded (is_exp)
		end

end -- class TUPLE_CLASS_B


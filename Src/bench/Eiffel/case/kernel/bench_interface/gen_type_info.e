indexing

	description: "Explicit generic class type information.";
	date: "$Date$";
	revision: "$Revision $"

class GEN_TYPE_INFO

inherit

	CLASS_TYPE_INFO
		rename
			make_from_storer as class_make_from_storer,
			copy as class_copy,
			is_equal as class_is_equal
		redefine
			update_type,
			has_generics,
			generate, storage_info
		end;
	CLASS_TYPE_INFO
		redefine
			update_type,
			has_generics, storage_info,
			generate, make_from_storer,
			copy, is_equal
		select
			make_from_storer, copy, is_equal
		end;

creation

	update_type, make_from_storer

feature -- Initialization

	make_from_storer (storer: S_GEN_TYPE_INFO) is
		local
			gens: FIXED_LIST [S_TYPE_INFO]
			gen_type: TYPE_INFO;
			s_type_info: S_TYPE_INFO;
			s_basic_info: S_BASIC_TYPE_INFO;
			s_class_info: S_CLASS_TYPE_INFO;
			s_gen_info: S_GEN_TYPE_INFO;
			type_dec: TYPE_DECLARATION
		do
			class_make_from_storer (storer);
			gens := storer.generics;
			if gens /= Void then
				!! generics.make_filled (gens.count);
				from
					gens.start;
					generics.start
				until
					gens.after
				loop
						-- Normally I would let polymorphism create
						-- the corresponding type but because the
						-- storage classes are common between case
						-- and bench I cannot reference specific
						-- case class in the storage directory, hence
						-- the following ugly non-O.O code. (dinov)
					s_type_info := gens.item;
					if s_type_info.is_not_actual_class_type then
						s_basic_info ?= s_type_info; -- Cannot fail
						! BASIC_TYPE_INFO ! gen_type.make_from_storer (s_basic_info)
					elseif s_type_info.has_generics then
						s_gen_info ?= s_type_info; -- Cannot fail
						! GEN_TYPE_INFO ! gen_type.make_from_storer (s_gen_info)
					else
						s_class_info ?= s_type_info; -- Cannot fail
						! CLASS_TYPE_INFO ! gen_type.make_from_storer (s_class_info)
					end;
					!! type_dec.set_type (gen_type);
					generics.replace (type_dec);
					generics.forth;
					gens.forth
				end
			end
		end;

feature -- Properties

	has_generics: BOOLEAN is
		do
			Result := True
		end;

	generics: FIXED_LIST [TYPE_DECLARATION]

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
		local
			other_gens: like generics;
			gen: TYPE_DECLARATION
		do
			Result := class_is_equal (other);
			if Result then
				other_gens := other.generics;
				from
					other_gens.start;
					generics.start
				until
					other_gens.after or else not Result
				loop
					gen := generics.item;
					Result := gen.is_equal (other_gens.item)
					generics.forth;
					other_gens.forth
				end
			end
		end;

feature -- Duplication

	copy (other: like Current) is
		local
			other_gens: like generics;
			gen: TYPE_DECLARATION
		do
			class_copy (other);
			other_gens := other.generics;
			!! generics.make_filled (other_gens.count); -- may,pascalf
			from
				other_gens.start;
				generics.start
			until
				other_gens.after
			loop
				gen := clone (other_gens.item);
				generics.replace (gen);
				generics.forth;
				other_gens.forth
			end
		end;

feature -- Update

	update_type (cl: CLASS_DATA) is
			-- Update type to class `cl' and
			-- name to `cl' name.
		local
			class_generics: LINKED_LIST [GENERIC_DATA];
			type_dec: TYPE_DECLARATION
		do
			check
				has_generics: cl.has_generics
			end
			class_generics := cl.generics;
			!! generics.make_filled (class_generics.count);
			from
				class_generics.start;
				generics.start
			until
				class_generics.after
			loop
				!! type_dec.set_type (class_generics.item.type_info);
				generics.replace (type_dec);	
				generics.forth;
				class_generics.forth
			end;
			type := cl;
			free_text_name := Void
		ensure then
			type_set: type = cl;
			update_class_name: type.name = cl.name
		end;

feature -- Output

	generate (text_area: TEXT_AREA; data: DATA; type_dec: TYPE_DECLARATION ) is
		do
			text_area.append_clickable_string (stone (data, type_dec), name);
			if generics /= Void then
				from
					generics.start
					text_area.append_string(" [");	
				until
					generics.after
				loop
					generics.item.generate (text_area, data );
					generics.forth;
					if not generics.after then
						text_area.append_string (", ")
					end
				end;
				text_area.append_string ("]");
			end
		end;

feature -- Storage

	storage_info: S_GEN_TYPE_INFO is
		local
			gen: FIXED_LIST [S_TYPE_INFO]
		do
			if type = Void then
				!! Result.make (name, 0);
			elseif type.is_in_system then
				!! Result.make (Void, type.id);
			else
				!! Result.make (clone (type.name), 0);
			end;
			if generics /= Void then
				!! gen.make_filled (generics.count);
				from
					generics.start;
					gen.start
				until	
					generics.after
				loop
					gen.replace (generics.item.storage_info);
					generics.forth
					gen.forth
				end	;
				Result.set_generics (gen)
			end
		end;

invariant

	has_generics: generics /= Void and then is_instantiated

end -- class GEN_TYPE_INFO

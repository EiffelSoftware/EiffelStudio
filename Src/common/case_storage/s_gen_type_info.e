indexing
	description: "Explicit generic class type information.";
	date: "$Date$"; 
	revision: "$Revision$"

class S_GEN_TYPE_INFO

inherit
	S_CLASS_TYPE_INFO
		redefine
			has_generics, string_value,
			real_class_ids
		end

creation

	make

feature -- Properties

	generics: FIXED_LIST [S_TYPE_INFO];
			-- Generics list

	has_generics: BOOLEAN is
			-- Does Current contain generics?
		do
				-- TUPLEs may have zero generics
			Result := (generics /= Void)
		end

	real_class_ids: LINKED_LIST [INTEGER] is
			-- List of real class ids that exist in system
			-- in the generic paraments
		do
			!! Result.make;

				-- TUPLEs may have zero generics
			if generics /= Void then
				from
					generics.start
				until
					generics.after
				loop
					if generics.item.is_normal_class then
						Result.append (generics.item.real_class_ids)
					end
					generics.forth
				end
			end
		end

feature -- Setting

	set_generics (l: like generics) is
			-- Set generics to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_has_void: not l.has (Void)
		do
			generics := l
		ensure
			generics_set: generics = l
		end;

feature -- Output

	string_value: STRING is
			-- String value of Current generic
		do
			Result := clone (free_text_name);

				-- TUPLEs may have zero generics
			if generics /= Void then
				Result.append (" [");
				from
					generics.start
				until
					generics.after
				loop
					Result.append (generics.item.string_value);
					if not generics.after then
						Result.append (", ")
					end
					generics.forth
				end;
				Result.append ("]");
			end;
		end;

	string_value_minus_id (id: INTEGER): STRING is
			-- String value of Current and do not
			-- print the string value of class
			-- with id `id' (replace it with "...")
		require
			valid_id: id > 0
		local
			class_type_info: S_CLASS_TYPE_INFO;
			type_info: S_TYPE_INFO
		do
			Result := clone (free_text_name);

				-- TUPLEs may have zero generics
			if generics /= Void then
				Result.append (" [");
				from
					generics.start
				until
					generics.after
				loop
					type_info := generics.item;
					class_type_info ?= type_info;
					if class_type_info = Void then
						Result.append (type_info.string_value);
					elseif class_type_info.class_id = id then
						Result.append ("...");
					else
						Result.append (type_info.string_value);
					end;
					generics.forth;
					if not generics.after then
						Result.append (", ")
					end
				end;
				Result.append ("]");
			end;
		end;

end -- class S_GEN_TYPE_INFO

class S_GEN_TYPE_INFO

inherit

	S_CLASS_TYPE_INFO
		redefine
			has_generics, string_value,
			real_class_ids
		end

creation

	make

feature

	generics: FIXED_LIST [S_TYPE_INFO];

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

	has_generics: BOOLEAN is
		do
			Result := True
		end;

	string_value: STRING is
		do
			Result := clone (free_text_name);
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
				else
                	Result.append ("...");
				end;
                if not generics.after then
                    Result.append (", ")
                end
                generics.forth
            end;
            Result.append ("]");
		end;

	real_class_ids: LINKED_LIST [INTEGER] is
		do
			!! Result.make;
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

class RESOURCE_TABLE

inherit

	HASH_TABLE [STRING, STRING]

creation

	make

feature -- Access

	get_integer (name: STRING; default_value: INTEGER): INTEGER is
			-- Value of the resource `name'; 
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		do
			if has (name) then
				Result := item (name).to_integer;
				if free_resource then
					remove (name)
				end
			else
				Result := default_value
			end
		end;

	get_pos_integer (name: STRING; default_value: INTEGER): INTEGER is
			-- Positive value of the resource `name'; 
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void;
			valid_default_value: default_value >= 0
		do
			if has (name) then
				Result := item (name).to_integer.abs;
				if free_resource then
					remove (name)
				end
			else
				Result := default_value
			end
		ensure
			result_is_positive: Result >= 0
		end;

	get_boolean (name: STRING; default_value: BOOLEAN): BOOLEAN is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		do
			if has (name) then
				Result := item (name).to_boolean;
				if free_resource then
					remove (name)
				end
			else
				Result := default_value
			end
		end;

	get_real (name: STRING; default_value: REAL): REAL is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		do
			if has (name) then
				Result := item (name).to_real;
				if free_resource then
					remove (name)
				end
			else
				Result := default_value
			end
		end;

	get_string (name: STRING; default_value: STRING): STRING is
			-- Value of the resource `name';
			-- `default_value' if this value is not known
		require
			name_not_void: name /= Void
		do
			if has (name) then
				Result := item (name);
				if free_resource then
					remove (name)
				end
			else
				Result := default_value
			end
		end;

feature -- Status report

	free_resource: BOOLEAN;
			-- Should the resource be removed from the table
			-- after it has been inspected?

feature -- Status setting

	set_free_resource (b: BOOLEAN) is
			-- Assign `b' to `free_resource'.
		do
			free_resource := b
		end;

end -- class RESOURCE_TABLE

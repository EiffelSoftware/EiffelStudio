indexing
	description: ".NET method argument"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ARGUMENT

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (dn, en: STRING; ct: CONSUMED_REFERENCED_TYPE; a_o: BOOLEAN) is
			-- Set `dotnet_name' with `dn'.
			-- Set `eiffel_name' with `en'.
			-- Set `type' with `ct'.
			-- Set `is_out' with `a_o'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_eiffel_name: en /= Void
			valid_eiffel_name: not en.is_empty
			non_void_type: ct /= Void
		do
			d := dn
			e := en
			t := ct
			o := a_o
		ensure
			eiffel_name_set: eiffel_name = en
			dotnet_name_set: dotnet_name = dn
			type_set: type = ct
			is_out_set: is_out = a_o
		end
		
feature -- Access

	dotnet_name: STRING is
			-- .NET name
		do
			Result := d
		end
	
	eiffel_name: STRING is
			-- Eiffel name
		do
			Result := e
		end
	
	type: CONSUMED_REFERENCED_TYPE is
			-- Variable type
		do
			Result := t
		end

	is_out: BOOLEAN is
			-- Out argument?
		do
			Result := o
		end

feature {NONE} -- Access

	d: like dotnet_name
			-- Internal data storage for `dotnet_name'.

	e: like eiffel_name
			-- Internal data storage for `eiffel_name'.
			
	t: like type
			-- Internal data storage for `type'.
			
	o: like is_out
			-- Internal data storage for `is_out'.

feature {CONSUMED_ARGUMENT, OVERLOAD_SOLVER} -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
			-- Only compare arguments from same assembly as types are identified per assembly!
		do
			Result := other.dotnet_name.is_equal (dotnet_name) and
						other.type.is_equal (type)
		end

invariant
	non_void_dotnet_name: dotnet_name /= Void
	valid_dotnet_name: not dotnet_name.is_empty
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	non_void_type: type /= Void

end -- class CONSUMED_ARGUMENT

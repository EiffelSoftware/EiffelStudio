indexing
	description: ".NET properties"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_PROPERTY

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			eiffelized_consumed_entities,
			dotnet_name,
			is_property,
			is_property_or_event,
			is_public,
			is_static
		end

create
	make,
	my_make

feature {NONE} -- Initialization

	make (egn, esn, dn: STRING; args:ARRAY [CONSUMED_ARGUMENT]; has_getter, has_setter, pub, stat: BOOLEAN; type, decl_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize event.
		require
--			non_void_eiffel_name: en /= Void
			non_void_dotnet_name: dn /= Void
			non_void_args: args /= Void
--			valid_eiffel_name: not en.is_empty
--			valid_dotnet_name: not dn.is_empty
			getter: egn = Void implies not has_getter
			setter: esn = Void implies not has_setter
			non_void_type: type /= Void
			non_void_declaring_type: decl_type /= Void
		do
			dotnet_name := dn
			is_public := pub
			is_static := stat
			entity_make (egn, pub, decl_type)
			if has_getter then
				create getter.make (	egn,
									dn,
									args,
									type,
									False, stat, False, False, False, pub, True,
									decl_type)
			end
			if has_setter then
				create setter.make (esn,
									dn,
									args,
									False, stat, False, pub, True,
									decl_type)
			end
		ensure
			dotnet_name_set: dotnet_name = dn
			getter_set: has_getter implies getter /= Void
			valid_getter: has_getter implies getter.is_property_or_event
			setter_set: has_setter implies setter /= Void
			valid_setter: has_setter implies setter.is_property_or_event
		end

	my_make (dn: STRING; pub, stat: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_getter: CONSUMED_FUNCTION; cp_setter: CONSUMED_PROCEDURE) is
			-- Initialize event.
		require
--			non_void_property_name: pn /= Void
			non_void_dotnet_name: dn /= Void
--			valid_property_name: not pn.is_empty
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
			getter_or_setter: cp_getter = Void implies cp_setter /= Void
			getter_or_setter: cp_setter = Void implies cp_getter /= Void
		do
			dotnet_name := dn
			is_public := pub
			is_static := stat
			entity_make (dn, pub, decl_type)
			getter := cp_getter
			setter := cp_setter
		ensure
			dotnet_name_set: dotnet_name = dn
			getter_set: getter = cp_getter
			setter_set: setter = cp_setter
		end

	
feature -- ConsumerWrapper functions

	is_property: BOOLEAN is
			-- Is `Current' a .Net Property.
		do
			Result := True
		end
		
	is_property_or_event: BOOLEAN is
			-- Is 'Current' a .NET Property or Event?
		do
			Result := True
		end
		
	is_public: BOOLEAN
			-- Is `Current' public.
			
	is_static: BOOLEAN
			-- Is `Current' static.

feature -- Access

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- List of eiffelized Consumed Entities relative to `Current'.
		do
			create Result.make (0)
			if getter /= Void then
				Result.extend (getter)
			end
			if setter /= Void then
				Result.extend (setter)
			end
		end
		

	dotnet_name: STRING
			-- .NET property name

	getter: CONSUMED_FUNCTION
			-- Property getter function
	
	setter: CONSUMED_PROCEDURE
			-- Property setter procedure

end -- class CONSUMED_PROPERTY

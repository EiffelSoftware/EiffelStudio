indexing
	description: ".NET events"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_EVENT

inherit
	CONSUMED_ENTITY
		rename
			make as entity_make
		redefine
			eiffelized_consumed_entities,
			dotnet_name,
			is_event,
			is_public
		end

create
	make

feature {NONE} -- Initialization

	make (en, dn: STRING; pub, has_adder, has_remover: BOOLEAN; handler_type: CONSUMED_REFERENCED_TYPE; rais: CONSUMED_PROCEDURE; decl_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize property with name `n' and type `type'.
		require
			non_void_eiffel_name: en /= Void
			non_void_dotnet_name: dn /= Void
			valid_eiffel_name: not en.is_empty
			valid_dotnet_name: not dn.is_empty
			non_void_handler_type: handler_type /= Void
			non_void_declaring_type: decl_type /= Void
		local
			args: ARRAY [CONSUMED_ARGUMENT]
		do
			dotnet_name := dn
			is_public := pub
			create args.make (1, 1)
			args.put (create {CONSUMED_ARGUMENT}.make ("Value", "value", handler_type, False), 1)
			entity_make (en, pub, decl_type)
			if has_adder then
				create adder.make (
									"add_" + en,
									"add_" + dn,
									args,
									False, False, False, pub, True,
									decl_type)
			end
			if has_remover then
				create remover.make (
									"remove_" + en,
									"remove_" + dn,
									args,
									False, False, False, pub, True,
									decl_type)
			end
			raiser := rais
		ensure
			dotnet_name_set: dotnet_name = dn
			adder_set: has_adder implies adder /= Void
			valid_adder: has_adder implies adder.is_property_or_event
			remover_set: has_remover implies remover /= Void
			valid_remover: has_remover implies remover.is_property_or_event
			raiser_set: raiser = rais
			valid_raiser: raiser /= Void implies raiser.is_property_or_event
		end

feature -- ConsumerWrapper functions

	is_event: BOOLEAN is
			-- Is `Current' a .Net Event.
		do
			Result := True
		end
		
	is_public: BOOLEAN
			-- Is `Current' public.

feature -- Access

	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- List of eiffelized Consumed Entities relative to `Current'.
		do
			create Result.make (0)
			if adder /= Void then
				Result.extend (adder)
			end
			if remover /= Void then
				Result.extend (remover)
			end
			if raiser /= Void then
				Result.extend (raiser)
			end
		end

	dotnet_name: STRING
			-- .NET event name

	adder: CONSUMED_PROCEDURE
			-- Property getter function
	
	remover: CONSUMED_PROCEDURE
			-- Property setter procedure

	raiser: CONSUMED_PROCEDURE
			-- Property setter procedure

end -- class CONSUMED_EVENT

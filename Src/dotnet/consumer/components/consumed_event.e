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
			is_property_or_event,
			is_public
		end

create
	make

feature {NONE} -- Initialization

	make (dn: STRING; pub: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_raiser, cp_adder, cp_remover: CONSUMED_PROCEDURE) is
			-- Initialize property with name `n' and type `type'.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
		do
			dotnet_name := dn
			is_public := pub
			entity_make (dn, pub, decl_type)
			raiser := cp_raiser
			adder := cp_adder
			remover := cp_remover
		ensure
			dotnet_name_set: dotnet_name = dn
			raiser_set: raiser = cp_raiser
			adder_set: adder = cp_adder
			remover_set: remover = cp_remover
			valid_raiser: raiser /= Void implies raiser.is_property_or_event
		end

feature -- ConsumerWrapper functions

	is_event: BOOLEAN is
			-- Is `Current' a .Net Event.
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

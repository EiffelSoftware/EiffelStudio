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
			n := dn
			p := pub
			entity_make (dn, pub, decl_type)
			i := cp_raiser
			a := cp_adder
			r := cp_remover
		ensure
			dotnet_name_set: dotnet_name = dn
			raiser_set: raiser = cp_raiser
			adder_set: adder = cp_adder
			remover_set: remover = cp_remover
			valid_raiser: raiser /= Void implies raiser.is_property_or_event
		end

feature -- ConsumerWrapper functions

	is_event: BOOLEAN is True
			-- Is `Current' a .Net Event.
		
	is_property_or_event: BOOLEAN is True
			-- Is 'Current' a .NET Property or Event?
		
	is_public: BOOLEAN is
			-- Is `Current' public.
		do
			Result := p
		end

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

	dotnet_name: STRING is
			-- .NET event name
		do
			Result := n
		end

	adder: CONSUMED_PROCEDURE is
			-- Property getter function
		do
			Result := a
		end
	
	remover: CONSUMED_PROCEDURE is
			-- Property setter procedure
		do
			Result := r
		end

	raiser: CONSUMED_PROCEDURE is
			-- Property setter procedure
		do
			Result := i
		end

feature {NONE} -- Access

	n: like dotnet_name
			-- Internal data for `dotnet_name'.
	
	a: like adder
			-- Internal data for `adder'.
	
	r: like remover
			-- Internal data for `remover'.
	
	i: like raiser
			-- Internal data for `raiser'.
	
	p: like is_public
			-- Internal data for `is_public'.

end -- class CONSUMED_EVENT

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
	make

feature {NONE} -- Initialization

	make (dn: STRING; pub, stat: BOOLEAN; decl_type: CONSUMED_REFERENCED_TYPE; cp_getter: CONSUMED_FUNCTION; cp_setter: CONSUMED_PROCEDURE) is
			-- Initialize event.
		require
			non_void_dotnet_name: dn /= Void
			valid_dotnet_name: not dn.is_empty
			non_void_declaring_type: decl_type /= Void
			getter_or_setter: cp_getter = Void implies cp_setter /= Void
			getter_or_setter: cp_setter = Void implies cp_getter /= Void
		do
			n := dn
			p := pub
			t := stat
			entity_make (dn, pub, decl_type)
			g := cp_getter
			s := cp_setter
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
		
	is_public: BOOLEAN is
			-- Is `Current' public.
		do
			Result := p
		end
			
	is_static: BOOLEAN is
			-- Is `Current' static.
		do
			Result := t
		end

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

	dotnet_name: STRING is
			-- .NET property name
		do
			Result := n
		end

	getter: CONSUMED_FUNCTION is
			-- Property getter function
		do
			Result := g
		end
	
	setter: CONSUMED_PROCEDURE is
			-- Property setter procedure
		do
			Result := s
		end

feature {NONE} -- Access

	n: like dotnet_name
			-- Internal data for `dotnet_name'.
	
	g: like getter
			-- Internal data for `getter'.
	
	s: like setter
			-- Internal data for `setter'.
	
	p: like is_public
			-- Internal data for `is_public'.
	
	t: like is_static
			-- Internal data for `is_static'.

end -- class CONSUMED_PROPERTY

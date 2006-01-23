indexing

	description:
		"Routines to get the generic type of a container."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SUPPORT_CLASS

feature

	is_supported_container (some: ANY): BOOLEAN is
			-- `some' is a supported container?
		require
			some_not_void: some /= Void
		do
			Result := is_array (some) or else is_traversable (some)
		ensure
			Result = (is_array (some) or else is_traversable (some))
		end;

	contents (any: ANY): ANY is
		require
			any_not_void: any /= Void
		local
			traversable: TRAVERSABLE [ANY];
			array: ARRAY [ANY]
		do
			if is_array (any) then
				array ?= any;
				Result := array_contents (array)
			elseif is_traversable (any) then
				traversable ?= any;
				Result := traversable_contents (traversable)
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE}

	is_array (some: ANY): BOOLEAN is
			-- `some' is an array?
		require
			some_not_void: some /= Void
		local
			obj: ARRAY [ANY]
		do
			obj ?= some;
			Result := obj /= Void;
		end;

	is_traversable (some: ANY): BOOLEAN is
			-- `some' is a traversable object?
		require
			some_not_void: some /= Void
		local
			obj: TRAVERSABLE [ANY]
		do
			obj ?= some;
			Result := obj /= Void;
		end;

	array_contents (array: ARRAY [ANY]): ANY is
			-- What is the generic type of `array'?
		require
			array_not_void: array /= Void;
			array_not_empty: not array.is_empty;
			lower_item_not_void: array.item (array.lower) /= Void
		do
			Result := array.item (array.lower)
		ensure
			result_not_void: Result /= Void;
			Result = array.item (array.lower)
		end;

	traversable_contents (traversable: TRAVERSABLE [ANY]): ANY is
			-- What is the generic type of `traversable'?
		require
			traversable_not_void: traversable /= Void;
			traversable_not_empty: not traversable.is_empty
		do
			traversable.start;
			Result := traversable.item
		ensure
			result_not_void: Result /= Void;
			Result = traversable.item
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SUPPORT_CLASS



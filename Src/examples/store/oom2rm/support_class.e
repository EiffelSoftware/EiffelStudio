note

	description:
		"Routines to get the generic type of a container."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SUPPORT_CLASS

feature

	is_supported_container (some: ANY): BOOLEAN
			-- `some' is a supported container?
		require
			some_not_void: some /= Void
		do
			Result := is_array (some) or else is_traversable (some)
		ensure
			Result = (is_array (some) or else is_traversable (some))
		end;

	contents (any: ANY): ANY
		require
			any_not_void: any /= Void
		local
			l_result: detachable like contents
		do
			if is_array (any) then
				if attached {ARRAY [ANY]} any as array then
					l_result := array_contents (array)
				else
					check False end -- implied by `is_array'
				end
			elseif is_traversable (any) then
				if attached {TRAVERSABLE [ANY]} any as traversable then
					l_result := traversable_contents (traversable)
				else
					check False end -- implied by `is_traversable'
				end
			end
			check l_result /= Void end -- implied by previous if clauses
			Result := l_result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE}

	is_array (some: ANY): BOOLEAN
			-- `some' is an array?
		require
			some_not_void: some /= Void
		do
			Result := attached {ARRAY [ANY]} some
		end;

	is_traversable (some: ANY): BOOLEAN
			-- `some' is a traversable object?
		require
			some_not_void: some /= Void
		do
			Result := attached {TRAVERSABLE [ANY]} some
		end;

	array_contents (array: ARRAY [ANY]): ANY
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

	traversable_contents (traversable: TRAVERSABLE [ANY]): ANY
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

note
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



indexing
	description : "Objects used to represents DBG_EXPRESSION_EVALUATOR 's result"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EVALUATED_VALUE

create
	make,
	make_failed,
	make_with_value,
	make_clone

feature {NONE} -- Initialization

	make
			-- Instanciate Current
		do
		end

	make_failed
			-- Instanciate Current as failed
		do
			make
			failed := True
		end

	make_with_value (v: like value)
			-- Instanciate Current with value `v'
		require
			v_attached: v /= Void
		do
			make
			set_value (v)
			update
		end

	make_clone (v: DBG_EVALUATED_VALUE)
			-- Make Current a clone of `v'
		do
			make
			value := v.value
			static_class := v.static_class
			dynamic_class := v.dynamic_class
			dynamic_type := v.dynamic_type
			failed := v.failed --?
		end

feature -- Access

	static_class: CLASS_C assign set_static_class
			-- Static class

	dynamic_class: CLASS_C assign set_dynamic_class
			-- Dynamic class

	dynamic_type: CLASS_TYPE assign set_dynamic_type
			-- Dynamic type

	value: DUMP_VALUE assign set_value
			-- Value

feature -- Status report

	has_value: BOOLEAN
			-- Has Current.value not Void?
		do
			Result := value /= Void
		end

	has_attached_value: BOOLEAN
			-- Has Current a non Void `value'?
		do
			Result := value /= Void and then not value.is_void
		end

	same_as (other: DBG_EVALUATED_VALUE): BOOLEAN
			-- Do `Current' and `other' represent the same object, in the equality sense?
		require
			other_attached: other /= Void
		do
			Result := (not has_value and not other.has_value) or else (value.same_as (other.value))
			--| FIXME: maybe we should also compare class and type values
		end

	failed: BOOLEAN assign set_failed
			-- Does current represent a failure?
			-- (error occurred)

feature -- Basic operation

	reset
			-- Reset data
		do
			static_class := Void
			dynamic_class := Void
			dynamic_type := Void
			value := Void
		end

	update
			-- Update all data regarding current provided data
			--| for instance, if there is a non void `value',
			--| it can find out the static and dynamic class, and the dynamic type
		local
			dc: CLASS_C
			dt: CLASS_TYPE
			v: like value
		do
			v := value
			if v /= Void then
				if dynamic_type = Void then
					dynamic_type := v.dynamic_class_type
				end
				dt := dynamic_type
				if dynamic_class = Void then
					if dt /= Void then
						dynamic_class := dt.associated_class
					else
						dynamic_class := v.dynamic_class
					end
				end
--| Check if we want to set a default value for static_class				
--				dc := dynamic_class
--				if static_class = Void then
--					if dc /= Void then
--						static_class := dc
--					end
--				end
			else
				dc := dynamic_class
				if dc = Void then
					dt := dynamic_type
					if dt /= Void then
						dynamic_class := dt.associated_class
					end
--| Check if we want to set a default value for static_class				
--					dc := dynamic_class
--					if static_class = Void then
--						static_class := dc
--					end
				end
			end
		ensure
			dynamic_class_associated_with_dynamic_type: dynamic_type /= Void implies dynamic_class /= Void and then dynamic_type.associated_class = dynamic_class
			dynamic_class_conformed_to_static_class: (dynamic_class /= Void and static_class /= Void) implies dynamic_class.conform_to (static_class)
			data_associated_with_value: value /= Void implies (value.dynamic_class = dynamic_class)
		end

feature -- Status setting

	set_failed (v: like failed)
			-- Set `failed' to `v'
		do
			failed := v
		end

feature -- Element change

	suggest_static_class (v: like static_class)
			-- Set `static_class' to `v' if possible
		require
			v_attached: v /= Void
		do
			if static_class = Void then
				if {dc: like dynamic_class} dynamic_class then
					if dc.conform_to (v) then
						static_class := v
					end
				else
					static_class := v
				end
			elseif v.conform_to (static_class) then
				static_class := v
			end
		end

	set_static_class (v: like static_class)
			-- Set `static_class' to `v'
		do
			static_class := v
		end

	set_dynamic_class (v: like dynamic_class)
			-- Set `dynamic_class' to `v'
		do
			dynamic_class := v
		end

	set_dynamic_type (v: like dynamic_type)
			-- Set `dynamic_type' to `v'
		do
			dynamic_type := v
		end

	set_value (v: like value)
			-- Set `value' to `v'
		do
			value := v
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

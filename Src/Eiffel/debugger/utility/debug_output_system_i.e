note
	description: "Objects that helps to manage DEBUG_OUTPUT.debug_output feature ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUG_OUTPUT_SYSTEM_I

inherit
	ANY

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

feature -- Access

	debuggable_class_name: STRING = "DEBUG_OUTPUT"

	debuggable_feature_name: STRING = "debug_output"

	debug_output_feature_i (c: CLASS_C): FEATURE_I
		require
			class_not_void: c /= Void
		local
			l_rout_id: INTEGER
		do
			l_rout_id := debug_output_feature.rout_id_set.first
			Result := c.feature_of_rout_id (l_rout_id)
		end

	debuggable_class: CLASS_C
			-- Class that provides the `debug_output' interface, if any.
		local
			cis: LIST [CLASS_I]
			lc: CLASS_C
		do
			lc := internal_debuggable_class.item
			if lc = Void then
				cis := Eiffel_universe.compiled_classes_with_name (debuggable_class_name)
				if not cis.is_empty then
					Result := cis.first.compiled_class
				end
				internal_debuggable_class.put (Result)
			elseif not lc.is_valid then
				cis := Eiffel_universe.compiled_classes_with_name (debuggable_class_name)
				if not cis.is_empty then
					Result := cis.first.compiled_class
				end
				internal_debuggable_class.put (Result)
					-- The DEBUG_OUTPUT class has changed. Reset the debug feature.
				Internal_debug_output_feature.put (Void)
			else
				Result := lc
			end
		end

	debug_output_feature: E_FEATURE
			-- E_feature that corresponds to {DEBUG_OUTPUT}.debug_output.
		do
			if
				internal_debug_output_feature.item = Void
			then
				internal_debug_output_feature.put (
					debuggable_class.feature_with_name_32 (debuggable_feature_name))
			end
			Result := internal_debug_output_feature.item
		end

	internal_debuggable_class: CELL [CLASS_C]
			-- Last computed `debuggable_class'.
		once
			create Result.put (Void)
		end

	internal_debug_output_feature: CELL [E_FEATURE]
			-- Last computed `debug_output_feature'.
		once
				--| Fixme: we might want to "update" the feature
				--| after compilation in case it changed
				--| the case might be very rare ...
				--| but could occurs for Eiffel "kernel" developper
			create Result.put (Void)
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class DEBUG_OUTPUT_SYSTEM_I

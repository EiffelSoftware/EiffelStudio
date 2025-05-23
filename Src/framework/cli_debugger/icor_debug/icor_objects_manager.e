﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_OBJECTS_MANAGER

inherit
	ICOR_EXPORTER

create {SHARED_ICOR_OBJECTS_MANAGER}
	make

feature {NONE} -- Initialization

	make
		do
			create modules.make (50)
			create classes.make (100)
			create functions.make (500)
		end

feature -- Cleaning

	clean
			--
		do
			clean_modules
			clean_classes
			clean_functions
		end

	clean_modules
		local
			l_module: ICOR_DEBUG_MODULE
		do
			from
				modules.start
			until
				modules.after
			loop
				l_module := modules.item_for_iteration
				l_module.clean_on_dispose
				modules.forth
			end
			modules.wipe_out
		end

	clean_classes
		local
			l_class: ICOR_DEBUG_CLASS
		do
			from
				classes.start
			until
				classes.after
			loop
				l_class := classes.item_for_iteration
				l_class.clean_on_dispose
				classes.forth
			end
			classes.wipe_out
		end

	clean_functions
		local
			l_function: ICOR_DEBUG_FUNCTION
		do
			from
				functions.start
			until
				functions.after
			loop
				l_function := functions.item_for_iteration
				l_function.clean_on_dispose
				functions.forth
			end
			functions.wipe_out
		end

feature {SHARED_ICOR_OBJECTS_MANAGER, ICOR_EXPORTER} -- Access

	icd_module (p: POINTER; a_factory: ICOR_DEBUG_FACTORY_I): ICOR_DEBUG_MODULE
		require
			pointer_valid: p /= default_pointer
		do
			if attached modules.item (p) as l_found_item then
				Result := l_found_item
			else
				Result := a_factory.new_module (p)
				Result.add_ref
				modules.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: modules.has (Result.item)
		end

	icd_class (p: POINTER; a_factory: ICOR_DEBUG_FACTORY_I): ICOR_DEBUG_CLASS
		require
			pointer_valid: p /= default_pointer
		do
			if attached classes.item (p) as l_found_item then
				Result := l_found_item
			else
				Result := a_factory.new_class (p)
				Result.add_ref
				classes.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: classes.has (Result.item)
		end

	icd_function (p: POINTER; a_factory: ICOR_DEBUG_FACTORY_I): ICOR_DEBUG_FUNCTION
		require
			pointer_valid: p /= default_pointer
		do
			if attached functions.item (p) as l_found_item then
				Result := l_found_item
			else
				Result := a_factory.new_function (p)
				Result.add_ref
				functions.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: functions.has (Result.item)
		end

feature {NONE} -- Implementation

	modules: HASH_TABLE [ICOR_DEBUG_MODULE, POINTER]

	classes: HASH_TABLE [ICOR_DEBUG_CLASS, POINTER]

	functions: HASH_TABLE [ICOR_DEBUG_FUNCTION, POINTER];

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

end

indexing
	description: "Abstract description of a routine beeing exported."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	DYNAMIC_LIB_EXPORT_FEATURE

inherit
	SHARED_EIFFEL_PROJECT

create
	make
	
feature -- Initialization

	make (ec: CLASS_C; ecr: E_FEATURE; ef: E_FEATURE)  is
			-- Creation of an exported feature
			--| By default there is no alias name and no index
		do
			compiled_class := ec
			creation_routine := ecr
			routine := ef
		end

feature -- Attributes

	compiled_class : CLASS_C
			-- Class where routine is written in.

	creation_routine: E_FEATURE
			-- Feature description of the creation routine needed
			-- before doing the call of exported routine.

	routine: E_FEATURE
			-- Exported feature.

	index: INTEGER
			-- Windows specific for DLL.

	alias_name: STRING
			-- Exported name of exported feature.

	call_type: STRING
			-- How exported function will be called from Windows DLL.

feature -- Access.

	feature_id: INTEGER is
			-- Routine id of exported feature.
		do
			Result := routine.feature_id
		ensure
			valid_result: Result > 0
		end

	exported_name: STRING is
			-- The name under which this feature is exported.
		do
			if has_alias then
				Result := alias_name
			elseif routine /= Void then
				Result := routine.name
			elseif creation_routine /= Void then
				Result := creation_routine.name
			end
		end

	synchronize is
			-- Update `Current' after a compilation.
			-- Try to update the class and features.
		do
			if creation_routine /= Void then
				creation_routine := creation_routine.updated_version
			end
			if routine /= Void then
				routine := routine.updated_version
			end
		end

feature -- Status

	has_index: BOOLEAN is
			-- Does `Current' specify an `index'?
		do
			Result := index > 0
		end

	has_alias: BOOLEAN is
			-- Does Current specify an `alias_name'?
		do
			Result := alias_name /= Void and then not alias_name.is_empty
		end

	has_call_type: BOOLEAN is
			-- Does Current specify a `call_type'?
		do
			Result := call_type /= Void and then not call_type.is_empty
		end

feature -- Settings

	set_compiled_class (c: CLASS_C) is
			-- Set `c' to `compiled_class'.
		do
			compiled_class := c
		ensure
			compiled_class_set: compiled_class = c
		end

	set_creation_routine (c: E_FEATURE) is
			-- Set `c' to `creation_routine'.
		do
			creation_routine := c
		ensure
			creation_routine_set: creation_routine = c
		end

	set_routine (r: E_FEATURE) is
			-- Set `c' to `routine'.
		do
			routine := r
		ensure
			routine_set: routine = r
		end

	set_index (v: INTEGER) is
			-- Set `v' to `index'
			--| Windows specific for DLLs.
			--| Has no effect on Unix systems.
		do
			index := v
		ensure
			index_set: index = v
		end

	remove_index is
			-- Remove the index.
			--| In fact, set it to 0 so that it is ignored when the .c file is generated.
		do
			index := 0
		end

	set_alias_name (name: STRING) is
			-- Set `name' to `alias_name'.
		require
			name_not_void: name /= Void
			name_exists: name.count > 0
		do
			alias_name := name.twin
		ensure
			alias_name_set: alias_name /= Void and then alias_name.is_equal (name)
		end

	remove_alias_name is
			-- Discard the current alias name if any.
		do
			alias_name := Void
		end

	set_call_type (name: STRING) is
			-- Set `name' to `call_type'.
		require
			name_not_void: name /= Void
			name_exists: name.count > 0
		do
			call_type := name.twin
		ensure
			call_type_set: call_type /= Void and then call_type.is_equal (name)
		end

	remove_call_type is
			-- Discard the current value of `call_type' if any.
		do
			call_type := Void
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

end -- class DLL_EXPORT_FEATURE

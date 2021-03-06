﻿note
	description: "Stone representing a compiled Eiffel class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CLASSC_STONE

inherit
	CLASSI_STONE
		rename
			make as classi_make
		redefine
			is_valid, synchronized_stone, is_dotnet_class,
			class_i, group, class_name, file_name,
			header, stone_signature, history_name
		end

	SHARED_LOCALE

create
	make

feature {NONE} -- Initialization

	make (a_class: CLASS_C)
			-- Copy all information from argument
			-- OR KEEP A REFERENCE?
		require
			a_class_attached: a_class /= Void
		do
			e_class := a_class
			classi_make (a_class.original_class)
		end

feature -- Properties

	e_class: detachable CLASS_C

	group: detachable CONF_GROUP
		do
			if attached e_class as c then
				Result := c.group
			end
		end

	class_name: detachable STRING
		do
			if attached e_class as c then
				Result := c.name
			end
		end

	class_i: detachable CLASS_I
		do
			if attached e_class as c then
				Result := c.lace_class
			end
		end

feature -- Access

	stone_signature: detachable STRING_32
		do
			if attached e_class as c then
				Result := c.class_signature
			end
		end

	history_name: STRING_32
		do
			create Result.make_from_string (Interface_names.s_Class_stone.twin)
			Result.append_string (stone_signature)
		end

	header: detachable STRING_GENERAL
			-- Display class name, class' cluster and class location in
			-- window title bar.
		do
			if attached e_class as c then
				if c.is_precompiled then
					Result := interface_names.l_classc_header_precompiled (eiffel_system.name,
																			eiffel_universe.target_name,
																			c.group.name,
																			stone_signature)
				else
					Result := interface_names.l_classc_header (eiffel_system.name,
																eiffel_universe.target_name,
																c.group.name,
																stone_signature,
																c.lace_class.file_name.name)
				end
			end
		end

	file_name: detachable like {ERROR}.file_name
			-- The one from CLASSC
		do
			if e_class /= Void then
				Result := e_class.file_name
			end
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			Result := attached e_class as c and then c.is_valid and then Precursor
		end

	is_dotnet_class: BOOLEAN
			-- <Precursor>
		do
			Result := attached e_class as c and then c.is_valid and then c.is_true_external
		end

feature -- Synchronization

	synchronized_stone: detachable CLASSI_STONE
			-- Clone of `Current' stone after a recompilation
			-- (May be Void if not valid anymore. It may also be a
			-- classi_stone if the class is not compiled anymore)
		do
			if attached e_class as c then
				if not c.is_valid then
					Result := Precursor
				elseif is_valid then
					Result := Current
				else
					Result := create {CLASSC_STONE}.make (e_class)
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

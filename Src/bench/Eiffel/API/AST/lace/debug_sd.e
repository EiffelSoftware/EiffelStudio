indexing
	description: "Debug clause description in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_SD

inherit
	OPTION_SD
		redefine
			is_debug
		end

	SHARED_DEBUG_LEVEL

create
	initialize

feature {NONE} -- Initialization

	initialize (v: BOOLEAN) is
			-- Create a new DEBUG AST node.
		do
			enabled := v
		ensure
			enabled_set: enabled = v
		end

feature -- Properties

	option_name: STRING is
		do
			if enabled then
				Result := "debug"
			else
				Result := "disabled_debug"
			end
		end

	is_debug: BOOLEAN is True
			-- Is the option a debug one?

	enabled: BOOLEAN
			-- Is current option active?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD; classes: HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD])
		is
		local
			debug_tag: DEBUG_TAG_I
			tag_value: STRING
			v: DEBUG_I
		do
			if enabled then
				if value /= Void then
					if value.is_no then
						v := No_debug
					elseif value.is_yes or value.is_all then
						v := Yes_debug
					elseif value.is_name then
						tag_value := value.value.as_lower
						create debug_tag.make
						debug_tag.tags.put (tag_value)
						v := debug_tag
					else
						error (value)
					end
				else
					v := No_debug
				end
				if v /= Void then
					if list = Void then
						from
							classes.start
						until
							classes.after
						loop
							classes.item_for_iteration.set_debug_level (v)
							classes.forth
						end
					else
						from
							list.start
						until
							list.after
						loop
								-- Class names are stored in upper, thus the conversion to
								-- upper cases for the lookup.
							classes.item (list.item.as_upper).set_debug_level (v)
							list.forth
						end
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class DEBUG_SD

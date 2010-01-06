indexing
	description: "[
		Struct representing FIND_DATA from the Windows SDK
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

	metadata: create {STRUCT_LAYOUT_ATTRIBUTE}.make ({LAYOUT_KIND}.explicit) [
			["char_set", {CHAR_SET}.auto]
		] end

expanded class
	FIND_DATA

feature -- Access

	creation_time_low: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (0) end
		end

	creation_time_high: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (4) end
		end

	last_access_time_low: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (8) end
		end

	last_access_time_high: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (12) end
		end

	last_write_time_low: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (16) end
		end

	last_write_time_high: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (20) end
		end

	n_file_size_high: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (24) end
		end

	n_file_size_low: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (28) end
		end

	dw_reserved_0: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (32) end
		end

	dw_reserved_1: INTEGER
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (36) end
		end

	file_name: SYSTEM_STRING
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (40) end,
				create {MARSHAL_AS_ATTRIBUTE}.make ({UNMANAGED_TYPE}.by_val_t_str) [
					["size_const", 256]
				] end
		end

	alternate_file_name: SYSTEM_STRING
		indexing
			metadata:
				create {FIELD_OFFSET_ATTRIBUTE}.make (1064) end,
				create {MARSHAL_AS_ATTRIBUTE}.make ({UNMANAGED_TYPE}.by_val_t_str) [
					["size_const", 14]
				] end
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

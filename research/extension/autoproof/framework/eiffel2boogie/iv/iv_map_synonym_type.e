class
	IV_MAP_SYNONYM_TYPE

inherit
	IV_MAP_TYPE
		rename
			make as make_map
		undefine
			default_value,
			type_inv,
			has_rank,
			rank_leq,
			is_equal,
			process
		end

	IV_USER_TYPE
		rename
			make as make_synonym
		undefine
			process
		end

create
	make

feature {NONE} -- Initialization

	make (a_type_params: ARRAY [STRING]; a_domain_types: like domain_types; a_range_type: IV_TYPE; a_constructor: READABLE_STRING_8; a_params: like parameters)
			-- Create a map type "<a_type_params>[a_domain_types]a_range_type" with synonym "a_constructor a_params".
		require
			a_type_params_exists: attached a_type_params
			a_domain_types_exists: attached a_domain_types
			a_range_type_exists: attached a_range_type
			a_constructor_exists: attached a_constructor
			a_params_exists: attached a_params
			all_params_exist: across a_params as p all attached p end
		do
			make_map (a_type_params, a_domain_types, a_range_type)
			make_synonym (a_constructor, a_params)
		end

feature -- Visitor

	process (a_visitor: IV_TYPE_VISITOR)
			-- Process type.
		do
			a_visitor.process_map_synonym_type (Current)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Nadia Polikarpova", "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end

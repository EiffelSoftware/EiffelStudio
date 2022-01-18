note
	description: "Item associated to a feature."

deferred class
	EBB_FEATURE_ASSOCIATION

inherit

	EBB_CLASS_ASSOCIATION

feature {NONE} -- Initialization

	make_with_class_and_feature_id (a_class_id: like class_id; a_feature_id: like feature_id)
			-- Initialize associated to feature with id `a_feature_id' in class with id `a_class_id'.
		require
			valid_class_id: a_class_id /= 0
			has_class_id: system.has_class_of_id (a_class_id)
			has_class: attached system.class_of_id (a_class_id) as c
			has_feature_table: c.has_feature_table
			valid_feature_id: a_feature_id > 0
			has_feature: attached c.feature_of_feature_id (a_feature_id)
		do
			make_with_class_id (a_class_id)
			feature_id := a_feature_id
		ensure
			class_id_set: class_id = a_class_id
			feature_id_set: feature_id = a_feature_id
		end

	make_with_feature (a_feature: attached like associated_feature)
			-- Initialize associated to `a_feature'.
		do
			make_with_class_and_feature_id (a_feature.written_in, a_feature.feature_id)
		ensure
			consistent: associated_feature.rout_id_set ~ a_feature.rout_id_set
		end

feature -- Access

	feature_id: INTEGER
			-- Feature ID of feature associated with this data.

	feature_name: STRING_32
			-- Name of feature associated with this data.
		do
			Result := associated_feature.feature_name_32
		end

	qualified_feature_name: STRING_32
			-- Name of feature associated with this data in the form {CLASS}.feature.
		do
			Result := {STRING_32} "{" + class_name + "}." + feature_name
		end

	associated_feature: FEATURE_I
			-- Feature associated with this data.
		do
			Result := compiled_class.feature_of_feature_id (feature_id)
		end

invariant
	feature_id_set: feature_id > 0
	associated_feature_set: associated_feature /= Void
	associated_feature_consistent: associated_feature.written_in = class_id and associated_feature.feature_id = feature_id

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2010-2011 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Alexander Kogtenkov"
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

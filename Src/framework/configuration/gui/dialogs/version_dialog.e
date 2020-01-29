note
	description: "Edit the version."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VERSION_DIALOG

inherit
	PROPERTY_DIALOG [CONF_VERSION]
		redefine
			create_interface_objects,
			initialize,
			on_ok
		end

	CONF_INTERFACE_CONSTANTS
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end

feature {NONE} -- Initialization

	create_interface_objects
		do
			Precursor
			create major
			create minor
			create release
			create build

			create product
			create company
			create copyright
			create trademark
		end

	initialize
			-- Initialization
		local
			l_label: EV_LABEL
			hb: EV_HORIZONTAL_BOX
		do
			Precursor {PROPERTY_DIALOG}

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

--			create major
			hb.extend (major)
			major.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
--			create minor
			hb.extend (minor)
			minor.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
--			create release
			hb.extend (release)
			release.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
--			create build
			hb.extend (build)
			build.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_product_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create product
			element_container.extend (product)
			element_container.disable_item_expand (product)
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_company_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create company
			element_container.extend (company)
			element_container.disable_item_expand (company)
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_copyright_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create copyright
			element_container.extend (copyright)
			element_container.disable_item_expand (copyright)
			append_small_margin (element_container)

			create l_label.make_with_text (conf_interface_names.target_trademark_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
--			create trademark
			element_container.extend (trademark)
			element_container.disable_item_expand (trademark)

			set_size (200, 0)
			show_actions.extend (agent on_show)
		end

feature {NONE} -- Gui elements

	major: EV_SPIN_BUTTON
	minor: EV_SPIN_BUTTON
	release: EV_SPIN_BUTTON
	build: EV_SPIN_BUTTON

	product: EV_TEXT_FIELD
	company: EV_TEXT_FIELD
	copyright: EV_TEXT_FIELD
	trademark: EV_TEXT_FIELD

feature {NONE} -- Agents

	on_show
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			if attached value as v then
				major.set_text (v.major.out)
				minor.set_text (v.minor.out)
				release.set_text (v.release.out)
				build.set_text (v.build.out)
				if attached v.product as s then
					product.set_text (s)
				end
				if attached v.company as s then
					company.set_text (s)
				end
				if attached v.copyright as s then
					copyright.set_text (s)
				end
				if attached v.trademark as s then
					trademark.set_text (s)
				end
			end
		end

	on_ok
			-- Ok was pressed.
		local
			l_version: CONF_VERSION
			l_maj, l_min, l_rel, l_bld: NATURAL_16
		do
			l_maj := major.value.to_natural_16
			l_min := minor.value.to_natural_16
			l_rel := release.value.to_natural_16
			l_bld := build.value.to_natural_16
			if
				l_maj + l_min + l_rel + l_bld > 0 or
				not (product.text.is_empty and company.text.is_empty and copyright.text.is_empty and trademark.text.is_empty)
			then
				create l_version.make_version (l_maj, l_min, l_rel, l_bld)
				l_version.set_product (product.text)
				l_version.set_company (company.text)
				l_version.set_copyright (copyright.text)
				l_version.set_trademark (trademark.text)
			end
			set_value (l_version)

			Precursor {PROPERTY_DIALOG}
		end

invariant
	elements: is_initialized implies minor /= Void and major /= Void and release /= Void and build /= Void and
			product /= Void and company /= Void and copyright /= Void and trademark /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

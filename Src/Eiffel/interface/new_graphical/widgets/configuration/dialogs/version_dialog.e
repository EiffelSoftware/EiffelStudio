indexing
	description: "Edit the version."
	date: "$Date$"
	revision: "$Revision$"

class
	VERSION_DIALOG

inherit
	PROPERTY_DIALOG [CONF_VERSION]
		redefine
			initialize,
			on_ok
		end

	CONF_INTERFACE_NAMES
		undefine
			default_create, copy
		end

	CONF_ACCESS
		undefine
			default_create, copy
		end


feature {NONE} -- Initialization

	initialize is
			-- Initialization
		local
			l_label: EV_LABEL
			hb: EV_HORIZONTAL_BOX
		do
			Precursor {PROPERTY_DIALOG}

			create hb
			element_container.extend (hb)
			element_container.disable_item_expand (hb)

			create major
			hb.extend (major)
			major.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
			create minor
			hb.extend (minor)
			minor.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
			create release
			hb.extend (release)
			release.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (hb)
			create build
			hb.extend (build)
			build.value_range.adapt (create {INTEGER_INTERVAL}.make (0, {NATURAL_16}.max_value))
			append_small_margin (element_container)

			create l_label.make_with_text (target_product_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create product
			element_container.extend (product)
			element_container.disable_item_expand (product)
			append_small_margin (element_container)

			create l_label.make_with_text (target_company_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create company
			element_container.extend (company)
			element_container.disable_item_expand (company)
			append_small_margin (element_container)

			create l_label.make_with_text (target_copyright_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create copyright
			element_container.extend (copyright)
			element_container.disable_item_expand (copyright)
			append_small_margin (element_container)

			create l_label.make_with_text (target_trademark_name)
			element_container.extend (l_label)
			element_container.disable_item_expand (l_label)
			l_label.align_text_left
			create trademark
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

	on_show is
			-- Called if the dialog is shown.
		require
			initialized: is_initialized
		do
			if value /= Void then
				major.set_text (value.major.out)
				minor.set_text (value.minor.out)
				release.set_text (value.release.out)
				build.set_text (value.build.out)
				if value.product /= Void then
					product.set_text (value.product)
				end
				if value.company /= Void then
					company.set_text (value.company)
				end
				if value.copyright /= Void then
					copyright.set_text (value.copyright)
				end
				if value.trademark /= Void then
					trademark.set_text (value.trademark)
				end
			end
		end

	on_ok is
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

end

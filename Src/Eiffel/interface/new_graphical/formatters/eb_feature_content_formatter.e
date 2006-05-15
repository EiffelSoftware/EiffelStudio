indexing
	description: "Formatter displaying feature information in a grid view."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FEATURE_CONTENT_FORMATTER

inherit
	EB_FEATURE_INFO_FORMATTER

	QL_UTILITY

	QL_SHARED

feature -- Formatting

	format is
			-- Refresh `widget'.
		do
			if associated_feature /= Void and then selected and then displayed then
				display_temp_header
				if not widget.is_displayed then
					widget.show
				end
				rebuild_browser
				generate_result
				display_header
			end
		end

feature -- Access

	browser: EB_FEATURE_BROWSER_GRID_VIEW
			-- Browser where information gets displayed

	widget: EV_WIDGET is
			-- Graphical representation of the information provided.
		do
			if associated_feature = Void or browser = Void then
				Result := empty_widget
			else
				Result := browser.widget
			end
		end

feature -- Setting

	reset_display is
			-- Clear all graphical output.
		do
			if browser /= Void then
				browser.reset_display
			end
		end

	set_browser (a_browser: like browser) is
			-- Set `browser' with `a_browser'.
		require
			a_browser_attached: a_browser /= Void
		do
			browser := a_browser
		ensure
			browser_set: browser = a_browser
		end

feature -- Status setting

	set_stone (new_stone: FEATURE_STONE) is
			-- Associate current formatter with feature contained in `new_stone'.
		do
			force_stone (new_stone)
			if new_stone /= Void then
				if (not new_stone.class_i.is_external_class) or is_dotnet_formatter then
					set_feature (new_stone.e_feature)
				end
			else
				associated_feature := Void
				if
					selected and then
					not widget.is_displayed
				then
					if widget_owner /= Void then
						widget_owner.set_widget (widget)
					end
					display_header
				end
			end
		end

	set_feature (a_feature: E_FEATURE) is
			-- Associate current formatter with `a_feature'.
		do
			associated_feature := a_feature
			if a_feature = Void or else not a_feature.associated_class.has_feature_table then
				associated_feature := Void
			end
			must_format := True
			format
			if
				selected and then
				not widget.is_displayed
			then
				if widget_owner /= Void then
					widget_owner.set_widget (widget)
				end
				display_header
			end
		ensure
			feature_set: a_feature = associated_feature
		end

feature{NONE} -- Implementation

	generate_result is
			-- Generate result for display
		local
			l_domain: QL_FEATURE_DOMAIN
			l_retried: BOOLEAN
		do
			if not l_retried then
				l_domain ?= system_target_domain.new_domain (domain_generator)
				browser.update (Void, l_domain)
			else
				browser.update (Void, Void)
			end
		rescue
			l_retried := True
			retry
		end

	domain_generator: QL_DOMAIN_GENERATOR is
			-- Domain generator to generate result				
		do
			create {QL_FEATURE_DOMAIN_GENERATOR}Result
			Result.enable_fill_domain
			Result.set_criterion (criterion)
		end

	criterion: QL_CRITERION is
			-- Criterion of current formatter
		deferred
		ensure
			result_attached: Result /= Void
		end

	rebuild_browser is
			-- Rebuild `browser'.
		require
			browser_attached: browser /= Void
		deferred
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

end

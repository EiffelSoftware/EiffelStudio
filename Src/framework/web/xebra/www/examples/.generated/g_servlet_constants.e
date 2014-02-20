note
	description: "[
		THIS IS A GENERATED FILE, DO NOT EDIT!
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	G_SERVLET_CONSTANTS

inherit
	ANY

feature-- Access

	class_temp_0: STRING = "<html>"

	class_temp_1: STRING = "%N"

	class_temp_2: STRING = "<head>"

	class_temp_3: STRING = "<style>"

	class_temp_4: STRING = "%N%/9/div.title { %N%/9/%/9/font-weight: bold; font-size: 110%%; %N%/9/%/9/margin: 5px;%N%/9/%/9/}%N%/9/div.example { %N%/9/%/9/padding: 10px; margin: 10px; %N%/9/%/9/background-color: #fff; %N%/9/%/9/border-top: solid 2px #000;%N%/9/%/9/}%N%/9/div.source { %N%/9/%/9/white-space: pre;  padding: 3px; %N%/9/%/9/font-size: 70%%;%N%/9/%/9/border: dotted 1px #99c;%N%/9/%/9/background-color: #fff; font-family: verdana; %N%/9/%/9/margin-bottom: 5px;%N%/9/%/9/}%N%/9/div.demo { %N%/9/%/9/clear:both; %N%/9/%/9/background-color: #ddddff; %N%/9/%/9/border: solid 1px #aae; %N%/9/%/9/padding: 5px; %N%/9/%/9/margin-top: 5px; %N%/9/%/9/}%N%/9/.xeb { float: left; width: 48%%}%N%/9/.eiffel { float: right; width: 48%%; }%N"

	class_temp_5: STRING = "</style>"

	class_temp_6: STRING = "</head>"

	class_temp_7: STRING = "<body>"

	class_temp_8: STRING = "<h1>"

	class_temp_9: STRING = "Xebra's quick tutorial by examples"

	class_temp_10: STRING = "</h1>"

	class_temp_11: STRING = "%N%N"

	class_temp_12: STRING = "<div class=%"example%">"

	class_temp_13: STRING = "<div class=%"title%">"

	class_temp_14: STRING = "xeb:display's example:"

	class_temp_15: STRING = "</div>"

	class_temp_16: STRING = "%N%/9/"

	class_temp_17: STRING = "<div class=%"source xeb%">"

	class_temp_18: STRING = "%N%/9/%/9/&lt;xeb:display text=%"This is a text%" /&gt;%N%/9/"

	class_temp_19: STRING = "<div class=%"demo%">"

	class_temp_20: STRING = "Calling the controller:"

	class_temp_21: STRING = "%N%/9/&lt;html&gt;%N%/9/&lt;page:controller class=%"MAIN_CONTROLLER%" create=%"make%"/&gt;%N%/9/....%N%/9/&lt;body&gt;%N%/9/&lt;xeb:display text=%"%%=the_text%%%" /&gt;%N%/9/"

	class_temp_22: STRING = "<div class=%"source eiffel%">"

	class_temp_23: STRING = "%N%/9/the_text: STRING%N%/9/%/9/do%N%/9/%/9/%/9/Result := %"This is a text%"%N%/9/%/9/end%N%/9/"

	class_temp_24: STRING = "xeb:loop's example:"

	class_temp_25: STRING = "%N%/9/&lt;ol&gt;%N%/9/&lt;xeb:loop times=%"5%" variable=%"loop_index%" &gt;%N%/9/&lt;li&gt;item &lt;xeb:display text=%"#{loop_index.out}%" /&gt;&lt;/li&gt;%N%/9/&lt;/xeb:loop&gt;%N%/9/&lt;/ol&gt;%N%/9/"

	class_temp_26: STRING = "%N%N%/9/"

	class_temp_27: STRING = "%N%/9/%/9/"

	class_temp_28: STRING = "<ol>"

	class_temp_29: STRING = "<li>"

	class_temp_30: STRING = "item "

	class_temp_31: STRING = "</li>"

	class_temp_32: STRING = "</ol>"

	class_temp_33: STRING = "%N%N%N"

	class_temp_34: STRING = "xeb:iterate's example:"

	class_temp_35: STRING = "%N%/9/&lt;ul&gt;%N%/9/&lt;xeb:iterate list=%"%%=my_items%%%" variable=%"entry%" type=%"STRING%" &gt;%N%/9/&lt;li&gt;&lt;xeb:display text=%"#{entry}%" /&gt;&lt;/li&gt;%N%/9/&lt;/xeb:iterate&gt;%N%/9/&lt;/ul&gt;%N%/9/"

	class_temp_36: STRING = "%N%/9/my_items: ARRAYED_LIST [STRING]%N%/9/%/9/do%N%/9/%/9/%/9/create Result.make (3)%N%/9/%/9/%/9/Result.force (%"a%")%N%/9/%/9/%/9/Result.force (%"b%")%N%/9/%/9/%/9/Result.force (%"c%")%N%/9/%/9/end%N%/9/"

	class_temp_37: STRING = "<ul>"

	class_temp_38: STRING = "</ul>"

	class_temp_39: STRING = "xeb:set_variable's example:"

	class_temp_40: STRING = "%N%/9/&lt;xeb:set_variable variable=%"doc_url%" value=%"%%=xebra_documentation_url%%%" type=%"STRING%" /&gt;%N%/9/Check the Xebra's documentation: &lt;a href=%"#{doc_url}%"&gt;&lt;xeb:display text=%"#{doc_url}%"/&gt; &lt;/a&gt;%N%/9/"

	class_temp_41: STRING = "%N%/9/%/9/%/9/Result := %"http://dev.eiffel.com/Xebra_Documentation%"%N%/9/"

	class_temp_42: STRING = "%N%/9/Check the Xebra's documentation: "

	class_temp_43: STRING = " "

	class_temp_44: STRING = "</a>"

	class_temp_45: STRING = "xeb:concat's example:"

	class_temp_46: STRING = "%N%/9/&lt;xeb:set_variable variable=%"aplusb%" value=%"PLUS%" type=%"STRING%" /&gt;%N%/9/&lt;xeb:concat variable=%"aplusb%" left=%"a%" right=%"b%" /&gt;%N%/9/&lt;xeb:display text=%"#{aplusb}%" /&gt;%N%/9/"

	class_temp_47: STRING = "</body>"

	class_temp_48: STRING = "</html>"

feature-- Implementation

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
		]"end

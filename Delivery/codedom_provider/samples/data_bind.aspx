<HTML>
	<HEAD>
		<!-- Inheritance clause snippet, must start with "inherit"-->
		<SCRIPT RUNAT="server">
			inherit
				WEB_PAGE
					redefine
						on_load
					end
		</SCRIPT>

		<SCRIPT LANGUAGE="Eiffel" RUNAT="server">
			on_load (e: EVENT_ARGS) is
					-- Initialize values used for data binding.
				local
					l_values: ARRAY_LIST
					l_res: SYSTEM_OBJECT
				do
					if not is_post_back then
						create l_values.make
						l_res := l_values.add (0)
						l_res := l_values.add (1)
						l_res := l_values.add (2)
						l_res := l_values.add (3)
						l_res := l_values.add (4)
						l_res := l_values.add (5)
						l_res := l_values.add (6)
						data_list.set_data_source (l_values)
						data_list.data_bind
					end
				end

			even_or_odd (a_number: SYSTEM_OBJECT): SYSTEM_STRING is
					-- "Even" if `a_number' is even, "Odd" otherwise
				local
					l_number: INTEGER
				do
					l_number ?= a_number
					if l_number \\ 2 /= 0 then
						Result := "Odd"
					else
						Result := "Even"
					end
				ensure
					valid_result: Result.equals (("Odd").to_cil) or Result.equals (("Even").to_cil)
				end
		</SCRIPT>
	</HEAD>
	<BODY>
		<H3><FONT FACE="Verdana">Databinding to Methods and Expressions</FONT></H3>

		<FORM RUNAT=server>
			<ASP:DataList Id="data_list" RUNAT="server" BorderColor="black" BorderWidth="1" GridLines="Both" CellPadding="3" CellSpacing="0">
				<ItemTemplate>
					Number Value: <%# container.data_item %>
					Even/Odd: <%# even_or_odd (container.data_item) %>
				</ItemTemplate>
			</ASP:DataList>
		</FORM>
	</BODY>
</HTML>


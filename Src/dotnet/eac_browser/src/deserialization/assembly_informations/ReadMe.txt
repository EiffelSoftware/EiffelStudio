Hypotheses:

Structure:
<doc>
	<assembly>
		<name>
		</name>
	</assembly>
	<members>
		<member name="T:my_class">
			<summary>
				<para>
					text... 
					<see cref="T:my_class"/>
					<see cref="M:my_method"/>
					<see cref="P:my_property"/>
					<see cref="F:my_???"/>
					<see langword="a_keyword"/>
					<paramref name="my_parameter"/>
					text...
				</para>
				<para>
					...
				<para>
			</summary>
		</member>
		<member name="M:my_method(...,...)">
			<summary>
				<para>summary...</para>
			</summary>
			<param name="my_parameter">description param
			</param>
			<param name="my_second_parameter">description param
			</param>
			<returns>
				<para>summary...</para>
			</returns>
		</member>
		<member name="P:my_property">
		</member>
		<member name="F:my_field">
		</member>
	</members>
</doc>



The tag <member> is the most important one, because that is the one whose going a give access to the informations (comments) relative to a class or a Feature.
Its parameter name is compose as followed:
	-- the first charater determines the Type of the node. T for a Type, M for a Method, P for a Property and F for a Field
	-- the second character is a semi colon (:)
	-- the end is:
				* the full dotnet type name for a Type (T)
				* the complete signature of the Method for a Method (M).
				* the full dotnet name for a Property (P)
				* the full dotnet name for a Field (F)

				
The tag <para> means the text in this tag make a paragraph.

The tag <param> describe the parameters of a Method. Its first argument name is the name of the parameter. The text contained between the opening and the closing tag is the description of the parameter.

The tag <returns> describe the returns of a Method.

The tags <see> and <paramref> are interpreted as a text.